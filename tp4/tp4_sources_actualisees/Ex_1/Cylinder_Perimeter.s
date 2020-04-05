.globl	_ZNK8Cylinder12PerimeterAsmEv

factor: .float 2.0 /* use this to mult by two */

_ZNK8Cylinder12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */
        mov 8(%ebp), %eax       # Adresse de l'objet cylindre

        fld factor              # 2.0F
        fldpi                   # pi
        fld 4(%eax)             # rayon cylindre

        fmulp                   # multiplication pi*r
        fmulp                   # multiplication 2*pi*r
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */

/*float Cylinder::PerimeterCpp() const {
   return 2.0f * M_PI * radius_;
}*/
