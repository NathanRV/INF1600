.globl	_ZNK9Rectangle11DiagonalAsmEv

_ZNK9Rectangle11DiagonalAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */
        mov 8(%ebp), %eax       # Adresse de l'objet rectangle
        fld 8(%eax)             # largeur rectangle
        fld 8(%eax)             # largeur rectangle

        fmulp                   # multiplication des deux

        fld 4(%eax)             # longueur rectangle
        fld 4(%eax)             # longueur rectangle

        fmulp                   # multiplication des deux

        faddp                   # addition des deux

        fsqrt                   # racine carrée du tout
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */


/*float Rectangle::DiagonalCpp() const {
   return sqrt(length_ * length_ + width_ * width_);
}
*/
