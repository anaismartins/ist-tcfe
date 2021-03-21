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

A = [(R1+R4), Z, -R4, Z, O/Kb, Z; Z, O, Z, Z, O, Z; -R4, Z, (R4+R6+R7), Z, Z, Kc; Z, Z, Z, O, Z, Z; Z, Z, O, Z, Z, O; -R3, R3, Z, Z, O/Kb, Z]
B = [Va; Z; Z; -Id; Z; Z]
X = [I1; I2; I3; I4; Ib; Ic]

X = A\B