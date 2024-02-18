section .data
message: db 'Bonjour chez vous !', 10
message2: db 'Hello there', 10
longueur: equ $-message
longueur2: equ $-message2
val: times 100 db 0
section .text
global _start
_start:
    mov eax, 3
    mov ebx, 0
    mov ecx, val
    mov edx, 100
    int 80h
    mov eax, 4
    mov ebx, 1
    mov ecx, val
    mov edx, 100
    int 80h
    mov eax, 1
    mov ebx, 0
    int 80h
