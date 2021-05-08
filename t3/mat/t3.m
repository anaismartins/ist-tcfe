close all
clear all

pkg load symbolic

format long

Re = 700e3; %Ohm R envelope
C = 485e-6; %uFarad
Rr = 300e3; % Ohm R regulator

n = 0.153;
nd = 20.; % numero de diodos

t = 0:1e-5:0.2; %para não começar no 0

f = 50; %Hz
w = 2 * pi * f; %rad.s⁻¹
T = 1/f;

Vin = 230 * cos(w * t); %V

Vs = n * Vin;

A = 230*n;

Von = 12./nd; %vout/nº de díodos
vlim = nd * Von;

V7 = abs(Vs); %ACHO EU (o burro do mike)

toff = (1/w) * atan(1/(w*Re*C));
%para t>toff; Vcondensador=A*cos(w*toff)*exp(^(-(t-toff)/(R*C)))

%envelope
%time axis: 5000ms to 5200ms with 1us steps

%printf("toff = %.10f", toff);

%equação para sacar ton
%function y = f(x);
%  w = 2 * pi * f; %rad.s⁻¹
  %Re = 700e3; %Ohm R envelope
  %C = 485e-6; %uFarad
  %toff = 1/w * atan(1/(w*Re*C));
%  y = cos(w*x) - cos(w*toff)*exp(-(x-toff)/(Re*C));
%endfunction

%x0 = 0;
%ton = fsolve("f", x0);

vouthr = zeros(1, length(t));
vout = zeros(1, length(t));
vout1 = zeros(1, length(t)); %alocação dos vetores

%toff+5+floor((i*1e-5)/T)*T
%for i = 1:length(t)
%  Vexp(i) = (A * cos(w*(5+toff)) - 2 * Von) * exp(-((5+i*1e-5)-(5+toff))/(Re*C));
%endfor

%rectifier

for i = 1:length(t)
  if(Vs(i) >= 2*Von)
    vouthr(i) = Vs(i) - 2*Von;
  elseif (Vs(i) <= -2*Von)
    vouthr(i) = -Vs(i) - 2*Von;
  else
    vouthr(i) = 0;
  endif
endfor

figure
plot(t, Vs, "r-;vS;")
hold on;
plot(t, vouthr, "c-;Rectified;")
xlabel ("t[s]")
ylabel ("V[V]")
print ("mat-bridge.eps", "-depsc");

%for i = 1:length(t)
%  if t(i) < toff
%    vout(i) = vouthr(i);
%  elseif Vexp(i) > vouthr(i)
%    vout(i) = 20;
%  else 
%    vout(i) = vouthr(i);
%  endif
%endfor

for i = 1:length(t)
  t(i) = i * 1e-5;
  if (t(i) > toff && (A * abs(cos(w*toff)) - 2 * Von) * exp(-(t(i)-toff)/(Re*C)) > vouthr(i))
    vout1(i) = (A * abs(cos(w*toff)) - 2 * Von) * exp(-(t(i)-toff)/(Re*C));
  else
   vout1(i) = 0.;
  endif
  
  if(t(i) > toff+T && (A * cos(w*toff) - 2 * Von) * exp(-(t(i)-toff)/(Re*C)) < vouthr(i))
    toff = toff + T
  endif
  
  vout(i) = vouthr(i);
  if(vout1(i) > vouthr(i))
    vout(i) = vout1(i);
  endif
endfor

syms ws real
syms Res real
syms Cs real
syms Vons real
syms toffs real
syms As real
syms tons real

f_toff = As*Cs*ws*sin(ws*toffs)*abs(cos(ws*toffs))/cos(ws*toffs) - As*abs(cos(ws*toffs))/Res +(2*Vons)/Res;

f_subs = subs(f_toff, [ws,Res, Cs, Vons,As], [w, Re, C, Von, A]);

[result] = solve(f_subs == 0, toffs);

toff = double(result(2));

f_ton = As*abs(cos(ws*toffs))*exp((-tons+toffs)/(Res*Cs))- As*abs(cos(ws*tons));

f_subs = subs(f_ton, [ws,Res, Cs, toffs,As], [w, Re, C, toff, A]);

niter = 10000;
iter = 0;
tol = 1e-5;
x0 = 0.05;
syms der %derivative
der = diff(f_subs);

while ((abs(subs(f_subs, x0)) > tol) & (iter < niter)) 
  x0 = double(x0 - subs(f_subs, x0) / subs(der, x0)); %x_n+1 = x_n - f(x_n)/f'(x_n)
  iter = iter + 1;
end

ton = x0;

file = fopen("toff.tex", "w");


fprintf(file, "toff & %.4e\\\\\\hline ", toff);

fflush(file);
fclose(file);

file = fopen("ton.tex", "w");


fprintf(file, "ton & %.4e\\\\\\hline ", ton);

fflush(file);
fclose(file);

%envelope detector

%for i = 1:length(t)
%  if (t(i) > ton && toff < ton)
%    toff = toff + T/2;
%  endif
%  if (t(i) > toff && ton < toff)
%    ton = ton + T/2;
%  endif
%  if (t(i) >= ton)
%    vout(i) = abs(A * cos(w * t(i))) - 2*Von;
%  else
%   vout(i) = (abs(A * cos(w * t(i))) - 2 * Von) * exp(-(t(i)-toff)/(Re*C));
%  endif
%end
  
voutf = figure();
plot(t, vout);
hold on;

xlim([0, 0.2])
xlabel("t[s]");
ylabel("vout[V]");
print (voutf, "mat-envelope.eps", "-depsc");

file = fopen("vout.tex", "w");

fprintf(file, "vout & %.4e\\\\\\hline ", mean(vout));

fflush(file);
fclose(file);

%voltage regulator

eta = 1;
V_T = 25e-3; %mV
I_S = 1e-14; %...A
Vd = 12/nd;

rd = (nd * eta * V_T) / (I_S * exp(Vd / (nd * eta * V_T)));

v0 = zeros(1,length(t));

for i=1:length(t)
  v0(i) =rd/(Re+rd)*vout(i);
endfor

figure;
plot(t, v0);
axis ([0, 0.2])
xlabel ("t[s]")
ylabel ("V[V]")
print ("mat-regulator.eps", "-depsc");


Vripple = A * (1 - exp(-T/(2*Re*C)));

file = fopen("ripple.tex", "w");

fprintf(file, "Vripple & %.4e\\\\\\hline ", mean(Vripple));

fflush(file);
fclose(file);