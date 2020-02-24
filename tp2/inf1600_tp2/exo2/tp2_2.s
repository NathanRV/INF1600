.global func_s

func_s:
	/* Votre programme assembleur ici... */

	/*(((e*b)+g)/d)*((g-f)/(d+e))*/
	
	fld e /*place e sur la pile à st[0], st[1] prend ancienne valeur de st[0]*/
	fld b /*place b sur la pile à st[0], st[1] prend ancienne valeur de st[0]*/

	fmulp /*multiplie (e*b) et résultat prend les places st[0] et st[1]*/

	fld g /*place g sur la pile à st[0], st[1] prend ancienne valeur de st[0]*/

	faddp /*addition  (e*b)+g et résultat prend les places st[0] et st[1]*/

	fld d /*place d sur la pile à st[0], st[1] prend ancienne valeur de st[0]*/

	fdivrp /*divise	((e*b)+g)/d	et résultat prend les places st[0] et st[1]*/

	fstp a /*retire element st[O] pour le mettre en mémoire principale à l'adresse 'a' et st[1] devient st[0]*/

	fld g /*place g sur la pile à st[0], st[1] prend ancienne valeur de st[0]*/
	fld f /*place f sur la pile à st[0], st[1] prend ancienne valeur de st[0]*/

	fsubrp /*soustrait	g-f et résultat prend les places st[0] et st[1]*/

	fstp c /*retire element st[O] pour le mettre en mémoire principale à l'adresse 'c' et st[1] devient st[0]*/

	fld e /*place e sur la pile à st[0], st[1] prend ancienne valeur de st[0]*/
	fld d /*place d sur la pile à st[0], st[1] prend ancienne valeur de st[0]*/

	faddp /*addition	d+e et résultat prend les places st[0] et st[1]*/

	fld c /*place c sur la pile à st[0], st[1] prend ancienne valeur de st[0]*/

	fdivp /*divise		(g-f)/(d+e) et résultat prend les places st[0] et st[1]*/

	fld a /*place a sur la pile*/

	fmulp /*multiplie	(((e*b)+g)/d)*(g-f)/(d+e) et résultat prend les places st[0] et st[1]*/

	fstp a /*retire element st[O] pour le mettre en mémoire principale à l'adresse 'a' et st[1] devient st[0]*/

	ret
