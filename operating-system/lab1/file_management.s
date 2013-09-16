	.file	"file_management.c"
	.section	.rodata
.LC0:
	.string	"source.txt"
	.align 4
.LC1:
	.string	"Could not open the file for reading."
.LC2:
	.string	"destination.txt"
.LC3:
	.string	"open"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushl	%ebp                # store the calling function's stack frame on the stack
	.cfi_def_cfa_offset 8       # 8 bytes from the stack pointer
	.cfi_offset 5, -8           # reserve 8 bytes
	movl	%esp, %ebp          # copy stack pointer to base pointer register
	.cfi_def_cfa_register 5     
	andl	$-16, %esp          # stack alignment 16 bytes
	subl	$560, %esp          # make esp points to address $560
	movl	%gs:20, %eax        # i think this does some memory check (probably buffer size)
	movl	%eax, 556(%esp)      
    xorl	%eax, %eax          # set zero in eax
	movl	$512, 24(%esp)      # set the pointer of char buffer to be 512
	movl	$0, 4(%esp)
	movl	$.LC0, (%esp)       # pointing esp to the string LC0 "source.txt"
	call	open                # open the source file
	movl	%eax, 28(%esp)
	cmpl	$0, 28(%esp)        # whether source file descriptor value is zero (located 28 bytes down from esp)
	jns	.L2                     # jump to label 2 if the comparison is positive (not less than zero)
	movl	$.LC1, (%esp)       # pointing esp to LC1
	call	puts                 
.L2:
	movl	$489, 8(%esp)       
	movl	$577, 4(%esp)       
	movl	$.LC2, (%esp)       # pointing the stack pointer at the constant LC2 (destination file name)
	call	open                # open another file descriptor (for destination file)
	movl	%eax, 32(%esp)      # save the descriptor value from the $EAX register onto the stack which is 4 bytes below the previous file descriptor
	cmpl	$0, 32(%esp)        # compare if the file descriptor is zero
	jns	.L7                     # jump to label 7 if the comparison is positive (not less than zero)
	movl	$.LC3, (%esp)       # points LC3 ("open") to ESP
	call	perror              # call perror routine
	jmp	.L7                     # continue to label 7
.L5:
	movl	36(%esp), %eax      # put the number of bytes read into $EAX
	movl	%eax, 8(%esp)       # put the number of bytes read into esp + 8 bytes
	leal	44(%esp), %eax      # $EAX contains the address esp + 44 bytes
	movl	%eax, 4(%esp)       # put the address on the stack 4 bytes + esp
	movl	32(%esp), %eax      
	movl	%eax, (%esp)
	call	write               # call write syscall
	movl	%eax, 40(%esp)      # move the number of bytes written to esp + 40 bytes
	jmp	.L4                     # jump to while loop
.L7:
	nop                         # do nothing go to the next instruction
.L4:
	movl	24(%esp), %eax      # move 
	movl	%eax, 8(%esp)
	leal	44(%esp), %eax
	movl	%eax, 4(%esp)
	movl	28(%esp), %eax
	movl	%eax, (%esp)
	call	read                # call read syscall
	movl	%eax, 36(%esp)      # move number of bytes from $EAX to stack at esp + 36 bytes
	cmpl	$0, 36(%esp)        # compare if the number of bytes read is zero
	jne	.L5                     # jump to write if not equal
	movl	28(%esp), %eax      
	movl	%eax, (%esp)        # return the control to the top of the esp
	call	close               # close fd read
	movl	32(%esp), %eax
	movl	%eax, (%esp)
	call	close               # close fd write
	movl	$0, %eax            # return 0
	movl	556(%esp), %edx     # undo the stack
	xorl	%gs:20, %edx
	je	.L6                     # jump to label 6 to restore control back to the caller (c lib)
	call	__stack_chk_fail
.L6:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.6.1-9ubuntu3) 4.6.1"
	.section	.note.GNU-stack,"",@progbits
