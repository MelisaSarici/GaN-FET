clear all
close all

%%

RePower=8e3; %Total power at the output is 2kW
Vdc=540*m ;         % Voltage 
Vac=Vdc*m_a*0.612;        %The ac voltage is 140 V line to line rms
Vgst=1.7; %typical threshold voltage
pf=0.9;
fsw = 20e3;         %Hz - PWM switching frequency for every inverter arm-switch
Vgs_off=0;  
Vgs=6;


Id= RePower/(Vac*sqrt(3)*pf)*sqrt(2);    %A - Peak value of sinusoidal output current,taken wrt to 100kW active power of desired load 
Ie= Id;           %A Icp=Iep
Rd_on=50e-3;  % at the found Ipeak value for rds, 150 Celcius
Rrev_on=Rd_on; % from the Vds-ýd Graph
Esw_on=47.5*1e-6;     %J - IGBT's turn-on switching energy per pulse at Ic (Icp, T=125C) found from curve
Esw_off=7.5*1e-6;    %J - IGBT's turn-off switching energy per pulse at Ic (Icp, T=125C) found from curve
Eoss = 7e-6;

Vconduction=Rd_on*Id  ;        %V - IGBT saturation voltage drop @Icp and T=125C
m_a= 0.85 ;  % - PWM duty factor (Modulation depth)


phase_angle=acos(pf)/pi*180; %degree - phase angle btw. output voltage and current 
k_dead=0.01; % the time ratio of the dead time to the whole cycle

%% GaN Loss
Pss1=Id*Vconduction*((1/8)+(m_a/(3*pi))*pf);           %Steady-state loss per switching GanN
Psw1=(Esw_on+Esw_off)*fsw*(1/pi);                       %Switching Loss per switching GaN


% On State Reverse -diode like- Loss if Vgs>0 (GaN is on but the current flows in the other direction due to other switched GaN)
%   Prevon=Id*Vconduction*((1/8)-(m_a/(3*pi))*pf);

% GaN turns Off state Vgs <0, extra loss occurs due to - applied Vgs, acts
% as a diode with Vth+Vgs on voltage
    Prevoff1=(Id*Rrev_on + (Vgst+abs(Vgs_off)))*Id*((1/8)-(m_a/(3*pi)))*pf;

% Oss loss
Poss1=(Eoss)*fsw*(1/pi);

%Total Loss
Ptot1=(Pss1+Psw1+Poss1+Prevoff1);
Ptot=Ptot1*6;
efficiency = RePower/(RePower+Ptot);

%% GRAPHS

P=[Pss1 Psw1 Prevoff1 Poss1];
pie(P );
legend( {'conduction','switcing','dead time','capacitor loss'});
title('Pie chart of GaN loss with %9805 efficiency');

