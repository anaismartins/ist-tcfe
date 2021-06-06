R1 = 1000; %Ohm
R2 = 10000; %Ohm
R3 = 1000; %Ohm
R4 = 1000; %Ohm
RL = 8; %Ohm

Cin1 = 1e-6; %F
Cin2 = 1e-6; %F
Cin3 = 1e-6; %F

f = 2.383202e+03; %Hz
omega = 2 * pi * f;

Z1 = R1 + 1/(j * omega * Cin1);
Z2 = R3 + 1/(j * omega * Cin2);
Z3 = R4 + 1/(j * omega * Cin3);

Ztemp = 1/(1/Z1 + 1/Z2); %paralelo de Z1 com Z2
Zeq = 1/(1/Ztemp + 1/Z3); %impedância ao nível de inv_in

Vin = 0.01 * exp(j * pi / 2); %seno tem fase de pi/2

gaincomp = -R2/Zeq; %slide 2 aula 23
gain = abs(gaincomp);
gaindB = 20 * log10(gain);

Zi = real(Zeq); %slide 2 aula 23
Zo = 0; %estranho :/

file = fopen("Teo1.tex", "w");

fprintf(file, "gain & %.4e\\\\\\hline ", gain);
fprintf(file, "gaindB & %.4e\\\\\\hline ", gaindB);
fprintf(file, "Zi & %.4e\\\\\\hline ", Zi);
fprintf(file, "Zo & %.4e\\\\\\hline ", Zo);

fflush(file);
fclose(file);

a = 1;

for i = 1:0.1:8.1 %ou seja, 10 pontos por década
  f = power(10, i);
  omega = 2 * pi * f;
  Z1 = R1 + 1/(j * omega * Cin1);
  Z2 = R3 + 1/(j * omega * Cin2);
  Z3 = R4 + 1/(j * omega * Cin3);
  
  Ztemp = 1/(1/Z1 + 1/Z2); %paralelo de Z1 com Z2
  Zeq = 1/(1/Ztemp + 1/Z3); %impedância ao nível de inv_in

  Zeq2 = 1/(1/Z1 + 1/Z2 + 1/Z3) + R2; % usei para tentar calcular a fase mas está mal
  
  gaincomp = R2/Zeq; %slide 2 aula 23
  gain = abs(gaincomp);
  gaindB(a) = 20 * log10(gain);

  phase(a) = atan(RL/Zeq2); % está mal
  
  a = a + 1;
  
endfor

f = 1:0.1:8.1; %início, fim e 70 pontos pelo meio
hf = figure();
plot(f, gaindB);
legend("Gain");
xlabel("log(f)[Hz]");
ylabel("Gain[dB]");

print (hf, "gainteo.eps", "-depsc");

f = 1:0.1:8.1; %início, fim e 70 pontos pelo meio
hf2 = figure();
plot(f, phase);
legend("Phase");
xlabel("log(f)[Hz]");
ylabel("Phase[rad]");

print (hf2, "phaseteo.eps", "-depsc");