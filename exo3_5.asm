section .data
pal: db 0

section .text
global _start

_start:
	mov al, pal
	cmp al, 0
	je fin
	palindrome:
		mov eax, pal
		mov ebx, 10
		idiv ebx
		mov al, [eax]
		mov eax, 4
		mov ebx, 1
		mov ecx, edx
		mov edx, 1
		int 80h
	cmp al, 0
	jne palindrome
	fin:
		mov eax, 1
		mov ebx, 0
		int 80h
