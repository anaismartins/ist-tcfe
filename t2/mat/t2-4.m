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

f = 1000; %Hz
omega = 2*pi*f; %rad/s

%   v0, v1, v2, v3, v5, v6, v7, v8

A = [1, 0, 0, 0, 0, 0, 0, 0;

-1, 1, 0, 0, 0, 0, 0, 0;

0, 1/R1, -1/R1-1/R2-1/R3, 1/R2, 1/R3, 0, 0, 0;

0, 0, Kb+1/R2, -1/R2, -Kb, 0, 0, 0;

-Kd/R6, 0, 0, 0, 1, 0, Kd/R6, -1;

0, 0, -Kb, 0, 1/R5+Kb, -1/R5-j*omega*C, 0, j*omega*C;

1/R6, 0, 0, 0, 0, 0, -1/R6-1/R7, 1/R7;

1/R4, 0, 1/R3, 0, -1/R3-1/R5-1/R4, 1/R5+j*omega*C, 1/R7, -1/R7-j*omega*C]

%1/R6+1/R4, 1/R1, -1/R1, 0, -1/R4, 0, -1/R6, 0]

printf("Determinante da matriz A: %f", det(A))

B = [0; 1; 0; 0; 0; 0; 0; 0]

X = A\B

%print voltage values in table

filename = "v(i)-4.tex";
file4 = fopen(filename, "w");

fprintf(file4, "V0real & %7.7e\\\\\hline ", real(X(1)));
fprintf(file4, "V1real & %7.7e\\\\\hline ", real(X(2)));
fprintf(file4, "V2real & %7.7e\\\\\hline ", real(X(3)));
fprintf(file4, "V3real & %7.7e\\\\\hline ", real(X(4)));
fprintf(file4, "V5real & %7.7e\\\\\hline ", real(X(5)));
fprintf(file4, "V6real & %7.7e\\\\\hline ", real(X(6)));
fprintf(file4, "V7real & %7.7e\\\\\hline ", real(X(7)));
fprintf(file4, "V8real & %7.7e\\\\\hline ", real(X(8)));

fprintf(file4, "\n\n\n");

fprintf(file4, "V0imag & %7.7e\\\\\hline ", imag(X(1)));
fprintf(file4, "V1imag & %7.7e\\\\\hline ", imag(X(2)));
fprintf(file4, "V2imag & %7.7e\\\\\hline ", imag(X(3)));
fprintf(file4, "V3imag & %7.7e\\\\\hline ", imag(X(4)));
fprintf(file4, "V5imag & %7.7e\\\\\hline ", imag(X(5)));
fprintf(file4, "V6imag & %7.7e\\\\\hline ", imag(X(6)));
fprintf(file4, "V7imag & %7.7e\\\\\hline ", imag(X(7)));
fprintf(file4, "V8imag & %7.7e\\\\\hline ", imag(X(8)));

fflush(file4);
fclose(file4);

##t=0:1e-6:20e-3; %s
##
##V6real = real(X(6));
##V6imag = imag(X(6));
##
##v6fCOMP = (V6real+V6imag)*exp(j*omega*t);
##v6f = imag(v6fCOMP);
##
##hf = figure ();
##plot (t, v6f);
##
##xlabel ("t[s]");
##ylabel ("v6f [V]");
##print (hf, "t2-4.eps", "-depsc");