.data
	/* Votre programme assembleur ici... */
	i:
		.int 0

.global func_s

func_s:	
	/* Votre programme assembleur ici... */
	mov i, %edi 	#iterateur
	boucle:

	/*a=b+c-d;*/
	mov b, %eax 	#b
	mov c, %ecx		#placer dans registre pour calcul
	add %ecx, %eax	#b+c
	mov d, %edx		#placer dans registre pour calcul
	sub %edx, %eax	#(b+c)-d
	
	if:
		
		#(c+1000)>(e-500)?
		mov c,	%ecx	#placer dans registre pour calcul
		add $1000, %ecx #c+1000
		mov e, %esi 	#placer dans registre pour calcul
		sub $500, %esi 	#e-500
		cmp %esi, %ecx 	#(c+1000)-(e-500)

		jng else		#si (c+1000)-(e-500)<=0

		#restaurer valeur
		mov e, %esi
		sub $300, %esi 	#e=e-300
		mov %esi, e 	#changer variable

		if_imbrique: 
			mov b, %ebx		#placer dans registre pour calcul
			mov c, %ecx		#placer dans registre pour calcul
			cmp %ecx, %ebx	#b-c
			jna fin_if		#si b<c, sauter à la fin du if

			add $300, %ecx	#c=c+300;
			mov %ecx, c 	#changer variable

		jmp fin_if

	else:

		mov b, %ebx		#placer dans registre pour calcul
		mov c, %ecx		#placer dans registre pour calcul
		mov d, %edx		#placer dans registre pour calcul

		sub %edx, %ecx	#c=c-d;
		sub $300, %ebx	#b=b-300;	

		mov %ebx, b 	#changer variable
		mov %ecx, c 	#changer variable
		mov %edx, d 	#changer variable
	
	fin_if:

		#boucle fini?
		add $1, %edi	#i++
		mov $10, %esi	 #placer 10 dans registre pour calcul
		cmp %edi, %esi	#10-i
		jae boucle		#si 10-i>=0, sauter debut boucle
		
	fin:

		#retourner a
		mov %eax, a

	ret
