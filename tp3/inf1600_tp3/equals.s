.globl matrix_equals_asm


matrix_equals_asm:
        push %ebp               /* Save old base pointer */
        mov %esp, %ebp          /* Set ebp to current esp */
        # pusha                   # save old values
        
        push %esi               # save esi on the pile
        push %edi               # save edi on the pile
        push %ebx               # save ebx on the pile
       
        movl $0, %ebx           # set r=0 in ebx
        movl 16(%ebp),%esi      # set matorder in esi

Boucle1:
        cmp  %esi, %ebx         # compare r and matorder
        jge  Break1             # jmp if r >= matorder
        movl $0, %edi           # set c=0 in edi
     

Boucle2:
        cmp  %esi, %edi         # jmp if c >= matorder
        jge  Addr

        mov  %ebx, %eax         # set r in eax
        mul  %esi               # set r * matorder in eax
        addl %edi, %eax         # add c to r * matorder and set in eax
        movl 8(%ebp), %edx      # set matdata1 in edi

        movl (%edx,%eax,4), %edx   # set matdata1[c + r * matorder] in edx

        movl 12(%ebp), %ecx     # set matdata2 in ecx
        movl (%ecx,%eax,4), %ecx         # set matdata2[c + r * matorder] in ecx

        cmp %ecx, %edx          # compare matdata1[c + r * matorder] and matdata2[c + r * matorder]
        je Addc                 # if equal increment c
        movl $0, %eax           # return value
        jmp End                 

Addc: 
        incl %edi               # c++
        jmp Boucle2

Addr:
        incl %ebx               # r++
        jmp Boucle1
Break1:
        movl $1, %eax           # return value
        jmp End
        
End:
        pop %esi        # restores matorder
        pop %edi        # restores c
        pop %ebx        # restores r

        leave          /* Restore ebp and esp */
        ret            /* Return to the caller */
