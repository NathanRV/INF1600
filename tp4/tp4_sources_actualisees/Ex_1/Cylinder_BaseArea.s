.globl	_ZNK8Cylinder11BaseAreaAsmEv

_ZNK8Cylinder11BaseAreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */
        mov 8(%ebp), %eax       # Adresse de l'objet cylindre

        fldpi                   # pi
        fld 4(%eax)             # rayon cylindre
        fld 4(%eax)             # rayon cylindre

        fmulp                   # multiplication r*r
        fmulp                   # multiplication pi*r*r
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */

/*float Cylinder::BaseAreaCpp() const {
   return M_PI * radius_ * radius_;
}*/