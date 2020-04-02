.global matrix_diagonal_asm

/*void matrix_diagonal(const int* inmatdata, int* outmatdata, int matorder) {
   // Variables 
   int r, c; // Row/column indices 
   // Go through the matrix elements 
   for(r = 0; r < matorder; ++r) {
      for(c = 0; c < matorder; ++c) {
		if(c == r){
			outmatdata[c + r * matorder] = inmatdata[c + r * matorder];
		} 
        else{
			outmatdata[c + r * matorder] = 0;
		}
      }
   }
}
*/

matrix_diagonal_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */
		/* Write your solution here */
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

        leave          			/* Restore ebp and esp */
        ret            			/* Return to the caller */

