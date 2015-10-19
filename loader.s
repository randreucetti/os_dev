	global loader				; the entry symbol for ELF

	MAGIC_NUMBER 	equ 0x1BADB002		; define the magic number constant
	FLAGS		equ 0x0			; multiboot flags
	CHECKSUM	equ -MAGIC_NUMBER 	; calculate the checksum
					; (magic number + checksum + flags should equals 0)
	extern sum_of_three

	section .text				; start of the text (code) section
	align 4
	dd MAGIC_NUMBER			; the code must be 4 byte aligned
	dd FLAGS			; write the magic number to the machine code
	dd CHECKSUM			; and the checksum

	KERNEL_STACK_SIZE equ 4096		; size of stack in bytes
	section .bss
	align 4					; align at 4 bytes
	kernel_stack:				; label points to beginning of memory
	resb KERNEL_STACK_SIZE		; reserve stack for the kernel
	loader:					; the loader label (defined as entry point to the linker script)
	mov eax, 0xCAFEBABE		; place the number 0xCAFEBABE in the register eax
	.loop:
	mov esp, kernel_stack + KERNEL_STACK_SIZE ;point esp to the start of the stack (end of memory area)
	push dword 3		;arg3
	push dword 2		;arg2
	push dword 1		;arg1
	call sum_of_three	;call the function, the result will be in eax
	jmp .loop			; loop forever
