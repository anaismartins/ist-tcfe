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

R1 = 1.02779694281 %kOhm
R2 = 2.07715672461 %kOhm
R3 = 3.1156225241 %kOhm
R4 = 4.11105908751 %kOhm
R5 = 3.02879032081 %kOhm
R6 = 2.02983164661 %kOhm
R7 = 1.00454956611 %kOhm
Va = 5.18504190779 %V
Id = 1.03147590492 %mA
Kb = 7.00248816446 %mS
Kc = 8.14562893937 %mS

a = [1/R1, -(R1+R2)/(R1*R2), 1/R2, 0, 0, 0, 0, -1/R3, 0; 0, 1/R2, -1/R2, 0, 0, 0, 0, Kb, 0; 0, 0, 0, 0, 1/R5, -1/R5, 0, -Kb, 0; 0, 0, 0, 1/R6, 0, 0, -(R6+R7)/(R6*R7), 0, 0; 1, 0, 0, -1, 0, 0, 0, 0, 0; 0, 1, 0, 0, -1, 0, 0 -1, 0; 0, 0, 0, 0, 1, 0, 0, 0, -1; 0, 0, 0, -1/R6, 0, 0, 1/R6, 0, 1/Kc; 0, 0, 0, 0, 0, 0, -1/R7, 0, Kc]

disp a