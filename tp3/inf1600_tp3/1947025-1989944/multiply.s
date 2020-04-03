.globl matrix_multiply_asm


matrix_multiply_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */       

        # pusha                 # sauvegarder les anciennes valeurs

        push %edi               # sauvegarder le registre edi sur la pile
        push %esi               # sauvegarder le registre esi sur la pile
        push %ecx               # sauvegarder le registre ecx sur la pile
        
        add $12, %esp          # sauvegarder l'espace sur la pile pour r, c,i 
            
        movl $0, %edi           # mettre r=0 dans edi
        movl 20(%ebp), %esi     # mettre matorder dans esi

Loop1:
        cmp %esi, %edi          # comparer r et matorder
        jge End                 # si r­­>=matorder sauter à end
        movl $0, %edx           # mettre c=0 dans edx
        
Loop2:
        cmp %esi, %edx          # comparer c et matorder
        jge Test1
        movl $0, %ecx           # mettre i=0 dans ecx
        movl $0, %ebx           # mettre elem=0 dans ebx

Loop3:
        cmp %esi, %ecx          # comparer i et matorder
        jge Loop2_2

        push %ebx               # sauvegarder elem

        movl %edi, %eax         # mettre r dans eax
        imul %esi, %eax         # mettre r * matorder dans eax
        addl %ecx, %eax         # mettre i + r * matorder dans eax
        movl 8(%ebp), %ebx      # mettre inmatdata1 dans ebx

        movl (%ebx,%eax,4), %ebx         # mettre inmatdata1[i + r * matorder] dans ebx

        push %ebx               # sauvegarder inmatdata1[i + r * matorder]

        movl %ecx, %eax         # mettre i dans eax
        imul %esi, %eax         # mettre i * matorder dans eax
        addl %edx, %eax         # mettre c + i * matorder dans eax
        movl 12(%ebp), %ebx     # mettre inmatdata2 dans ebx

        movl (%ebx,%eax,4), %ebx        # mettre inmatdata2[c + i * matorder] dans ebx

        pop %eax                # restorer inmatdata1[i + r * matorder]

        imul %ebx, %eax         # mettre inmatdata1[i + r * matorder] * inmatdata2[c + i * matorder] dans eax


        pop %ebx                # restorer elem
        addl %eax, %ebx         # elem+=inmatdata1[i + r * matorder] * inmatdata2[c + i * matorder]


        incl %ecx               # i++
        jmp Loop3

Loop2_2:
        movl 16(%ebp), %ecx     # mettre outmatdata dans ecx

        movl %edi, %eax         # mettre r dans eax
        imul %esi, %eax         # mettre r * matorder dans eax
        addl %edx, %eax         # mettre c + r * matorder dans eax


        movl %ebx, (%ecx,%eax,4)           # outmatdata[c + r * matorder] = elem

        incl %edx               # c++
        jmp Loop2

Test1:
        incl %edi               # r++
        jmp Loop1


End:             
        pop %edi        # restorer r
        pop %esi        # restorer matorder
        pop %ecx        # restorer i

        leave          /* restore ebp and esp */
        ret            /* return to the caller */
