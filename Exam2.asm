section .data
    message db 'Enter a string: ', 0
    val db '0'					;initialisation de val			

section .text
    global _start

_start:
    mov al, 0					;initialisation de al qui contiendra la somme
    mov eax, 4					;write
    mov ebx, 1					;stdout
    mov ecx, message				;demande d'entrer la chaîne
    mov edx, 15				;taille du message
    int 80h					;syscall

    mov eax, 3					;read
    mov ebx, 0					;stdin
    mov ecx, val				;string au clavier
    mov edx, 100				;taille de la string
    int 80h					;syscall

loop:
    cmp word [val], 10				;comparaison val avec 10
    je loop					;si dedans on continue
    cmp word[val], '0'				;on regarde si c'est avant '0'
    jb fin_loop				;si oui fin loop
    cmp word[val], '9'				;on regarde si c'est après '9'
    ja fin_loop				;si oui fin loop
    sub word [val], '0'			;on soustraie val avec 0
    pop eax					;on enlève eax de la pile
    imul eax, 10				;multiplication de eax avec 10
    push eax					;on remet eax dans la pile
    add al, [eax]				;addition eax avec al
    jmp loop					;on recommence

fin_loop:
    pop eax					;enlève eax pile
    ret					;fin

mov ecx, eax					;met la chaine à afficher dans ecx
mov eax, 4					
mov ebx, 1
mov edx, lenVal
int 80h

mov eax, 1
mov ebx, 0
int 80h
