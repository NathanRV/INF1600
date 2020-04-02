.globl matrix_multiply_asm

matrix_multiply_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        
        subl $16, %esp          /*allocates memory on the pile*/
    
        movl $0, -4(%ebp)       /* initializes r */
        movl $0, -8(%ebp)       /* initializes c*/
        movl $0, -12(%ebp)      /* initializes i */
        movl 20(%ebp), %ebx     /* moves matorder */
        
boucleR:
        cmp -4(%ebp), %ebx      /*compares matorder and r */
        je end                  /* ends if equal */

boucleC: 
        cmp -8(%ebp), %ebx      /*compares matorder and c */
        movl $0, -16(%ebp)      /*elem=0 */
        jl boucleI
       	jmp fin_boucleC
       
       

boucleI:
        cmp -12(%ebp), %ebx    /*compares matorder and i*/
        jl multiply             /* jump if lower */
        movl $0, -12(%ebp)		/* initializes i*/
     	
        incl -8(%ebp)			/* c++ */
    	jmp boucleC


multiply:
        movl -4(%ebp), %eax    /* moves r in %eax */
        mull %ebx   
        addl -12(%ebp), %eax   /*corresponds i+ r*matorder*/
        movl 8(%ebp), ecx      /* moves inmatdata1 in eax*/
        movl (%ecx, %eax, 4), %ecx /* inmatdata1 [i+r*matorder]*/
        
        movl 12(%ebp), edx      /* moves intmatdata2 in edx*/
        movl -12(%ebp), %eax    /* moves i in %eax*/
        mull %ebx
        addl  -8(%ebp), %eax    /* adds c+i*matorder*/
        movl (%edx, %eax, 4), %edx /* adds inmatdata2[c+i*matorder] */

        movl %ecx, %eax         /*place inmatdata1[i+r*matorder] in eax */
        mull %edx               /* inmatdata1*inmatdata2 */
        addl %eax, -16(%ebp)   /* elem += inmatdata1*inmatdata2 */

        incl -12(%ebp)          /* i++ */
        jmp boucleI

        
fin_boucleC:
        movl -4(%ebp), %eax     /* moves r in ecx*/
        mull %ebx               /* multiplies r by matorder in ecx*/
        addl -8(%ebp), %eax     /* c+r*matorder*/
        movl 16(%ebp), %ecx     /* outmatdata [] in ecx */
        movl -16(%ebp), (%eax, %ecx, 4) /* outmatdata [c+r*matorder]= elem*/

        movl $0, -8(%ebp)		/* initializes c*/
        incl -4(%ebp)			/* r++ */
    	jmp boucleR




end:

        addl $16, %esp	/* frees the memory */	
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
