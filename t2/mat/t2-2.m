close all
clear all

file1 = fopen("voltage-nodes-t2-1.tex", "r");

valores1 = fileread('voltage-nodes-t2-1.tex');

valores1 = strsplit(valores1, {"\n"," ", "hline", "&", "\\"});

fclose(file1);

Vx = str2double(cell2mat(valores1(12)) ) - str2double(cell2mat(valores1(16)) );

file2 = fopen("../data.txt", "r");

valores2 = fileread('../data.txt');

valores2 = strsplit(valores2, {"\n"," "});

fclose(file2);

R1 = str2double(cell2mat(valores2(23)) );
R2 = str2double(cell2mat(valores2(26)) );
R3 = str2double(cell2mat(valores2(29)) );
R4 = str2double(cell2mat(valores2(32)) );
R5 = str2double(cell2mat(valores2(35)) );
R6 = str2double(cell2mat(valores2(38)) );
R7 = str2double(cell2mat(valores2(41)) );

Vs = str2double(cell2mat(valores2(44)) );

C = str2double(cell2mat(valores2(47)) );

Kb = str2double(cell2mat(valores2(50)));
Kd = str2double(cell2mat(valores2(53)));

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

1/R1, -1/R1-1/R2-1/R3, 1/R2, 1/R3, 0, 0, 0, 0, 0;

0, 1/R2+Kb, -1/R2, -Kb, 0, 0, 0, 0, 0;

-Kd/R6, 0, 0, 1, 0, Kd/R6, -1, 0, 0;

0, 0, 0, 0, 1, 0, -1, 0, 0;

1/R6, 0, 0, 0, 0, -1/R6-1/R7, 1/R7, 0, 0;

0, 0, 0, 0, 0, 1/R7, -1/R7, -1, -1;

1/R4, 1/R3, 0, -1/R3-1/R5-1/R4, 1/R5, 0, 0, 0, 1;

0, -Kb, 0, Kb+1/R5, -1/R5, 0, 0, 1, 0]

printf("Determinante da matriz A: %f", det(A))

B = [0; 0; 0; 0; Vx; 0; 0; 0; 0]

%    v0, v2, v3, v5, v6, v7, v8

##A = [1, 0, 0, 0, 0, 0, 0;
##
##1/R1, -1/R1-1/R2-1/R3, 1/R2, 1/R3, 0, 0, 0;
##
##0, 1/R2+Kb, -1/R2, -Kb, 0, 0, 0;
##
##-Kd/R6, 0, 0, 1, 0, Kd/R6, -1;
##
##0, 0, 0, 0, 1, 0, -1;
##
##1/R6, 0, 0, 0, 0, -1/R6-1/R7, 1/R7;
##
##1/R1+1/R6+1/R4, -1/R1, 0, -1/R4, 0, -1/R6, 0]
##
##B = [0; 0; 0; 0; Vx; 0; 0]

X = A\B

Id = (X(1)-X(6))/R6;
Vb = X(2)-X(4);
Ib = Kb*Vb;
Vd = Kd*Id;

%print voltage values in table

filename = "v(i)-2.tex";
file3 = fopen(filename, "w");

fprintf(file3, "V0 & %7.7e\\\\\hline ", double(X(1)));
fprintf(file3, "V2 & %7.7e\\\\\hline ", double(X(2)));
fprintf(file3, "V3 & %7.7e\\\\\hline ", double(X(3)));
fprintf(file3, "V5 & %7.7e\\\\\hline ", double(X(4)));
fprintf(file3, "V6 & %7.7e\\\\\hline ", double(X(5)));
fprintf(file3, "V7 & %7.7e\\\\\hline ", double(X(6)));
fprintf(file3, "V8 & %7.7e\\\\\hline ", double(X(7)));

%outras tensoes que nao fazem parte da matriz

fprintf(file3, "Vb & %7.7e\\\\\\hline ", Vb);
fprintf(file3, "Vd & %7.7e\\\\\\hline ", Vd);

fflush(file3);
fclose(file3);

