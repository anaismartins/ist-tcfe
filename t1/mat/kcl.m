close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

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

a = [one/R1, -(R1+R2)/(R1*R2), one/R2, zero, zero, zero, zero, -one/R3, zero; zero, one/R2, -one/R2, zero, zero, zero, zero, Kb, zero; zero, zero, zero, zero, one/R5, -one/R5, zero, -Kb, zero; zero, zero, zero, one/R6, zero, zero, -(R6+R7)/(R6*R7), zero, zero; one, zero, zero, -one, zero, zero, zero, zero, zero; zero, one, zero, zero, -one, zero, zero -one, zero; zero, zero, zero, zero, one, zero, zero, zero, -one; zero, zero, zero, -one/R6, zero, zero, one/R6, zero, one/Kc; zero, zero, zero, zero, zero, zero, -one/R7, zero, Kc]
x = [V1; V2; V3; V4; V5; V6; V7; Vb; Vc]
b = [zero; zero; -Id; zero; Va; zero; zero; zero; zero]

x = a\b
