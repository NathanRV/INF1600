.globl matrix_multiply_asm

matrix_multiply_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        
        subl $16, %esp          /*allocates memory on the pile*/

        movl $0, -4(%ebp)      /* initializes r */
        movl $0, -8(%ebp)       /* initializes c*/
        movl $0, -12(%ebp)      /* initializes i */
        movl 20(%ebp), %ebx /* moves matorder */
        
boucleR:
        cmp -4(%ebp), %ebx      /*compares matorder and r */
        je end                 /* ends if equal */

boucleC: 
        cmp -8(%ebp), %ebx      /*compares matorder and c */
        jge fin_boucleC
        movl $0, -16(%ebp)      /*elem=0 */
        jmp boucleI

boucleI:
        cmp -12(%ebp), %ebx    /*compares matorder and i*/


        incl -8(%ebp)          /* increments c*/
        jmp boucleC


fin_boucleC:
        movl -4(%ebp), %eax     /* moves r in ecx*/
        mull %ebx               /* multiplies r by matorder in ecx*/
        addl -8(%ebp), %eax     /* add c to r*matorder*/
        movl 16(%ebp), %ecx     /* outmatdata [] in ecx */




end:
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
