close all
clear all

pkg load symbolic

format long

Re = 700e3; %Ohm R envelope
C = 485e-6; %uFarad
Rr = 300e3; % Ohm R regulator

n = 0.153;
nd = 20.; % numero de diodos

t = 5:1e-5:5.2; %para não começar no 0

f = 50; %Hz
w = 2 * pi * f; %rad.s⁻¹
T = 1/f;

Vin = 230 * cos(w * t); %V

Vs = n * Vin;

A = 230/n;

Von = 12./nd; %vout/nº de díodos
vlim = nd * Von;

V7 = abs(Vs); %ACHO EU (o burro do mike)

toff = 1/(w) * atan(1/(w*Re*C));
%para t>toff Vcondensador=A*cos(w*toff)*exp(^(-(t-toff)/(R*C)))

eta = 1;
V_T = 25e-3; %mV
I_S = 1e-14; %...A
Vd = 230; %V ACHO EU VEJAM AQUI

rd = (nd * eta * V_T) / (I_S * exp(Vd / (nd * eta * Vd)));

%envelope
%time axis: 5000ms to 5200ms with 1us steps

% para t > toff
Vexp = A * cos(w*toff) * exp(-(t-toff)/(Re*C)); % usa-se Re aqui ou uma soma?
Vcos = Vs;

printf("toff = %.10f", toff);

%equação para sacar ton
function y = f(x);
  w = 2 * pi * f; %rad.s⁻¹
  %Re = 700e3; %Ohm R envelope
  %C = 485e-6; %uFarad
  %toff = 1/w * atan(1/(w*Re*C));
  y = cos(w*x) - cos(w*toff)*exp(-(x-toff)/(Re*C));
endfunction

x0 = 0;
%ton = fsolve("f", x0);

i = 0;
%while(i < 10)
%  if(t > ((249+i)*toff) && t < ((249+i)*ton))
%    vout = Vcos;
%  end
%  
% if(t < ((249+i)*toff) && t > ((249+i)*ton))
%   vout = Vexp;
% end
%  
%  i = i + 1;
%end

vouthr= zeros(1, length(t));
vout = zeros(1, length(t)); %alocação dos vetores

for dt = 1:length(t)
  if(Vs(dt) >= nd*Von)
    vouthr(dt) = Vs(dt) - 2*Von;
  elseif (Vs(dt) <= -2*Von)
    vouthr(dt) = -Vs(dt) - 2*Von;
  else
    vouthr(dt) = 0;
  endif
endfor

i = 0;
for dt = 1:length(t)
  if t(dt) < (249+i)*toff
    vout(dt) = Vs(dt);
  elseif Vexp(dt) > vouthr(dt)
    vout(dt) = Vexp(dt);
  else 
    vout(dt) = Vs(dt);
  endif
  
  i = i + 1;
endfor

plot(t, vout);
voutf = figure();
hold on;

xlim([5, 5.2]);
ylim([11.5, 12.5]);
xlabel("t[s]");
ylabel("vout[V]");
print (voutf, "mat-envelope.eps", "-depsc");


%Vripple = A * (1 - exp(-T/(2*Re*C))); % é com o R do envelope? acho que isto não é preciso

