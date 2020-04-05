.globl matrix_equals_asm


matrix_equals_asm:
        push %ebp               /* Save old base pointer */
        mov %esp, %ebp          /* Set ebp to current esp */
        
        push %esi               # sauvegarder le registre esi sur la pile
        push %edi               # sauvegarder le registre edi sur la pile
        push %ebx               # sauvegarder le registre ebx sur la pile
       
        movl $0, %ebx           # mettre r=0 dans ebx
        movl 16(%ebp),%esi      # mettre matorder dans esi

Boucle1:
        cmp  %esi, %ebx         # comparer r et matorder
        jge  Break1             # sauter � Break1 si r >= matorder
        movl $0, %edi           # mettre c=0 in edi
     

Boucle2:
        cmp  %esi, %edi         # comparer c et matorder
        jge  Addr               # sauter � Addr if c >= matorder

        mov  %ebx, %eax         # mettre r dans eax
        mul  %esi               # mettre r * matorder dans eax
        addl %edi, %eax         # ajouter c to r * matorder et mettre dans eax
        movl 8(%ebp), %edx      # mettre matdata1 dans edi

        movl (%edx,%eax,4), %edx   # mettre matdata1[c + r * matorder] dans edx

        movl 12(%ebp), %ecx     # mettre matdata2 dans ecx
        movl (%ecx,%eax,4), %ecx         # mettre matdata2[c + r * matorder] dans ecx

        cmp %ecx, %edx          # comparer matdata1[c + r * matorder] et matdata2[c + r * matorder]
        je Addc                 # Si �gal, incr�menter c
        movl $0, %eax           # retourne la valeur
        jmp End                 

Addc: 
        incl %edi               # c++
        jmp Boucle2

Addr:
        incl %ebx               # r++
        jmp Boucle1
Break1:
        movl $1, %eax           # retourne la valeur
        jmp End
        
End:
        pop %esi        # restorer matorder
        pop %edi        # restorer c
        pop %ebx        # restorer r

        leave          /* Restore ebp and esp */
        ret            /* Return to the caller */