%correntes pela Lei de Ohm

I1 = (X(1)-X(2))/R1;
I2 = (X(3)-X(2))/R2;
I3 = Vb/R3;
I4 = (X(4)-X(1))/R4;
I5 = (X(4)-X(5))/R5;
I7 = (X(6)-X(7))/R7;

%Ix = Ib - ((X(4)) - X(5))/R5;

%print current values in table

filename = "i(i)-2.tex";
file4 = fopen(filename, "w");

fprintf(file4, "Ix & %7.7e\\\\\hline ", double(X(8)));
fprintf(file4, "Iy & %7.7e\\\\\hline ", double(X(9)));
fprintf(file4, "I1 & %7.7e\\\\\hline ", I1);
fprintf(file4, "I2 & %7.7e\\\\\hline ", I2);
fprintf(file4, "I3 & %7.7e\\\\\hline ", I3);
fprintf(file4, "I4 & %7.7e\\\\\hline ", I4);
fprintf(file4, "I5 & %7.7e\\\\\hline ", I5);
fprintf(file4, "I7 & %7.7e\\\\\hline ", I7);
fprintf(file4, "Ib & %7.7e\\\\\hline ", Ib);
fprintf(file4, "Id & %7.7e\\\\\hline ", Id);

fflush(file4);
fclose(file4);

filename = "Req-t2-2.tex";
file5 = fopen(filename, "w");

fprintf(file5, "Req & %7.7e\\\\\hline ", double(Vx/X(8)));

fflush(file5);
fclose(file5);





%SÓ FICHEIROS .CIR ABAIXO

spice3 = fopen("spicedata-3.cir", "w");

fprintf(spice3, ".TRAN 1ms 20ms\n");
fprintf(spice3, "R1 1 2 %f\n", R1);
fprintf(spice3, "R2 3 2 %f\n", R2);
fprintf(spice3, "R3 2 5 %f\n", R3);
fprintf(spice3, "R4 5 0 %f\n", R4);
fprintf(spice3, "R5 5 6 %f\n", R5);
fprintf(spice3, "R6 9 7 %f\n", R6);
fprintf(spice3, "R7 7 8 %f\n", R7);

fprintf(spice3, "Vs 1 0 1.0 ac 1.0 sin(0 6.283185307 1.0)\n");

fprintf(spice3, "Ve 0 9 0V\n");
fprintf(spice3, "Hd 5 8 Ve %f\n", Kd);

fprintf(spice3, "Gb 6 3 (2,5) %f\n", Kb);

fprintf(spice3, "C1 6 8 %f\n", C);
fprintf(spice3, ".model P2model NPN(Bf=200, CJE=12pF, CJC=2pF)\n");

fprintf(spice3, ".ic v(6)=%f v(8)=%f\n.END\n", X(5), X(7));

fclose(spice3);



spice45 = fopen("spicedata-45.cir", "w");

fprintf(spice45, ".TRAN 1ms 20ms\n");
fprintf(spice45, "R1 1 2 %f\n", R1);
fprintf(spice45, "R2 3 2 %f\n", R2);
fprintf(spice45, "R3 2 5 %f\n", R3);
fprintf(spice45, "R4 5 0 %f\n", R4);
fprintf(spice45, "R5 5 6 %f\n", R5);
fprintf(spice45, "R6 9 7 %f\n", R6);
fprintf(spice45, "R7 7 8 %f\n", R7);

fprintf(spice45, "Vs 1 0 1.0 ac 1.0 sin(0 6.283185307 1.0k)\n");

fprintf(spice45, "Ve 0 9 0V\n");
fprintf(spice45, "Hd 5 8 Ve %f\n", Kd);

fprintf(spice45, "Gb 6 3 (2,5) %f\n", Kb);

fprintf(spice45, "C1 6 8 %f\n", C);
fprintf(spice45, ".model P2model NPN(Bf=200, CJE=12pF, CJC=2pF)\n");

fprintf(spice45, ".ic v(6)=%f v(8)=%f\n.END\n", X(5), X(7));

fclose(spice45);
