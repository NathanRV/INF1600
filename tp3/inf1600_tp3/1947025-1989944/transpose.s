.globl matrix_transpose_asm


matrix_transpose_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        push %esi               # sauvegarder le registre esi sur la pile
        push %edi               # sauvegarder le registre edi sur la pile
        push %edx               # sauvegarder le registre edx sur la pile

        movl $0, %edi           # mettre r=0 dans edi
        movl 16(%ebp), %esi     # mettre matorder dans esi

Loop1:
        cmp %esi, %edi          # comparer r et matorder
        jge End                 # si r­­>=matorder sauter à end
        movl $0, %edx           # mettre c=0 dans edx
        
Loop2:
        cmp %esi, %edx          # comparer c et matorder
        jge Test1

        movl %edx, %ecx         # mettre c dans ecx
        imul %esi, %ecx         # mettre c * matorder dans ecx
        addl %edi, %ecx         # mettre r + c * matorder dans ecx

        movl 8(%ebp), %ebx      # mettre inmatdata dans ebx

        movl (%ebx,%ecx,4), %ebx         # mettre inmatdata[r + c * matorder] dans ebx

        movl %edi, %ecx         # mettre r dans ecx
        imul %esi, %ecx         # mettre r * matorder dans ecx
        addl %edx, %ecx         # mettre c + r * matorder dans ecx
        movl 12(%ebp), %eax     # mettre outmatdata dans eax

        movl %ebx, (%eax,%ecx,4)        # mettre inmatdata[r + c * matorder] dans outmatdata[c + r * matorder]
        incl %edx               # ++c

        jmp Loop2

Test1:
        incl %edi               # ++r
        jmp Loop1

End:        

        pop %edi        # restorer r
        pop %esi        # restorer matorder
        pop %edx        # restorer c 

        leave          /* restore ebp and esp */
        ret            /* return to the caller */
