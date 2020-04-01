.globl matrix_transpose_asm

/*void matrix_transpose(const int* inmatdata, int* outmatdata, int matorder) {
   // Variables 
   int r, c; // Row/column indices 
   // Go through the matrix elements 
   for(r = 0; r < matorder; ++r) {
      for(c = 0; c < matorder; ++c) {
         outmatdata[c + r * matorder] = inmatdata[r + c * matorder];
      }
   }
}*/


matrix_transpose_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        # pusha                   # save old values
        movl $0, %edi           # set r=0 in edi
        movl 16(%ebp), %esi     # set matorder in esi

Loop1:
        cmp %esi, %edi          # compare r and matorder
        jge End                 # if r­­>=matorder jump to end
        movl $0, %edx           # set c=0 in ecx
        
Loop2:
        cmp %esi, %edx          # compare c and matorder
        jge Test1

        movl %edx, %ecx         # set c in ecx
        imul %esi, %ecx         # set c * matorder in ecx
        addl %edi, %ecx         # set r + c * matorder in ecx

        movl 8(%ebp), %ebx      # set inmatdata in ebx

        movl (%ebx,%ecx,4), %ebx         # set inmatdata[r + c * matorder] in ebx

        movl %edi, %ecx         # set r in ecx
        imul %esi, %ecx         # set r * matorder in ecx
        addl %edx, %ecx         # set c + r * matorder in ecx
        movl 12(%ebp), %eax     # set outmatdata in eax

        movl %ebx, (%eax,%ecx,4)        # set inmatdata[r + c * matorder] in outmatdata[c + r * matorder]
        incl %edx               # ++c

        jmp Loop2

Test1:
        incl %edi               # ++r
        jmp Loop1

End:        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
