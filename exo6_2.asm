section .data
    prompt db "Enter a positive integer: ", 0
    result db "The result is: ", 0
    newline db 10, 0
    
section .bss
    n resb 2
    
section .text
    global _start

_start:
    ; print prompt and read user input
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 25
    int 0x80
    mov eax, 3
    mov ebx, 0
    mov ecx, n
    mov edx, 2
    int 0x80
    
    ; convert user input to integer
    xor ebx, ebx
    mov bl, byte [n+1]
    sub ebx, 0x30
    mov ecx, ebx
    
    ; calculate nth term of Fibonacci sequence
    push ecx
    call fib
    add esp, 4
    
    ; print result
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 16
    int 0x80
    mov eax, 4
    mov ebx, 1
    mov ecx, eax
    add ecx, [esp-4]
    mov edx, 1
    int 0x80
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    
    ; exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80
    
fib:
    ; calculate nth term of Fibonacci sequence using recursion
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]
    cmp eax, 0
    jz fib_zero_or_one
    cmp eax, 1
    jz fib_zero_or_one
    dec eax
    push eax
    call fib
    mov ebx, eax
    dec [ebp+8]
    push [ebp+8]
    call fib
    add esp, 4
    add eax, ebx
    jmp fib_exit
fib_zero_or_one:
    mov eax, 1
fib_exit:
    mov esp, ebp
    pop ebp
    ret
