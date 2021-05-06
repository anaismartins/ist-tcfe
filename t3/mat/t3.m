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

