.global matrix_row_aver_asm

matrix_row_aver_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */

		/* Write your solution here */
        push $16, %esp     /* allocates memory for r, c, elem */

        movl $0, -4(%ebp)       /* r=0 */
        movl $0, -8(%ebp)       /*c=0 */
        movl 16(%ebp), %ebx     /* matorder in ebx */
boucleR:
        cmp -4(%ebp), %ebx      /* compares r and matorder */
        jge end
        movl $0, -12(%ebp)      /* elem=0*/
        jmp boucleC

boucleC:
        cmp -8(%ebp), %ebx      /* compares i and matorder */
        jge fin_boucleR
        movl -4(%ebp), %eax     /* r in %eax */
        mull %ebx               /* r * matorder */
        addl -8(%ebp), %eax     /* c + r*matorder */
        movl 8(%ebp), %ecx      /* inmatdata in ecx*/
        movl -12(%ebp), (%ecx, %eax, 4)

        incl -8(%ebp)           /* c++ */
        jmp boucleC

fin_boucleR:
        movl 12(%ebp), %edx     /* moves outmatdata [] in edx */
        movl -12(%ebp), %eax    /* elem in %eax */
        divl %ebx               /* elem/matorder in %eax*/
        movl %eax, (%edx,-4(%ebp),4)       /*outmatdata[r] = elem/matorder */

        mov $0, -8(%ebp)           /* c=0 */
        incl -4(%ebp) /* r++ */
        jmp boucleR


end:	
        add $16,%esp
        leave          			/* Restore ebp and esp */
        ret           			/* Return to the caller */
		
