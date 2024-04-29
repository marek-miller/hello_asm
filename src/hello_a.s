[bits 64]
default rel

global hello_a


section .data

hello_msg	db	"Hello from asm!", 0x0a, 0


section .text
	extern	printf

hello_a:
	push	rdi
	xor	rax, rax
	lea	rdi, [hello_msg]
	call	printf wrt ..plt
	pop	rdi

	mov 	rax, rdi

	ret
