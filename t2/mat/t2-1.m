%numeric calculation

close all
clear all

pkg load symbolic

file = fopen("../data.txt", "r");

valores = fileread('../data.txt')

valores = strsplit(valores, {"\n"," "})

fclose(file);

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


%corrigir unidades

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

	

B = [0; Vs; 0; 0; 0; 0; 0; 0]


X = A\B


Id = ( X(1) - X(7) ) / R6;

Ib = Kb * ( X(3) - X(5));

Vd = Kd * Id;

Vb = X(3) - X(5);


%print values in table

filename = "t2-t1-voltages.tex";
file0 = fopen(filename, "w");

for i = 1:8

    if (i <= 4)
    	fprintf(file0, "V%i & %7.7e\\\\\\hline ", i-1, double(X(i)));

    else
    	fprintf(file0, "V%i & %7.7e\\\\\\hline ", i, double(X(i)));

    endif

endfor


%outras tensoes que nao fazem parte da matriz

fprintf(file0, "Vb & %7.7e\\\\\\hline ", Vb);
fprintf(file0, "Vd & %7.7e\\\\\\hline ", Vd);


fflush(file0);

fclose(file0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%calculo das correntes - lei de ohm

I1 = (X(2) - X(3))/R1;
I2 = (X(4) - X(3))/R2;
I3 = Vb/R3;
I4 = (X(5) - X(1))/R4;
I5 = (X(5) - X(6))/R5;
I7 = (X(7) - X(8))/R7;

%Id e Ib em cima


filename1 = "t2-t1-currents.tex";
file1 = fopen(filename1, "w");


fprintf(file1, "I1 & %7.7e\\\\\\hline ", I1);
fprintf(file1, "I2 & %7.7e\\\\\\hline ", I2);
fprintf(file1, "I3 & %7.7e\\\\\\hline ", I3);
fprintf(file1, "I4 & %7.7e\\\\\\hline ", I4);
fprintf(file1, "I5 & %7.7e\\\\\\hline ", I5);
fprintf(file1, "I6 & %7.7e\\\\\\hline ", Id);
fprintf(file1, "I7 & %7.7e\\\\\\hline ", I7);
fprintf(file1, "Ib & %7.7e\\\\\\hline ", Ib);
fprintf(file1, "Id & %7.7e\\\\\\hline ", Id);
fprintf(file1, "Id & %7.7e\\\\\\hline ", 0);



fflush(file1);

fclose(file1);


% SÓ SPICES ABAIXO


spice1 = fopen("spicedata-1.cir", "w");

fprintf(spice1, ".OP\n");
fprintf(spice1, "R1 1 2 %f\n", R1);
fprintf(spice1, "R2 3 2 %f\n", R2);
fprintf(spice1, "R3 2 5 %f\n", R3);
fprintf(spice1, "R4 5 0 %f\n", R4);
fprintf(spice1, "R5 5 6 %f\n", R5);
fprintf(spice1, "R6 9 7 %f\n", R6);
fprintf(spice1, "R7 7 8 %f\n", R7);

fprintf(spice1, "Vs 1 0 %f\n", Vs);

fprintf(spice1, "Ve 0 9 0V\n");
fprintf(spice1, "Hd 5 8 Ve %f\n", Kd);

fprintf(spice1, "Gb 6 3 (2,5) %f\n.END\n", Kb);

fclose(spice1);



spice2 = fopen("spicedata-2.cir", "w");

fprintf(spice2, ".OP\n");
fprintf(spice2, "R1 0 2 %f\n", R1);
fprintf(spice2, "R2 3 2 %f\n", R2);
fprintf(spice2, "R3 2 5 %f\n", R3);
fprintf(spice2, "R4 5 0 %f\n", R4);
fprintf(spice2, "R5 5 6 %f\n", R5);
fprintf(spice2, "R6 9 7 %f\n", R6);
fprintf(spice2, "R7 7 8 %f\n", R7);

fprintf(spice2, "Vx 6 8 %f\n", X(6) - X(8));

fprintf(spice2, "Ve 0 9 0V\n");
fprintf(spice2, "Hd 5 8 Ve %f\n", Kd);

fprintf(spice2, "Gb 6 3 (2,5) %f\n.END\n", Kb);

fclose(spice2);


