%gain stage

VT=25e-3;
BFN=178.7; %parâmetro do transistor NPN
VAFN=69.7; %parâmetro do transistor NPN
RE1=100;
RC1=1000;
RB1=80000;
RB2=20000;
VBEON=0.7;
VCC=12;
RS=100;

RB=1/(1/RB1+1/RB2); %Resistência equivalente
VEQ=RB2/(RB1+RB2)*VCC; %slide 7 aula 17
IB1=(VEQ-VBEON)/(RB+(1+BFN)*RE1); %em zona ativa direta (o estado do transistor), VBE = VBEON
IC1=BFN*IB1;
IE1=(1+BFN)*IB1;
VE1=RE1*IE1;
VO1=VCC-RC1*IC1; %que é também a tensão no coletor 1
VCE=VO1-VE1;

gm1=IC1/VT;
rpi1=BFN/gm1;
ro1=VAFN/IC1;

RSB=RB*RS/(RB+RS);

AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2); %vout/vin
AVI_DB = 20*log10(abs(AV1));
AV1simple = RB/(RB+RS) * gm1*RC1/(1+gm1*RE1);
AVIsimple_DB = 20*log10(abs(AV1simple));

RE1=0;
AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2);
AVI_DB = 20*log10(abs(AV1));
AV1simple =  - RSB/RS * gm1*RC1/(1+gm1*RE1);
AVIsimple_DB = 20*log10(abs(AV1simple));

RE1=100;
ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)));
ZX = ro1*((RB+rpi1)*RE1/(RSB+rpi1+RE1))/(1/(1/ro1+1/(rpi1+RSB)+1/RE1+gm1*rpi1/(rpi1+RSB)));
ZX = ro1*(   1/RE1+1/(rpi1+RSB)+1/ro1+gm1*rpi1/(rpi1+RSB)  )/(   1/RE1+1/(rpi1+RSB) ); % outro a definir ZX logo a seguir?????
ZO1 = 1/(1/ZX+1/RC1);

RE1=0;
ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)));
ZO1 = 1/(1/ro1+1/RC1);

file = fopen("gainteo.tex", "w");

fprintf(file, "IB1 & %.4e\\\\\\hline ", IB1);
fprintf(file, "IC1 & %.4e\\\\\\hline ", IC1);
fprintf(file, "IE1 & %.4e\\\\\\hline ", IE1);
fprintf(file, "VE1 & %.4e\\\\\\hline ", VE1);
fprintf(file, "VO1 & %.4e\\\\\\hline ", VO1);
fprintf(file, "VCE1 & %.4e\\\\\\hline ", VCE);
fprintf(file, "gain1 & %.4e\\\\\\hline ", abs(AV1));
fprintf(file, "ZI1 & %.4e\\\\\\hline ", ZI1);
fprintf(file, "ZO1 & %.4e\\\\\\hline ", ZO1);

fflush(file);
fclose(file);

%ouput stage
BFP = 227.3; %parâmetro do transistor PNP
VAFP = 37.2; %parâmetro do transistor PNP
RE2 = 100;
VEBON = 0.7;
VI2 = VO1; %tensão do coletor 1
IE2 = (VCC - VEBON - VI2) / RE2; %(VCC - VE2)/Rout; VEBON = VEB = VE - VB <=> VE = VEB + VB
IC2 = BFP / (BFP + 1) * IE2;
VO2 = VCC - RE2 * IE2;


gm2 = IC2 / VT;
go2 = IC2  /VAFP;
gpi2 = gm2 / BFP;
ge2 = 1 / RE2;

AV2 = gm2/(gm2+gpi2+go2+ge2);
ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2);
ZO2 = 1/(gm2+gpi2+go2+ge2);

file = fopen("outputteo.tex", "w");

fprintf(file, "VI2 & %.4e\\\\\\hline ", VI2);
fprintf(file, "IE2 & %.4e\\\\\\hline ", IE2);
fprintf(file, "IC2 & %.4e\\\\\\hline ", IC2);
fprintf(file, "VO2 & %.4e\\\\\\hline ", VO2);
fprintf(file, "gain2 & %.4e\\\\\\hline ", abs(AV2));
fprintf(file, "ZI2 & %.4e\\\\\\hline ", ZI2);
fprintf(file, "ZO2 & %.4e\\\\\\hline ", ZO2);

fflush(file);
fclose(file);


%total
gB = 1/(1/gpi2+ZO1);
AV = (gB+gm2/gpi2*gB)/(gB+ge2+go2+gm2/gpi2*gB)*AV1;
AV_DB = 20*log10(abs(AV));
ZI=ZI1;
ZO=1/(go2+gm2/gpi2*gB+ge2+gB);

file = fopen("totalteo.tex", "w");

fprintf(file, "gain & %.4e\\\\\\hline ", abs(AV));
fprintf(file, "ZI & %.4e\\\\\\hline ", ZI);
fprintf(file, "ZO & %.4e\\\\\\hline ", ZO);

fflush(file);
fclose(file);

%freq axis: 10Hz to 100MHz com 10 pontos por década
%f = logspace(1, 8, 10); afinal não vou fazer assim, porque implica contas simbólicas

RE1 = 100; %de volta ao valor inicial
RL = 8;
Ci = 1e-3;
CB = 1e-3;
Co = 1e-6;
a = 1;

for i = 1:0.1:8.1 %ou seja, 10 pontos por década
  f = power(10, i);
  omega = 2 * pi * f;
  ZCi = 1 / (j * omega * Ci);
  ZCB = 1 / (j * omega * CB);
  ZCo = 1 / (j * omega * Co);
  Zin = RS + ZCi;
  ZE1 = 1 / (1 / RE1 + 1/ZCB);
  ZE2 = 1 / (1 / RE2 + 1 / (RL + ZCo)); %RE2||(RL + ZCo)
  Vin = 0.01 * exp(j * pi / 2); %seno tem fase de pi/2
  
  
  A = [1, 0, 0, 0, 0;
      1/Zin, -1/Zin-1/RB-1/rpi1, 1/rpi1, 0, 0;
      0, gm1+1/rpi1, -gm1-1/rpi1-1/ZE1-1/ro1, 1/ro1, 0;
      0, gm1, -gm1-1/ro1, 1/RC1+gpi2+1/ro1, -gpi2;
      0, 0, 0, gpi2+gm2, -gpi2-gm2-go2-1/ZE2];
  
  B = [Vin; 0; 0; 0; 0];
  
  X = A\B;
  
  Voutcomp = (RL / (RL + ZCo)) * X(5); %divisor de tensão
  Vout = abs(Voutcomp);
  gain(a) = abs(Voutcomp / (Vin - IB1*RS)); %Vout/Vin2
  gaindB(a) = 20 * log10(gain(a));
  
  a = a + 1;
endfor

f = 1:0.1:8.1; %início, fim e 70 pontos pelo meio
hf = figure();
plot(f, gaindB);
legend("Gain");
xlabel("log(f)[Hz]");
ylabel("Gain[dB]");

print (hf, "gainteo.eps", "-depsc");