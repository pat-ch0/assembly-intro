section .data
    message db 'Enter a number: ', 0
    prime_msg db 'The number is prime', 0
    not_prime_msg db 'The number is not prime', 0
    buffer times 16 db 0 ; buffer to hold user input

section .bss
    n resd 1 ; reserve space to store n
    divisor resd 1 ; reserve space to store current divisor

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
    je check_prime ; if it is, jump to "check_prime" label
    sub byte [eax + ecx], '0' ; subtract ASCII code for '0' to get numeric value
    mov ebx, 10 ; move 10 to EBX
    mul ebx ; multiply EAX by EBX
    inc ecx ; increment loop counter
    jmp loop1 ; repeat loop
check_prime:
    ; initialize divisor to 2
    mov dword [divisor], 2

    ; check if n is divisible by any integer between 2 and n-1
loop2:
    mov eax, dword [n] ; move n to EAX
    cdq ; sign-extend EAX into EDX:EAX
    div dword [divisor] ; divide EAX by divisor
    cmp edx, 0 ; check if remainder is zero
    je not_prime ; if it is, jump to "not_prime" label
    inc dword [divisor] ; increment divisor
    cmp dword [divisor], dword [n] ; check if divisor is greater than or equal to n
    jge prime ; if it is, jump to "prime" label
    jmp loop2 ; otherwise, repeat loop

not_prime:
    ; print "not prime" message
    mov eax, 4 ; system call number for "write"
    mov ebx, 1 ; file descriptor for stdout
    mov ecx, not_prime_msg ; message to write
    mov edx, 21 ; length of message
    int 0x80 ; invoke system call

    ; exit program
    mov eax, 1 ; system call number for "exit"
    xor ebx, ebx ; set exit status to 0
    int 0x80 ; invoke system call

prime:
    ; print "prime" message
    mov eax, 4 ; system call number for "write"
    mov ebx, 1 ; file descriptor for stdout
    mov ecx, prime_msg ; message to write
    mov edx, 16 ; length of message
    int 0x80 ; invoke system call

    ; exit program
    mov eax, 1 ; system
    mov ebx, 0
    int 80h
