.global matrix_diagonal_asm

matrix_diagonal_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */
		
        # pusha                 # sauvegarder les anciennes valeurs
        push %edi               # sauvegarder le registre edi sur la pile
        push %esi               # sauvegarder le registre esi sur la pile
        push %edx               # sauvegarder le registre edx sur la pile

        movl $0, %edi           # mettre r=0 dans edi
        movl 16(%ebp), %esi     # mettre matorder dans esi

Loop1:
        cmp %esi, %edi          # comparer r et matorder
        jge End                 # si r­­>=matorder sauter à end
        movl $0, %edx           # mettre c=0 dans ecx
        
Loop2:
        cmp %esi, %edx          # comparer c et matorder
        jge Test1

        cmp %edx, %edi          # comparer r et c
        je Condition

        movl %edi, %ecx         # mettre r dans ecx
        imul %esi, %ecx         # mettre r * matorder dans ecx
        addl %edx, %ecx         # mettre c + r * matorder dans ecx
        movl 12(%ebp), %eax     # mettre outmatdata dans eax

        movl $0, (%eax,%ecx,4)  # mettre 0 dans outmatdata[c + r * matorder]

        incl %edx               # ++c

        jmp Loop2

Condition:
        movl %edi, %ecx         # mettre r dans ecx
        imul %esi, %ecx         # mettre r * matorder dans ecx
        addl %edx, %ecx         # mettre c + r * matorder dans ecx
        movl 8(%ebp), %ebx      # mettre inmatdata dans ebx
        movl 12(%ebp), %eax     # mettre outmatdata dans eax

        movl (%ebx,%ecx,4), %ebx         # mettre inmatdata[c + r * matorder] dans ebx

        movl %ebx, (%eax,%ecx,4)        # mettre inmatdata[c + r * matorder] dans outmatdata[c + r * matorder]

        incl %edx               # ++c

        jmp Loop2

Test1:
        incl %edi               # ++r
        jmp Loop1

End:       
        pop %edi                # restorer r
        pop %esi                # restorer matorder
        pop %edx                # restorer c	

        leave          			/* Restore ebp and esp */
        ret            			/* Return to the caller */

