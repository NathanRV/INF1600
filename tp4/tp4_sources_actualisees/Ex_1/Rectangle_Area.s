.globl	_ZNK9Rectangle7AreaAsmEv

_ZNK9Rectangle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */
        mov 8(%ebp), %eax       # Adresse de l'objet rectangle
        fld 8(%eax)             # largeur rectangle
        fld 4(%eax)             # longueur rectangle

        fmulp                   # multiplication des deux


        leave          /* restore ebp and esp */
        ret            /* return to the caller */

/*float Rectangle::AreaCpp() const {
   return length_ * width_;
}*/