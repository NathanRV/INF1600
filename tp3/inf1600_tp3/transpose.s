.globl matrix_transpose_asm

matrix_transpose_asm:
        push %ebp                   /* save old base pointer */
        mov %esp, %ebp              /* set ebp to current esp */
        
        /* Save registers */
        push %esi
        push %edi
        push %ebx 

        movl 16(%ebp), %ebx         /* move matorder in ebx*/
      
        movl $0, %esi               /*initializes r*/
        movl $0, %edi               /*initializes c*/

boucleR:
        cmp %esi, %ebx              /* compares r and matorder */
        je end

boucleC:
         cmp %edi, %ebx             /* compares c and matorder*/
         jge fin_boucle
         movl %edi, %eax            /* moves c in eax */
         mull %ebx                  /*multiplies c*matorder  in eax*/
         addl %esi, %eax            /*adds r to the multiplication */
        
         movl 8(%ebp), %ecx         /* adds inmadata1 in ecx */
         movl (%ecx,%eax,4), %ecx

         movl %esi, %eax            /* moves r in eax */
         mull %ebx                  /*multiplies r*matorder */
         addl %edi, %eax            /* adds c+ r*matorder */
         movl 12(%ebp), %edx        /* adds outmata in edx*/
         movl %ecx,(%edx,%eax,4)    /* add outmatdata [c+ r*matorder] = inmatdata [r+c*matorder] */


         incl %edi                  /* increments c */
         jmp boucleC



fin_boucle:
        incl %esi                    /* increments r*/
        movl $0, %edi                /* initializes c*/



 end:     
      pop %ebx
	  pop  %edi
	  pop %esi
        
      leave          /* restore ebp and esp */
      ret            /* return to the caller */
