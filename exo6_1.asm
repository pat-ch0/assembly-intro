section .data
    message db 'Enter a number: ', 0
    result_msg db 'Result: ', 0
    buffer times 16 db 0 ; buffer to hold user input

section .bss
    n resd 1 ; reserve space to store n
    result resd 1 ; reserve space to store result

section .text
    global _start

_start:
    ; print message
    mov eax, 4 ; system call number for "write"
    mov ebx, 1 ; file descriptor for stdout
    mov ecx, message ; message to write
    mov edx, 18 ; length of message
    int 0x80 ; invoke system call

    ; read user input
    mov eax, 3 ; system call number for "read"
    mov ebx, 0 ; file descriptor for stdin
    mov ecx, buffer ; buffer to hold input
    mov edx, 16 ; maximum number of bytes to read
    int 0x80 ; invoke system call

    ; convert user input to integer n
    mov eax, buffer ; move buffer address to EAX
    mov ecx, 0 ; initialize loop counter
loop1:
    cmp byte [eax + ecx], 0 ; check if byte is null terminator
    je factorial ; if it is, jump to "factorial" label
    sub byte [eax + ecx], '0' ; subtract ASCII code for '0' to get numeric value
    mov ebx, 10 ; move 10 to EBX
    mul ebx ; multiply EAX by EBX
    inc ecx ; increment loop counter
    jmp loop1 ; repeat loop

factorial:
    ; save current stack frame
    push ebp ; save old base pointer
    mov ebp, esp ; set new base pointer

    ; check if n is 0 or 1
    mov eax, dword [n] ; move n to EAX
    cmp eax, 1 ; check if n is equal to 1
    je base_case ; if it is, jump to "base_case" label
    cmp eax, 0 ; check if n is equal to 0
    je base_case ; if it is, jump to "base_case" label

    ; decrement n and call the factorial function recursively
    dec eax ; decrement n
    mov dword [n], eax ; save new value of n
    call factorial ; call the factorial function recursively
    mov ebx, eax ; move the result of the recursive call to EBX

    ; compute factorial and return result
    mov eax, dword [n] ; move n to EAX
    mul ebx ; multiply EAX by EBX
    mov dword [result], eax ; save result to "result" variable
    jmp end ; jump to "end" label

base_case:
    ; return 1 as the result
    mov eax, 1 ; move 1 to EAX
    mov dword [result], eax ; save result to "result" variable

end:
    ; print result
    mov eax, 4 ; system call number for "write"
    mov ebx, 1 ; file descriptor for stdout
    mov ecx, result_msg ; message to write
    mov edx, 8 ; length of message
    int 0x80 ; invoke system call

    ; convert result to string and print it
    mov eax, dword [result] ; move result to EAX
    call print_int ; call "print_int" subroutine

    ; exit program
    mov eax, 1
    mov ebx, 0
    mov 80h
