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

V8 = str2double(cell2mat(valores2(16)) );

Vx = str2double(cell2mat(valores2(12)) ) - V8;

file3 = fopen("../data.txt", "r");

valores3 = fileread('../data.txt');

valores3 = strsplit(valores3, {"\n"," "});

fclose(file3);

Vs = str2double(cell2mat(valores3(44)) );
C = str2double(cell2mat(valores3(47)) );
C = C*(10^(-6)); %farad

file4 = fopen("Req-t2-2.tex", "r");

valores4 = fileread('v(i)-4.tex');

valores4 = strsplit(valores4, {"\n"," ", "hline", "&", "\\"});

fclose(file4);

V6real = str2double(cell2mat(valores4(12)));
V6imag = str2double(cell2mat(valores4(28)));


t=20e-3; %s
f = logspace(-1, 6, 20000); %10^-1 até 10^6, 20000 pontos
omega = 2*pi*f;
hf = figure();

%magnitudes

v6n = Vx * exp(-t/(Req*C));
v6fCOMP = (V6real+j*V6imag)*exp(j*omega*t);
v6f = imag(v6fCOMP);
v6 = v6n + v6f;
semilogx(f, v6n+abs(v6fCOMP));
hold on;

xlabel("f[Hz]");
ylabel("V[V]");

legend("v6");

print (hf, "t2-6-mag.eps", "-depsc");

hold off;

%fases

semilogx(f, angle((v6fCOMP)));
hold on;

xlabel("f[Hz]");
ylabel("fase [rad]");

legend("v6");

print (hf, "t2-6-fase.eps", "-depsc");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ate aqui fixe... talvez seja perciso tirar valores de v8 tmb mas no biggie


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5v8n = ????

%vcn = v6n - v8n

