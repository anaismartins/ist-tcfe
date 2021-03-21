close all
clear all

pkg load symbolic

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

A = [O/R1, -(R1*R2+R1*R3+R2*R3)/(R1*R2*R3), O/R2, Z, O/R3, Z, Z, Z, Z; Z, O/R2, -O/R2, Z, Z, Z, Z, Kb, Z; Z, Z, Z, Z, O/R5, -O/R5, Z, -Kb, Z; Z, Z, Z, O/R6, Z, Z, -(R6+R7)/(R6*R7), Z, Z; O, Z, Z, -O, Z, Z, Z, Z, Z; Z, O, Z, Z, -O, Z, Z -O, Z; Z, Z, Z, Z, O, Z, Z, Z, -O; Z, Z, Z, -O/R6, Z, Z, O/R6, Z, O/Kc; Z, Z, Z, Z, Z, Z, -O/R7, Z, Kc]
X = [V1; V2; V3; V4; V5; V6; V7; Vb; Vc]
B = [Z; Z; -Id; Z; Va; Z; Z; Z; Z]

X = A\B

Ib = Kb * X(8)
Ic = X(9) / Kc

filename = "kcl.tex";
file = fopen(filename, "w");

for i = 1:9
    if (i == 8)
        fprintf(file, "Vb & %12.12f\\\\\\hline ", double(X(i)));
    elseif (i == 9)
        fprintf(file, "Vc & %12.12f\\\\\\hline ", double(X(i)));
    else
        fprintf(file, "V%i & %12.12f\\\\\\hline ", i, double(X(i)));
    endif
endfor

fprintf(file, "Ib & %12.12f\\\\\\hline ", double(Ib));
fprintf(file, "Ic & %12.12f\\\\\\hline ", double(Ic));

fflush(file);

fclose(file);