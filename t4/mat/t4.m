%gain stage

VT = 25e-3;
betaFN = 178.7; %parâmetro do transistor NPN
VAFN = 69.7; %parâmetro do transistor NPN
RE = 100;
RC = 1000;
R1 = 80000;
R2 = 20000;
VBEON = 0.7;
VCC = 12;
Rin = 100;

RB = 1 / (1/R1 + 1/R2); %Resistência equivalente
Veq = R2 / (R1 + R2) * VCC; %slide 7 aula 17
IB1 = (Veq - VBEON)/(RB + (1 + betaFN) * RE); %em zona ativa direta (o estado do transistor), VBE = VBEON
IC1 = betaFN * IB1;
IE1 = (1 + betaFN) * IB1;
VE1 = RE * IE1;
VO1 = VCC - RC * IC1; %que é também a tensão no coletor 1
VCE = VO1 - VE1;


gm1 = IC1 / VT;
rpi1 = betaFN / gm1;
ro1 = VAFN / IC1;

AV1 = RC * (RE - gm1 * rpi1 * ro1) / ((ro1 + RC + RE) * (RB + rpi1 + RE) + gm1 * RE * ro1 * rpi1 - RE^2); %vout/vin

AV1simple = gm1 * RC / (1 + gm1 * RE);

RE = 0;
AV1 = RC * (RE - gm1 * rpi1 * ro1) / ((ro1 + RC + RE) * (RB + rpi1 + RE) + gm1 * RE * ro1 * rpi1 - RE^2);
AV1simple = gm1 * RC / (1 + gm1 * RE);

RE = 100;

ZI1 = ((ro1+RC+RE)*(RB+rpi1+RE)+gm1*RE*ro1*rpi1 - RE^2)/(ro1+RC+RE);

ZX = ro1*((RB+rpi1)*RE/(RB+rpi1+RE))/(1/(1/ro1+1/(rpi1+RB)+1/RE+gm1*rpi1/(rpi1+RB)))

ZO1 = 1/(1/ZX+1/RC)



%ouput stage
betaFP = 227.3; %parâmetro do transistor PNP
VAFNFP = 37.2; %parâmetro do transistor PNP
Rout = 100;
VEBON = 0.7;
VI2 = VO1; %tensão do coletor 1
IE2 = (VCC - VEBON - VI2) / Rout; %(VCC - VE2)/Rout; VEBON = VEB = VE - VB <=> VE = VEB + VB
IC2 = betaFP / (betaFP + 1) * IE2;
VO2 = VCC - Rout * IE2;


gm2 = IC2 / VT;
go2 = IC2  /VAFP;
gpi2 = gm2 / betaFP;
ge2 = 1 / Rout;

AV2 = gm2/(gm2+gpi2+go2+ge2);



ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2);

ZO2 = 1/(gm2+gpi2+go2+ge2);

%freq axis: 10Hz to 100MHz com 10 pontos por década
f = logspace(1, 8, 10);