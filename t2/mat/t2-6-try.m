pkg load symbolic


file1 = fopen("../data.txt", "r");

valores1 = fileread('../data.txt');

valores1 = strsplit(valores1, {"\n"," "});

fclose(file1);

R1 = vpa(str2double(cell2mat(valores(23))));
R2 = vpa(str2double(cell2mat(valores(26))));
R3 = vpa(str2double(cell2mat(valores(29))));
R4 = vpa(str2double(cell2mat(valores(32))));
R5 = vpa(str2double(cell2mat(valores(35))));
R6 = vpa(str2double(cell2mat(valores(38))));
R7 = vpa(str2double(cell2mat(valores(41))));


C = vpa(str2double(cell2mat(valores(47))));

Kb = vpa(str2double(cell2mat(valores(50))));
Kd = vpa(str2double(cell2mat(valores(53))));


%corrigir unidades

R1 = R1*1000; %ohm
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

%    v0,v1,v2,v3,v5,v6,v7,v8

A = [
1, 0, 0, 0, 0, 0, 0, 0;

0, 1, 0, 0, 0, 0, 0, 0;

0, 1/R1, -1/R1-1/R2-1/R3, 1/R2, 1/R3, 0, 0, 0;

0, 0, 1/R2 + Kb, -1/R2, -Kb, 0, 0, 0;

-Kd/R6, 0, 0, 0, 1, 0, Kd/R6, -1;

0, 0, -Kb, 0, 1/R5 + Kb, -1/R5,  0, 0;

1/R6, 0, 0, 0, 0, 0, -1/R6-1/R7, 1/R7;

1/R4, 0, 1/R3, 0, -1/R3-1/R5-1/R4, 1/R5, 1/R7, -1/R7]

