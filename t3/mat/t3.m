close all
clear all

pkg load symbolic

format long

Re = 700e3; %Ohm R envelope
C = 485e-6; %uFarad
Rr = 300e3; % Ohm R regulator

n = 0.153;
nd = 20.; % numero de diodos

t = 0:1e-5:200e-3;

f = 50; %Hz
w = 2 * pi * f; %rad.s⁻¹
T = 1/f;

Vin = 230 * cos(w * t); %V

V3 = n * Vin;

Von = 12./nd; %vout/nº de díodos

V7 = abs(V3); %ACHO EU (o burro do mike)

toff = 1/w * atan(1/(w*Re*C));
%para t>toff Vcondensador=A*cos(w*toff)*exp(^-((t-toff)/(R*C)))

eta = 1;
V_T = 25e-3; %mV
I_S = 1e-14; %...A
Vd = 230; %V ACHO EU VEJAM AQUI

rd = (nd * eta * V_T) / (I_S * exp(Vd / (nd * eta * Vd)));

%envelope
%time axis: 0 to 20ms with 1us steps
A = 1; % acho eu
% para t off
v0 = A * cos(w*toff)* exp(-(t-toff)/(Re*C)); % usa-se Re aqui ou uma soma?
v0f = figure();


plot(t,v0)
hold on

axis([0, 20e-3, 0, 10]);
xlabel("t[s]");
ylabel("v0[V]");
print (v0f, "mat-envelope.eps", "-depsc");


Vripple = A * (1 - exp(-T/(Re*C))); % é com o R do envelope?