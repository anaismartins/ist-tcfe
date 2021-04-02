close all
clear all

file1 = fopen("Req-t2-2.tex", "r");

valores1 = fileread('Req-t2-2.tex');

valores1 = strsplit(valores1, {"\n"," ", "hline", "&", "\\"});

fclose(file1);

Req = str2double(cell2mat(valores1(2)) );





file2 = fopen("voltage-nodes-t2-1.tex", "r");

valores2 = fileread('voltage-nodes-t2-1.tex');

valores2 = strsplit(valores2, {"\n"," ", "hline", "&", "\\"});

fclose(file2);


Vx = str2double(cell2mat(valores2(12)) ) - str2double(cell2mat(valores2(16)) );



file3 = fopen("../data.txt", "r");

valores3 = fileread('../data.txt');

valores3 = strsplit(valores3, {"\n"," "});

fclose(file3);

C = str2double(cell2mat(valores3(47)) );
C = C*(10^(-6)); %farad


printf("Req: %f, Vx: %f, C: %f\n", Req, Vx, C)



%time axis: 0 to 20ms with 1us steps
t=0:1e-6:20e-3; %s
v1 = Vx * exp(-t/(Req*C));
hf = figure();


%printf("%g", v1);

%t = linspace(0,20e-3,20000);

plot(t,v1)
hold on

axis([0, 20e-3, 0, 10]);
xlabel("t[s]");
ylabel("v6n[V]");
%print(hf, "t2-3.pdf");
print (hf, "t2-3.eps", "-depsc");

%printf("\n\n\n v1(20ms) = %f\n\n\n",v1(20e-3))

%print('plot','-dpng')