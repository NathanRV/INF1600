.globl matrix_multiply_asm


matrix_multiply_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */       

        # pusha                 # save old values

        push %edi               # save the register edi on the stack
        push %esi               # save the register esi on the stack
        push %ecx               # save the register ecx on the stack
        
        add $12, %esp          # save space on the pile for r, c,i 
            
        movl $0, %edi           # set r=0 in edi
        movl 20(%ebp), %esi     # set matorder in esi

Loop1:
        cmp %esi, %edi          # compare r and matorder
        jge End                 # if r­­>=matorder jump to end
        movl $0, %edx           # set c=0 in edx
        
Loop2:
        cmp %esi, %edx          # compare c and matorder
        jge Test1
        movl $0, %ecx           # set i=0 in ecx
        movl $0, %ebx           # set elem=0 in ebx

Loop3:
        cmp %esi, %ecx          # compare i and matorder
        jge Loop2_2

        push %ebx               # save elem

        movl %edi, %eax         # set r in eax
        imul %esi, %eax         # set r * matorder in eax
        addl %ecx, %eax         # set i + r * matorder in eax
        movl 8(%ebp), %ebx      # set inmatdata1 in ebx

        movl (%ebx,%eax,4), %ebx         # set inmatdata1[i + r * matorder] in ebx

        push %ebx               # save inmatdata1[i + r * matorder]

        movl %ecx, %eax         # set i in eax
        imul %esi, %eax         # set i * matorder in eax
        addl %edx, %eax         # set c + i * matorder in eax
        movl 12(%ebp), %ebx     # set inmatdata2 in ebx

        movl (%ebx,%eax,4), %ebx        # set inmatdata2[c + i * matorder] in ebx

        pop %eax                # restore inmatdata1[i + r * matorder]

        imul %ebx, %eax         # set inmatdata1[i + r * matorder] * inmatdata2[c + i * matorder] in eax


        pop %ebx                # restore elem
        addl %eax, %ebx         # elem+=inmatdata1[i + r * matorder] * inmatdata2[c + i * matorder]


        incl %ecx               # i++
        jmp Loop3

Loop2_2:
        movl 16(%ebp), %ecx     # set outmatdata in ecx

        movl %edi, %eax         # set r in eax
        imul %esi, %eax         # set r * matorder in eax
        addl %edx, %eax         # set c + r * matorder in eax


        movl %ebx, (%ecx,%eax,4)           # outmatdata[c + r * matorder] = elem

        incl %edx               # c++
        jmp Loop2

Test1:
        incl %edi               # r++
        jmp Loop1


End:             
        pop %edi        # restore r
        pop %esi        # restore matorder
        pop %ecx        # restore i

        leave          /* restore ebp and esp */
        ret            /* return to the caller */
