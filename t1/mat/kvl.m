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

R1 = 1.02779694281e-3 %kOhm
R2 = 2.07715672461e-3%kOhm tyyy
R3 = 3.1156225241e-3%kOhm
R4 = 4.11105908751e-3%kOhm
R5 = 3.02879032081e-3%kOhm
R6 = 2.02983164661e-3 %kOhm
R7 = 1.00454956611e-3 %kOhm
Va = 5.18504190779 %V
Id = 1.03147590492e2 %mA
Kb = 7.00248816446e2 %mS
Kc = 8.14562893937e-3 %kOhm

a = [R1+R4, 0, -R4, 0, 1/Kb, 0; 0, 1, 0, 0, 1, 0; -R4, 0, (R4+R6+R7), 0, 0, Kc; 0, 0, 0, 1, 0, 0; 0, 0, 1, 0, 0, 1; -R3, R3, 0, 0, 1/Kb, 0, 0]
x = [I1; I2; I3; I4; Ib; Ic]
b = [Va; 0; 0; -Id; 0; 0]

x = a\b
disp x