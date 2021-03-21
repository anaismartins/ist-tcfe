#include <stdio.h>

int main(){

    FILE *kcl;
    kcl = fopen("/mat/kcl.tex", "r");

    double V[9];

    printf("aqui\n");

    for (int i = 1; i < 10; i++){

        V[i-1] = 0;

        printf("aqui %i\n", i);
        if (i == 8)
            fscanf(kcl, "Vb & %lf", V[i-1]);
        else if (i == 9)
            fscanf(kcl, "Vc & %lf", V[i-1]);
        else{
            printf("aquiiii\n");
            fscanf(kcl, "V%i & %lf", i, V[i-1]);
            printf("aquiiii\n");
        }
    }

    fclose(kcl);

    printf("%lf", V[0]);

    return 0;
}