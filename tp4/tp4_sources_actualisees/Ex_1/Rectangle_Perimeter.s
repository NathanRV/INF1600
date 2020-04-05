.globl	_ZNK9Rectangle12PerimeterAsmEv

factor: .float 2.0 /* use this to mult by two */

_ZNK9Rectangle12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */
        mov 8(%ebp), %eax       # Adresse de l'objet rectangle
        
        fld factor              # 2.0F

        fld 8(%eax)             # largeur rectangle
        fld 4(%eax)             # longueur rectangle

        faddp                   # largeur + longueur

        fmulp                   # 2.0 * (largeur + longueur)
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */

/*float Rectangle::PerimeterCpp() const {
   return 2.0 * (length_ + width_);
}*/