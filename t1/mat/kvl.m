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

zero = 0.0
one = 1.0

R1 = 1.02779694281e3 %kOhm
R2 = 2.07715672461e3%kOhm tyyy
R3 = 3.1156225241e3%kOhm
R4 = 4.11105908751e3%kOhm
R5 = 3.02879032081e3%kOhm
R6 = 2.02983164661e3 %kOhm
R7 = 1.00454956611e3 %kOhm
Va = 5.18504190779 %V
Id = 1.03147590492e-3 %mA
Kb = 7.00248816446e-3 %mS
Kc = 8.14562893937e3 %kOhm

a = [(R1+R4), zero, -R4, zero, one/Kb, zero; zero, one, zero, zero, one, zero; -R4, zero, (R4+R6+R7), zero, zero, Kc; zero, zero, zero, one, zero, zero; zero, zero, one, zero, zero, one; -R3, R3, zero, zero, one/Kb, zero]
x = [I1; I2; I3; I4; Ib; Ic]
b = [Va; zero; zero; -Id; zero; zero]

x = a\b
disp x