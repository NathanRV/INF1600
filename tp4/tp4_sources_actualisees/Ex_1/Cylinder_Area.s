.globl	_ZNK8Cylinder7AreaAsmEv

_ZNK8Cylinder7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */
        mov 8(%ebp), %eax       # adresse de l'objet cylindre
        push %eax

        call _ZNK8Cylinder11BaseAreaAsmEv       # Base area
        call _ZNK8Cylinder14LateralAreaAsmEv    # Lateral area

        faddp           # additionner les deux

        pop %eax

        leave          /* restore ebp and esp */
        ret            /* return to the caller */

/*float Cylinder::AreaCpp() const {
   return LateralAreaCpp() + BaseAreaCpp();
}*/