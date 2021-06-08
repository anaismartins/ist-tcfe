R1 = 1000; %Ohm
R2 = 1000; %Ohm
R3 = 100000; %Ohm
R4 = 1000; %Ohm

C1 = 1e-6; %F
C2 = 220e-9; %F

wL = 1 / (R1 * C1);
fL = wL / (2 * pi);

wH = 1 / (R2 * C2);
fH = wH / (2 * pi);

f = sqrt(fL * fH);
omega = 2 * pi * f;

ZC1 = 1/(j*omega*C1);
ZC2 = 1/(j*omega*C2);

Zi = ZC1 + R1;
Zo = 1/(1/R2 + 1/ZC2);

gaincomp = (R1*C1*j*omega)/(1 + R1*C1*j*omega) * (1 + (R3/R4)) * (1/(1 + R2*C2*j*omega));
gain = abs(gaincomp);
gaindB = 20 * log10(gain);


file = fopen("Teo1.tex", "w");

fprintf(file, "gain & %.4e\\\\\\hline ", gain);
fprintf(file, "gaindB & %.4e\\\\\\hline ", gaindB);
fprintf(file, "Zire & %.4e\\\\\\hline ", real(Zi));
fprintf(file, "Ziim & %.4e\\\\\\hline ", imag(Zi));
fprintf(file, "Zore & %.4e\\\\\\hline ", real(Zo));
fprintf(file, "Zoim & %.4e\\\\\\hline ", imag(Zo));

fflush(file);
fclose(file);

a = 1;

for i = 1:0.1:8.1 %ou seja, 10 pontos por década
  f = power(10, i);
  omega = 2 * pi * f;
  
  gaincomp = (R1*C1*j*omega)/(1 + R1*C1*j*omega) * (1 + (R3/R4)) * (1/(1 + R2*C2*j*omega));
  gain = abs(gaincomp);
  gaindB(a) = 20 * log10(gain);
  
  phase(a) = angle(gaincomp); %rad
  phase(a) = phase(a) * 180 / pi; %º
  
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
ylabel("Phase[deg]");

print (hf2, "phaseteo.eps", "-depsc");