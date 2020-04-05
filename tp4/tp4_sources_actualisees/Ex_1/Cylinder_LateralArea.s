.globl	_ZNK8Cylinder14LateralAreaAsmEv

_ZNK8Cylinder14LateralAreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */
        mov 8(%ebp), %eax       # Adresse de l'objet cylindre

        push %eax

        call _ZNK8Cylinder12PerimeterAsmEv
        fld 8(%eax)             # hauteur cylindre

        fmulp                   # multiplication perimetre*hauteur
        
        pop %eax
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */

/*float Cylinder::LateralAreaCpp() const {
   return PerimeterCpp() * height_;
}*/
