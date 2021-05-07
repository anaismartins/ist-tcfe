close all
clear all

pkg load symbolic

format long

R = 500; %Ohm
C = 1e-6; %uFarad

n = 0.09;

t = 0:1e-5:200e-3;

f = 50; %Hz
w = 2 * pi * f; %rad.s⁻¹

Vin = 230 * cos(w * t); %V

V3 = n * Vin;

Von = 12./20.; %vout/nº de díodos

V7 = abs(V3); %ACHO EU (o burro do mike)

toff = 1/w * atan(1/(w*R*C)); %para t>toff Vcondensador=A*cos(w*toff)*exp(^-((t-toff)/(R*C)))

eta = 1;
V_T = 25e-3; %mV
I_S = 1e-14; %...A

rd = (20 * eta * V_T) / (I_S * exp(Vd / (20 * eta * Vd));

