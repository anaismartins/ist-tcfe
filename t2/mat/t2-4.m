close all
clear all

file1 = fopen("Req-t2-2.tex", "r");

valores1 = fileread('Req-t2-2.tex');

valores1 = strsplit(valores1, {"\n"," ", "hline", "&", "\\"});

fclose(file1);

Req = str2double(cell2mat(valores1(2)) );

file2 = fopen("../data.txt", "r");

valores2 = fileread('../data.txt');

valores2 = strsplit(valores2, {"\n"," "});

fclose(file2);

C = str2double(cell2mat(valores2(47)) );
C = C*(10^(-6)); %farad

f = 1000; %Hz
omega = 2*pi*f; %rad/s

t=0:1e-6:20e-3; %s

v6fPHA = exp(j*omega*t)/(1+j*omega*Req*C);
v6f = imag(v6fPHA);

hf = figure ();
plot (t, v6f);

xlabel ("t[s]");
ylabel ("v6f [V]");
print (hf, "t2-4.eps", "-depsc");

file3 = fopen("../data.txt", "r");

valores3 = fileread('../data.txt');

valores3 = strsplit(valores3, {"\n"," "});

fclose(file3);

R1 = str2double(cell2mat(valores3(23)) );
R2 = str2double(cell2mat(valores3(26)) );
R3 = str2double(cell2mat(valores3(29)) );
R4 = str2double(cell2mat(valores3(32)) );
R5 = str2double(cell2mat(valores3(35)) );
R6 = str2double(cell2mat(valores3(38)) );
R7 = str2double(cell2mat(valores3(41)) );

Vs = str2double(cell2mat(valores3(44)) );

Kb = str2double(cell2mat(valores3(50)));
Kd = str2double(cell2mat(valores3(53)));

R1 = double(R1)*1000; %ohm
R2 = R2*1000;
R3 = R3*1000;
R4 = R4*1000;
R5 = R5*1000;
R6 = R6*1000;
R7 = R7*1000;

Kb = Kb*0.001; %siemen

Kd = Kd*1000; %ohm

%   v0, v1, v2, v3, v5, v6, v7, v8

A = [1, 0, 0, 0, 0, 0, 0, 0;

-1, 1, 0, 0, 0, 0, 0, 0;

0, 1/R1, -1/R1-1/R2-1/R3, 1/R2, 1/R3, 0, 0, 0;

0, 0, Kb+1/R2, -1/R2, -Kb, 0, 0, 0;

-Kd/R6, 0, 0, 0, 1, 0, Kd/R6, -1;

0, 0, -Kb, 0, 1/R5+Kb, -1/R5-j*omega*C, 0, j*omega*C;

1/R6, 0, 0, 0, 0, 0, -1/R6-1/R7, 1/R7;

1/R4, 0, 1/R3, 0, -1/R3-1/R5-1/R4, 1/R5, 1/R7, -1/R7]

%1/R6+1/R4, 1/R1, -1/R1, 0, -1/R4, 0, -1/R6, 0]

printf("Determinante da matriz A: %f", det(A))

B = [0; 1; 0; 0; 0; 0; 0; 0]

X = A\B

%print voltage values in table

filename = "v(i)-4.tex";
file4 = fopen(filename, "w");

fprintf(file4, "V0 & %7.7e\\\\\hline ", double(X(1)));
fprintf(file4, "V1 & %7.7e\\\\\hline ", double(X(2)));
fprintf(file4, "V2 & %7.7e\\\\\hline ", double(X(3)));
fprintf(file4, "V3 & %7.7e\\\\\hline ", double(X(4)));
fprintf(file4, "V5 & %7.7e\\\\\hline ", double(X(5)));
fprintf(file4, "V6 & %7.7e\\\\\hline ", double(X(6)));
fprintf(file4, "V7 & %7.7e\\\\\hline ", double(X(7)));
fprintf(file4, "V8 & %7.7e\\\\\hline ", double(X(8)));

fflush(file4);
fclose(file4);