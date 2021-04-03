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

Vs = str2double(cell2mat(valores3(44)) );
C = str2double(cell2mat(valores3(47)) );
C = C*(10^(-6)); %farad

%time axis: -5ms to 20ms with 1us steps
t=0:1e-6:20e-3; %s
v6n = Vx * exp(-t/(Req*C));

f = 1000; %Hz
omega = 2*pi*f; %rad/s

v6fPHA = 1/(sqrt(1+omega*omega*Req*Req*C*C))*exp(j*(omega*t-atan(omega*Req*C)));
v6f = imag(v6fPHA);
hf = figure();

line([-5e-3 0], [Vx Vx], "color", "b");
hold on;
line([-5e-3 0], [Vs Vs], "color", "r");
hold on;
plot(t, v6n+v6f, "b");
hold on;
plot(t, sin(omega*t), "r");
hold on;

axis([-5e-3, 20e-3, -5, 10]);
xlabel("t[s]");
ylabel("V[V]");

%plot(t1, Vs, "r");
%plot(t2, sin(omega*t2), "r");

legend('v6(t)', 'vs(t)');

print (hf, "t2-5.eps", "-depsc");