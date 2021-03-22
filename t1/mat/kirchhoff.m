close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

pkg load symbolic

syms I1
syms I2
syms I3
syms I4
syms Ib
syms Ic
syms V1
syms V2
syms V3
syms V4
syms V5
syms V6
syms V7
syms Vb
syms Vc

Z = vpa(0.0)
O = vpa(1.0)

R1 = vpa(1.02779694281e3) %Ohm
R2 = vpa(2.07715672461e3) %Ohm
R3 = vpa(3.1156225241e3) %Ohm
R4 = vpa(4.11105908751e3) %Ohm
R5 = vpa(3.02879032081e3) %Ohm
R6 = vpa(2.02983164661e3) %Ohm
R7 = vpa(1.00454956611e3) %Ohm
Va = vpa(5.18504190779) %V
Id = vpa(1.03147590492e-3) %A
Kb = vpa(7.00248816446e-3) %S
Kc = vpa(8.14562893937e3) %Ohm

A = [Z, Z, Z, Z, Z, Z, Z, Z, Z, (R1 + R3 + R4), -R3, -R4, Z, Z, Z; Z, Z, Z, Z, Z, Z, Z, -1, Z, R3, -R3, Z, Z, Z, Z; Z, Z, Z, Z, Z, Z, Z, Z, Z, Z, 1, Z, Z, 1, Z; Z, Z, Z, Z, Z, Z, Z, Z, 1, -R4, Z, (R7+R6+R4), Z, Z, Z; Z, Z, Z, Z, Z, Z, Z, Z, Z, Z, Z, 1, Z, Z, 1; Z, Z, Z, Z, Z, Z, Z, Z, Z, Z, Z, Z, 1, Z, Z; (O/R1), (-O/R1 + O/R3 + O/R2), (-O/R2), Z, (-O/R3), Z, Z, Z, Z, Z, Z, Z, Z, Z, Z; Z, (O/R3), Z, Z, (-O/R3), Z, Z, Z, Z, Z, Z, Z, Z, -1, Z; Z, (O/R2), (-O/R2), Z, Z, Z, Z, Z, Z, Z, Z, Z, Z, 1, Z; Z, Z, Z, Z, (-O/R5), (O/R5), Z, Z, Z, Z, Z, Z, Z, -1, Z; Z, Z, Z, (-O/R6), Z, Z, (O/R6 - O/R7), Z, Z, Z, Z, Z, Z, Z, Z;Z, Z, Z, (O/R6), Z, Z, (-O/R6), Z, Z, Z, Z, Z, Z, Z, -1;Z, Z, Z, Z, Z, Z, Z, Kb, Z, Z, Z, Z, Z, -1, Z;Z, Z, Z, Z, Z, Z, Z, Z, -1, Z, Z, Z, Z, Z, Kc;Z, Z, Z, Z, 1, Z, Z, Z, -1, Z, Z, Z, Z, Z, Z]

B = [Va; Z; Z; Z; Z; -Id; Z; Z; Z; -Id; Z; Z; Z; Z; Z]

X = A\B

filename = "kirchhoff.tex";
file = fopen(filename, "w");

for i = 1:9
    if (i == 8)
        fprintf(file, "Vb & %7.7e\\\\\\hline ", double(X(i)));
    elseif (i == 9)
        fprintf(file, "Vc & %7.7e\\\\\\hline ", double(X(i)));
    else
        fprintf(file, "V%i & %7.7e\\\\\\hline ", i, double(X(i)));
    endif
endfor

for i = 10:15
    if (i == 14)
        fprintf(file, "Ib & %7.7e\\\\\\hline ", double(X(i)));
    elseif (i == 15)
        fprintf(file, "Ic & %7.7e\\\\\\hline ", double(X(i)));
    else
        fprintf(file, "I%i & %7.7e\\\\\\hline ", i-9, double(X(i)));
    endif
endfor

fflush(file);

fclose(file);

filename = "kirch-errors.tex";
file = fopen(filename, "w");

for i = 1:15
    fprintf(file, "%7.7e\n", double(X(i)));
endfor

fflush(file);

fclose(file);