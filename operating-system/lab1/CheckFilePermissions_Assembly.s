
	ASSEMBLY CODE													COMMENTS


	.file	"CheckFilePermissions_Assembly.c"			 INPUT SOURCE FILE NAME
	.section	.rodata											 INDICATES THE SEGMENT FOR CONSTANT DATA BEGINS (rodata -> read-only data) 	
.LC0:																 .LC -> LOCATION (INITIALLY SET TO 0)
	.string	"\n %s exists\n"								 	
.LC1:
	.string	"%s is not accessible\n"
	.text															 .text CONTAINS EXECUTABLE CODE	
	.globl	main
	.type	main, @function		
main:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp						  
	.cfi_def_cfa_register 5
	andl	$-16, %esp							/*
	subl	$32, %esp
	movl	12(%ebp), %eax
	movl	4(%eax), %eax						STACK POINTER MANIPULATIONS
	movl	%eax, 24(%esp)
	movl	$0, 4(%esp)
	movl	24(%esp), %eax
	movl	%eax, (%esp)														*/
	call	access								ACCESS SYSTEM CALL
	movl	%eax, 28(%esp)						VALUE RETURNED BY ACCESS CALL
	cmpl	$0, 28(%esp)						COMPARE IT WITH 0
	jne	.L2									JUMP TO .L2 IF NOT EQUAL
	movl	$.LC0, %eax							IF EQUAL PRINT CONTENT IN .LC0
	movl	24(%esp), %edx						/*
	movl	%edx, 4(%esp)						STACK POINTER MANIPULATIONS
	movl	%eax, (%esp)														*/
	call	printf								
	jmp	.L3									JUMP TO L3 TO TERMINATE
.L2:
	movl	$.LC1, %eax
	movl	24(%esp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
.L3:
	movl	$0, %eax								RETURN 0
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.6.1-9ubuntu3) 4.6.1"		IDENTIFICATION OF WHAT GENERATES THIS ASSEMBLY CODE
	.section	.note.GNU-stack,"",@progbits
