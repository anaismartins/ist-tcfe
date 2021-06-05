R1 = 1000; %Ohm
R2 = 10000; %Ohm
R3 = 1000; %Ohm
R4 = 1000; %Ohm
RL = 8; %Ohm

Cin1 = 1e-6; %F
Cin2 = 1e-6; %F
Cin3 = 1e-6; %F

f = 1000; %Hz

Z1 = R1 + 1/(j * omega * Cin1);
Z2 = R2 + 1/(j * omega * Cin2);
Z3 = R3 + 1/(j * omega * Cin3);

Ztemp = 1/(1/Z1 + 1/Z2); %paralelo de Z1 com Z2
Zeq = 1/(1/Ztemp + 1/Z3); %impedância ao nível de inv_in

Vin = 0.01 * exp(j * pi / 2); %seno tem fase de pi/2

gaincomp = R2/Zeq; %slide 2 aula 23
gain = real(gaincomp);

Zi = Zeq; %slide 2 aula 23
Zo = 0; %estranho :/

