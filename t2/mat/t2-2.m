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

%    v0, v2,vS,v5,v6,v7,v8

A = [1, 0, 0, 0, 0, 0, 0, 0;

0, 1, 0, 0, 0, 0, 0, 0;

0, 1/R1, -1/R1-1/R2-1/R3, 1/R2, 1/R3, 0, 0, 0;

0, 0, 1/R2 + Kb, -1/R2, -Kb, 0, 0, 0;

-Kd/R6, 0, 0, 0, 1, 0, Kd/R6, -1;

0, 0, -Kb, 0, 1/R5 + Kb, -1/R5,  0, 0;

1/R6, 0, 0, 0, 0, 0, -1/R6-1/R7, 1/R7;

1/R4, 0, 1/R3, 0, -1/R3-1/R5-1/R4, 1/R5, 1/R7, -1/R7]

	

B = [0; Vs; 0; 0; 0; 0; 0; 0]