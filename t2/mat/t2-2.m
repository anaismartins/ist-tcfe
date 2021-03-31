close all
clear all

file1 = fopen("voltage-nodes-t2.tex", "r");

valores1 = fileread('voltage-nodes-t2.tex');

valores1 = strsplit(valores1, {"\n"," ", "hline", "&", "\\"});

fclose(file1);

Vx = str2double(cell2mat(valores1(12)) ) - str2double(cell2mat(valores1(16)) );

file2 = fopen("../data.txt", "r");

valores2 = fileread('../data.txt')

valores2 = strsplit(valores2, {"\n"," "})

fclose(file2);

R1 = str2double(cell2mat(valores(23)) );
R2 = str2double(cell2mat(valores(26)) );
R3 = str2double(cell2mat(valores(29)) );
R4 = str2double(cell2mat(valores(32)) );
R5 = str2double(cell2mat(valores(35)) );
R6 = str2double(cell2mat(valores(38)) );
R7 = str2double(cell2mat(valores(41)) );

Vs = str2double(cell2mat(valores(44)) );

C = str2double(cell2mat(valores(47)) );

Kb = str2double(cell2mat(valores(50)));
Kd = str2double(cell2mat(valores(53)));

R1 = double(R1)*1000; %ohm
R2 = R2*1000;
R3 = R3*1000;
R4 = R4*1000;
R5 = R5*1000;
R6 = R6*1000;
R7 = R7*1000;

C = C*(10^(-6)); %farad

Kb = Kb*0.001; %siemen

Kd = Kd*1000; %ohm

%matriz

%    v0, v2, v3, v5, v6, v7, v8, Ix, Iy

A = [1, 0, 0, 0, 0, 0, 0, 0, 0;

1, -1/R1 - 1/R2 - 1/R3, 1/R2, 1/R3, 0, 0, 0, 0, 0;

0, 1/R2 + Kb, -1/R2, -Kb, 0, 0, 0, 0, 0;

-Kd/R6, 0, 0, 1, 0, Kd/R6, -1, 0, 0;

0, 0, 0, 0, 1, 0, -1, 0, 0;

1/R6, 0, 0, 0, 0, -1/R6 - 1/R7,  1/R7, 0, 0;

0, 0, 0, 0, 0, 1/R7, -1/R7, -1, -1;

1/R4, 1/R3, 0, -1/R3 - 1/R5 -1/R4, 1/R5, 0, 0, 0, 1;

0, -Kb, 0, Kb + 1/R5, -1/R5, 0, 0, 1, 0]

	

B = [0; 0; 0; 0; Vx; 0; 0; 0; 0]

X = A\B

Id = ( X(1) - X(6) ) / R6;
Vb = X(3) - X(5);
Ib = Kb * Vb;
Vd = Kd * Id;

%print voltage values in table

filename = "v(i)-2.tex";
file2 = fopen(filename, "w");

fprintf(file2, "V0 & %7.7e\\\\\hline ", double(X(1)));
fprintf(file2, "V2 & %7.7e\\\\\hline ", double(X(2)));
fprintf(file2, "V3 & %7.7e\\\\\hline ", double(X(3)));
fprintf(file2, "V5 & %7.7e\\\\\hline ", double(X(4)));
fprintf(file2, "V6 & %7.7e\\\\\hline ", double(X(5)));
fprintf(file2, "V7 & %7.7e\\\\\hline ", double(X(6)));
fprintf(file2, "V8 & %7.7e\\\\\hline ", double(X(7)));

%outras tensoes que nao fazem parte da matriz

fprintf(file2, "Vb & %7.7e\\\\\\hline ", Vb);
fprintf(file2, "Vd & %7.7e\\\\\\hline ", Vd);

fflush(file2);
fclose(file2);

%correntes pela Lei de Ohm

I1 = (X(1) - X(2))/R1;
I2 = (X(3) - X(2))/R2;
I3 = Vb/R3;
I4 = (X(4) - X(1))/R4;
I5 = (X(4) - X(5))/R5;
I7 = (X(6) - X(7))/R7;

%print current values in table

filename = "i(i)-2.tex";
file3 = fopen(filename, "w");

fprintf(file3, "Ix & %7.7e\\\\\hline ", double(X(8)));
fprintf(file3, "Iy & %7.7e\\\\\hline ", double(X(9)));
fprintf(file3, "I1 & %7.7e\\\\\hline ", I1);
fprintf(file3, "I2 & %7.7e\\\\\hline ", I2);
fprintf(file3, "I3 & %7.7e\\\\\hline ", I3);
fprintf(file3, "I4 & %7.7e\\\\\hline ", I4);
fprintf(file3, "I5 & %7.7e\\\\\hline ", I5);
fprintf(file3, "I7 & %7.7e\\\\\hline ", I7);
fprintf(file3, "Ib & %7.7e\\\\\hline ", Ib);
fprintf(file3, "Id & %7.7e\\\\\hline ", Id);

fflush(file3);
fclose(file3);