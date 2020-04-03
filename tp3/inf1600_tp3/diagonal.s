.global matrix_diagonal_asm

matrix_diagonal_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */
		
        # pusha                 # save old values
        push %edi               # save register edi on the pile
        push %esi               # save register esi on the pile
        push %edx               # save register edx on the pile

        movl $0, %edi           # set r=0 in edi
        movl 16(%ebp), %esi     # set matorder in esi

Loop1:
        cmp %esi, %edi          # compare r and matorder
        jge End                 # if r­­>=matorder jump to end
        movl $0, %edx           # set c=0 in ecx
        
Loop2:
        cmp %esi, %edx          # compare c and matorder
        jge Test1

        cmp %edx, %edi          # compare r and c
        je Condition

        movl %edi, %ecx         # set r in ecx
        imul %esi, %ecx         # set r * matorder in ecx
        addl %edx, %ecx         # set c + r * matorder in ecx
        movl 12(%ebp), %eax     # set outmatdata in eax

        movl $0, (%eax,%ecx,4)  # set 0 in outmatdata[c + r * matorder]

        incl %edx               # ++c

        jmp Loop2

Condition:
        movl %edi, %ecx         # set r in ecx
        imul %esi, %ecx         # set r * matorder in ecx
        addl %edx, %ecx         # set c + r * matorder in ecx
        movl 8(%ebp), %ebx      # set inmatdata in ebx
        movl 12(%ebp), %eax     # set outmatdata in eax

        movl (%ebx,%ecx,4), %ebx         # set inmatdata[c + r * matorder] in ebx

        movl %ebx, (%eax,%ecx,4)        # set inmatdata[c + r * matorder] in outmatdata[c + r * matorder]

        incl %edx               # ++c

        jmp Loop2

Test1:
        incl %edi               # ++r
        jmp Loop1

End:       
        pop %edi                # restore r
        pop %esi                # restore matorder
        pop %edx                # restore c	

        leave          			/* Restore ebp and esp */
        ret            			/* Return to the caller */

