section .data
save db 0 ;sauvegarde la valeur temporaire 

section .text
global _start

_start:
	mov eax, 234		;initialise eax à 234
	mov ebx, 10 		;initialise ebx à 10
	mov edx, 0 		;initialise edx à 0
	idiv ebx 		;divise eax par ebx
	mov [save], eax 	;sauvegarde le quotient dans "save" (23)
	mov eax, 4 		;write
	mov ebx, 1 		;stdout
	mov ecx, edx 		;met le reste dans ecx
	mov edx, 1 		;taille d'un entier
	int 80h 		;syscall
	mov eax, save		;eax devient save 
	mov ebx, 10
	idiv ebx
	mov eax, 4
	mov ebx, 1
	mov ecx, edx
	mov edx, 1
	int 80h
	mov eax, 1 		;exit
	mov ebx, 0 		;exit
	int 80h
