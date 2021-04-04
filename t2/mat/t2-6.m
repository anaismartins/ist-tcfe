close all
clear all

pkg load symbolic
pkg load control

file1 = fopen("t2-t2-Req.tex", "r");

valores1 = fileread('t2-t2-Req.tex');

valores1 = strsplit(valores1, {"\n"," ", "hline", "&", "\\"});

fclose(file1);

Req = str2double(cell2mat(valores1(2)) );

file2 = fopen("../data.txt", "r");

valores2 = fileread('../data.txt');

file2 = fopen("t2-t1-voltages.tex", "r");

valores2 = fileread('t2-t1-voltages.tex');
valores2 = strsplit(valores2, {"\n"," "});

fclose(file2);

R1 = vpa(str2double(cell2mat(valores2(23)) ))
R2 = vpa(str2double(cell2mat(valores2(26)) ))
R3 = vpa(str2double(cell2mat(valores2(29)) ))
R4 = vpa(str2double(cell2mat(valores2(32)) ))
R5 = vpa(str2double(cell2mat(valores2(35)) ))
R6 = vpa(str2double(cell2mat(valores2(38)) ))
R7 = vpa(str2double(cell2mat(valores2(41)) ))

%Vs = vpa(str2double(cell2mat(valores2(44)) ))

C = vpa(str2double(cell2mat(valores2(47)) ))

Kb = vpa(str2double(cell2mat(valores2(50))))
Kd = vpa(str2double(cell2mat(valores2(53))))

##R1 = vpa(R1);
##R2 = vpa(R2);
##R3 = vpa(R3);
##R4 = vpa(R4);
##R5 = vpa(R5);
##R6 = vpa(R6);
##R7 = vpa(R7);
##Vs = vpa(Vs);
##C = vpa(C);
##Kb = vpa(Kb);
##Kd = vpa(Kd);

display(R1);

PI = vpa(pi);

R1 = vpa(R1*1000); %ohm
R2 = vpa(R2*1000);
R3 = vpa(R3*1000);
R4 = vpa(R4*1000);
R5 = vpa(R5*1000);
R6 = vpa(R6*1000);
R7 = vpa(R7*1000);

C = vpa(C*(10^(-6))); %farad

Kb = vpa(Kb*0.001); %siemen

Kd = vpa(Kd*1000); %ohm

syms f real;
Zc = 1/(j*2*PI*f*C);

G1 = vpa(1/R1);
G2 = vpa(1/R2);
G3 = vpa(1/R3);
G4 = vpa(1/R4);
G5 = vpa(1/R5);
G6 = vpa(1/R6);
G7 = vpa(1/R7);



file4 = fopen("t2-t4-voltages.tex", "r");

valores4 = fileread('t2-t4-voltages.tex');

A1 = [1, 0, 0, 0, 0, 0, 0, 0]

A2 = [-1, 1, 0, 0, 0, 0, 0, 0]

A3 = [0, G1, -G1-G2-G3, G2, G3, 0, 0, 0]

A4 = [0, 0, Kb+G2, -G2, -Kb, 0, 0, 0]

A5 = [-Kd*G6, 0, 0, 0, 1, 0, Kd*G6, -1]

A6 = [0, 0, -Kb, 0, G5+Kb, -G5-1/Zc, 0, 1/Zc]

A7 = [G6, 0, 0, 0, 0, 0, -G6-G7, G7]

A8 = [G4, 0, G3, 0, -G3-G5-G4, G5+1/Zc, G7, -G7-1/Zc]

A = [A1; A2; A3; A4; A5; A6; A7; A8]

B = [0; 1; 0; 0; 0; 0; 0; 0]

X = A\B

F = logspace(-1, 6, 20000); %10^-1 até 10^6, 20000 pontos

[N6, D6] = numden(X(6))
[N8, D8] = numden(X(8))

N6_real = real(N6);
N6_imag = imag(N6);
D6_real = real(D6);
D6_imag = imag(D6);
N8_real = real(N8);
N8_imag = imag(N8);
D8_real = real(D8);
D8_imag = imag(D8);

N6 = [N6_imag, N6_real]
D6 = [D6_imag, D6_real]
N8 = [N8_imag, N8_real]
D8 = [D8_imag, D8_real]

print (hf, "t2-t6-mag.eps", "-depsc");
%a tirar o f da expressão

file3 = fopen("valores-bode.tex", "w");

fprintf(file3, "%s %s %s %s %s %s %s %s", char(N6(1)), char(N6(2)), char(D6(1)),
 char(D6(2)), char(N8(1)), char(N8(2)), char(D8(1)), char(D8(2)));
 
fclose(file3);

file4 = fopen("valores-bode.tex", "r");
valores4 = fileread("valores-bode.tex");
valores4 = strsplit(valores4, {"\n"," ", "f", "*"})
fclose(file4);

N6 = [str2double(cell2mat(valores4(1))), str2double(cell2mat(valores4(2)))];
D6 = [str2double(cell2mat(valores4(3))), str2double(cell2mat(valores4(4)))];
N8 = [str2double(cell2mat(valores4(5))), str2double(cell2mat(valores4(6)))];
D8 = [str2double(cell2mat(valores4(7))), str2double(cell2mat(valores4(8)))];

V6 = tf(N6, D6);
V8 = tf(N8, D8);

Vc = V6-V8;

vs = tf([0, 1], [0, 1]);

hf = figure();

bode(vs, V6, Vc, F);
hold on;

xlabel("f[Hz]");

print (hf, "t2-6.eps", "-depsc");

##%magnitudes
##
##semilogx(f, v6n+abs(v6fCOMP));
##
##hold on;
##
##xlabel("f[Hz]");
##ylabel("V[V]");
##
##legend("v6");
##
##print (hf, "t2-6-mag.eps", "-depsc");
##
##hold off;

print (hf, "t2-t6-fase.eps", "-depsc");

%fases
##semilogx(f, angle((v6fCOMP)));
##
##hold on;
##
##xlabel("f[Hz]");
##ylabel("fase [rad]");
##
##legend("v6");
##
##print (hf, "t2-6-fase.eps", "-depsc");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ate aqui fixe... talvez seja perciso tirar valores de v8 tmb mas no biggie


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5v8n = ????

%vcn = v6n - v8n

