	global loader				; the entry symbol for ELF
	MAGIC_NUMBER 	equ 0x1BADB002		; define the magic number constant
	FLAGS		equ 0x0			; multiboot flags
	CHECKSUM	equ -MAGIC_NUMBER 	; calculate the checksum
	extern 		sum_of_three
					; (magic number + checksum + flags should equals 0)
	KERNEL_STACK_SIZE equ 4096	; size of stack in bytes

	section .bss
	align 4
	kernel_stack:
	resb KERNEL_STACK_SIZE
	mov esp, kernel_stack + KERNEL_STACK_SIZE
	
	section .text				; start of the text (code) section
	align 4
	dd MAGIC_NUMBER			; the code must be 4 byte aligned
	dd FLAGS			; write the magic number to the machine code
	dd CHECKSUM			; and the checksum

	loader:					; the loader label (defined as entry point to the linker script)
	push dword 3
	push dword 2
	push dword 1
	call sum_of_three
	.loop:
	jmp .loop			; loop forever
