.globl	_ZNK8Cylinder9VolumeAsmEv

_ZNK8Cylinder9VolumeAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */
        mov 8(%ebp), %eax       # Adresse de l'objet cylindre

        push %eax

        call _ZNK8Cylinder11BaseAreaAsmEv  # aire de la base
        fld 8(%eax)             # hauteur cylindre

        fmulp                   # multiplication hauteur*aire base
        
        pop %eax

        leave          /* restore ebp and esp */
        ret            /* return to the caller */

/*float Cylinder::VolumeCpp() const {
   return BaseAreaCpp() * height_;
}*/
