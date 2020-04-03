.global matrix_row_aver_asm

matrix_row_aver_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */
        # pusha                   # sauvegarder les anciennes valeurs
        push %esi               # sauvegarder le registre esi sur la pile
        push %edi               # sauvegarder le registre edi sur la pile
        push %edx               # sauvegarder le registre edx sur la pile

        movl $0, %edi           # mettre r=0 dans edi
        movl 16(%ebp), %esi     # mettre matorder dans esi

Loop1:
        cmp %esi, %edi          # comparer r et matorder
        jge End                 # si r­­>=matorder sauter à end
        movl $0, %edx           # mettre c=0 dans edx
        movl $0, %ecx           # mettre elem = 0 dans ecx
        
Loop2:
        cmp %esi, %edx          # comparer c et matorder
        jge Loop1_2

        movl %edi, %eax         # mettre r dans eax
        imul %esi, %eax         # mettre r * matorder dans eax
        addl %edx, %eax         # mettre c + r * matorder dans eax
        movl 8(%ebp), %ebx      # mettre inmatdata dans ebx

        movl (%ebx,%eax,4), %ebx         # mettre inmatdata[c + r * matorder] dans ebx

        addl %ebx, %ecx         # elem += inmatdata[c + r * matorder]

        incl %edx               # c++
        jmp Loop2


Loop1_2:
        movl $0, %edx           # mettre 0 dans edx

        movl %ecx, %eax         # mettre elem dans eax
        idiv %esi               # elem/matorder dans eax

        movl 12(%ebp), %ecx     # mettre outmatdata dans ecx

        movl %eax, (%ecx,%edi,4)        # mettre elem/matorder dans outmatdata[r]

        pop %edx                # restorer c

        incl %edi               # ++r
        jmp Loop1

End:          
        pop %esi                # restorer matorder
        pop %edi                # restorer r
        
        leave          			/* Restore ebp and esp */
        ret           			/* Return to the caller */
		
