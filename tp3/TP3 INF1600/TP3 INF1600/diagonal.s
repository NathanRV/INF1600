.global matrix_diagonal_asm

matrix_diagonal_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */

		/* save registers */
        push %esi
        push %edi
        push %ebx

        movl 16(%ebp), %ebx
        movl $0, %esi        /* initializes r */
        movl $0, %edi        /* initializes c */

boucleR:

        cmp %ebx, %esi  /* compares r and matorder */
        jge end
     

boucleC:
        cmp %ebx, %edi      /* compares c and matorder */
        jl calcul           /* if lower do the math */
        mov $0, %edi        /* c=0 */

        incl %esi           /* r++ */
        jmp boucleR


calcul:

        movl %esi, %eax     /* moves r in %eax */
        mull %ebx           /* r*matorder */
        addl %edi, %eax     /* c+ r*matorder */
        movl 8(%ebp), ecx   /* inmatdata in %ecx */
        movl 12(%ebp), %edx /* outmatdata in %edx */

        cmp %edi, %esi      /*compares r and c*/
        jne not_equal

        movl %ecx, (%ecx, %eax, 4)      /* inmatdata [c+r*matorder] */       
        movl %ecx, (%edx, %eax, 4)      /* outmatdata [c+r*matorder] = inmatdata */

        incl  %edi  /* c++ */
        jmp boucleC

      

not_equal:
        movl 12(%ebp), %edx /* outmatdata in %edx */
        movl $0, (%edx, %eax, 4) /* outmatdata [c+r*matorder] = 0 */

        incl  %edi  /* c++ */
        jmp boucleC
          
        

end:
        pop %ebx 
        pop %edi
        pop %esi
        
        leave          			/* Restore ebp and esp */
        ret            			/* Return to the caller */

