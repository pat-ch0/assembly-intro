section .data
    message db 'Enter a number: ', 0
    result_msg db 'The integer square root of ', 0
    buffer times 16 db 0 ; buffer to hold user input

section .bss
    x resd 1 ; reserve space to store x
    n resd 1 ; reserve space to store n

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
    je convert ; if it is, jump to "convert" label
    sub byte [eax + ecx], '0' ; subtract ASCII code for '0' to get numeric value
    mov ebx, 10 ; move 10 to EBX
    mul ebx ; multiply EAX by EBX
    inc ecx ; increment loop counter
    jmp loop1 ; repeat loop
convert:
    mov ecx, -1 ; initialize loop counter to -1
loop2:
    inc ecx ; increment loop counter
    mov dword [x], ecx ; set x to current loop counter
    mov ebx, dword [n] ; move n to EBX
    mul ebx ; multiply EAX by EBX (calculate x^2)
    cmp eax, dword [n] ; compare x^2 with n
    jg print_result ; if x^2 > n, jump to "print_result" label
    jmp loop2 ; otherwise, repeat loop
print_result:
    ; print result message
    mov eax, 4 ; system call number for "write"
    mov ebx, 1 ; file descriptor for stdout
    mov ecx, result_msg ; message to write
    mov edx, 27 ; length of message
    int 0x80 ; invoke system call

    ; print n
    mov eax, 4 ; system call number for "write"
    mov ebx, 1 ; file descriptor for stdout
    mov ecx, buffer ; message to write (original input string)
    mov edx, 16 ; length of message
    int 0x80 ; invoke system call

    ; print integer square root (x - 1)
    dec dword [x] ; subtract 1 from x
    mov eax, 4 ; system call number for "write"
    mov ebx, 1 ; file descriptor for stdout
    mov ecx, dword [x] ; message to write (integer square root)
    add ecx, '0' ; add ASCII code for '0' to convert to character
    mov edx, 1 ; length of message (1 byte)
    int 0x80 ; invoke system call

    ; exit program
    mov eax, 1 ; system call number for "exit
    mov ebx, 0
    int 80h
