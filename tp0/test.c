#include <stdio.h>

int g1, g2, g3;

int f(int a, int b, int c) {
	printf("%d %d %d ", a, b, c);
	
	return a + b + c;
}

int main(void) {
	int i, j, k, l;

	i = 4;
	j = 5;
	k = 6;
	l = f(i, j, k);
	g1 = l;
	g2 = 9;
	printf("%d\\n", l);
	printf("%d\\n", *(int*) l);
	printf("fini! %d\\n", j);
	
	return 0;
}