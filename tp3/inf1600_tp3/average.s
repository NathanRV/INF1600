.global matrix_row_aver_asm

matrix_row_aver_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */
        # pusha                   # save old values
        push %esi               # save the register esi on the pile
        push %edi               # save the register edi on the pile
        push %edx               # save the register edx on the pile

        movl $0, %edi           # set r=0 in edi
        movl 16(%ebp), %esi     # set matorder in esi

Loop1:
        cmp %esi, %edi          # compare r and matorder
        jge End                 # if r­­>=matorder jump to end
        movl $0, %edx           # set c=0 in edx
        movl $0, %ecx           # set elem = 0 in ecx
        
Loop2:
        cmp %esi, %edx          # compare c and matorder
        jge Loop1_2

        movl %edi, %eax         # set r in eax
        imul %esi, %eax         # set r * matorder in eax
        addl %edx, %eax         # set c + r * matorder in eax
        movl 8(%ebp), %ebx      # set inmatdata in ebx

        movl (%ebx,%eax,4), %ebx         # set inmatdata[c + r * matorder] in ebx

        addl %ebx, %ecx         # elem += inmatdata[c + r * matorder]

        incl %edx               # c++
        jmp Loop2


Loop1_2:
        movl $0, %edx           # clear edx

        movl %ecx, %eax         # set elem in eax
        idiv %esi               # elem/matorder in eax

        movl 12(%ebp), %ecx     # set outmatdata in ecx

        movl %eax, (%ecx,%edi,4)        # set elem/matorder in outmatdata[r]

        pop %edx                # restore c

        incl %edi               # ++r
        jmp Loop1

End:          
        pop %esi                # restore matorder
        pop %edi                # restore r
        
        leave          			/* Restore ebp and esp */
        ret           			/* Return to the caller */
		
