#include <stdio.h>
#include <stdlib.h>

int main(){



    FILE *errors;
    errors = fopen("errors.tex", "w");

    double Vkirch[9];
    double Ikirch[4];

    FILE *kirch;
    kirch = fopen("./mat/kirch-errors.tex", "r");

    if(kirch == NULL)
        printf("failed");

    for (int i = 0; i < 9; i++)
        fscanf(kirch, "%lf", &Vkirch[i]);

    for (int i = 0; i < 4; i++)
        fscanf(kirch, "%lf", &Ikirch[i]);

    fclose(kirch);

    double Gb;
    double Id;
    double Isim[7];
    double Vsim[8];

    FILE *sim;
    sim = fopen("./sim/op_tab.tex", "r");

    if(sim == NULL)
        printf("failed");

    fscanf(sim, "@gb[i] & %lf\\\\ \\hline\n", &Gb);
    fscanf(sim, "@id[current] & %lf\\\\ \\hline\n", &Id);

    fscanf(sim, "@r1[i] & %lf\\\\ \\hline\n", &Isim[0]);
    fscanf(sim, "@r2[i] & %lf\\\\ \\hline\n", &Isim[1]);
    fscanf(sim, "@r3[i] & %lf\\\\ \\hline\n", &Isim[2]);
    fscanf(sim, "@r4[i] & %lf\\\\ \\hline\n", &Isim[3]);
    fscanf(sim, "@r5[i] & %lf\\\\ \\hline\n", &Isim[4]);
    fscanf(sim, "@r6[i] & %lf\\\\ \\hline\n", &Isim[5]);
    fscanf(sim, "@r7[i] & %lf\\\\ \\hline\n", &Isim[6]);

    fscanf(sim, "v(1) & %lf\\\\ \\hline\n", &Vsim[0]);
    fscanf(sim, "v(2) & %lf\\\\ \\hline\n", &Vsim[1]);
    fscanf(sim, "v(3) & %lf\\\\ \\hline\n", &Vsim[2]);
    fscanf(sim, "v(4) & %lf\\\\ \\hline\n", &Vsim[3]);
    fscanf(sim, "v(5) & %lf\\\\ \\hline\n", &Vsim[4]);
    fscanf(sim, "v(6) & %lf\\\\ \\hline\n", &Vsim[5]);
    fscanf(sim, "v(7) & %lf\\\\ \\hline\n", &Vsim[6]);
    fscanf(sim, "v(8) & %lf\\\\ \\hline\n", &Vsim[7]);

    fclose(sim);

    printf("%lf %lf", Isim[0], Vsim[0]);

    return 0;
}