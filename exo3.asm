section .data
char: db 6
ed: db 10

section .text
global _start

ecrireNb:
	push -1
	cmp eax, 9
	jbe affichage
	division:
		mov eax, 0
		mov ecx, 10
		idiv ecx
		push edx
		cmp eax, 9
		ja division
	affichage:
		mov [char], eax
		add byte [char], '0'
		mov eax, 4
		mov ebx, 1
		mov ecx, char
		mov edx, 1
		int 80h
		pop eax
		cmp eax, -1
		jne affichage
		ret
	_start:
		mov eax, 12345
		call ecrireNb
		mov eax, 4
		mov ebx, 1
		mov ecx, ed
		mov edx, 1
		int 80h
		mov eax, 1
		mov ebx, 0
		int 80h
