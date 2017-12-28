clear all
close all

%%

RePower=2e3; %Total power at the output is 2kW
Vac=140;        %The ac voltage is 140 V line to line rms
Vdc=270 ;         % Voltage 
Vgst=1.7; %typical threshold voltage
pf=0.9;
fsw = 80e3;         %Hz - PWM switching frequency for every inverter arm-switch
Vgs_off=0;  
Vgs=6;


Id= RePower/(Vac*sqrt(3)*pf)*sqrt(2);    %A - Peak value of sinusoidal output current,taken wrt to 100kW active power of desired load 
Ie= Id;           %A Icp=Iep
Rd_on=50e-3;  % at the found Ipeak value for rds, 150 Celcius
Rrev_on=Rd_on; % from the Vds-ýd Graph
Esw_on=47.5*1e-6;     %J - IGBT's turn-on switching energy per pulse at Ic (Icp, T=125C) found from curve
Esw_off=7.5*1e-6;    %J - IGBT's turn-off switching energy per pulse at Ic (Icp, T=125C) found from curve


Vconduction=Rd_on*Id  ;        %V - IGBT saturation voltage drop @Icp and T=125C
m_a= 0.85 ;  % - PWM duty factor (Modulation depth)


phase_angle=acos(pf)/pi*180; %degree - phase angle btw. output voltage and current 
  

%% GaN Loss
Pss=Id*Vconduction*((1/8)+(m_a/(3*pi))*pf);                 %Steady-state loss per switching IGBT
Psw=(Esw_on+Esw_off)*fsw*(1/pi);                       %Switching Loss per switching IGBT


% On State Loss when Vgs>0 
    Prev1=Id^2*Rd_on*((1/8)-(m_a/(3*pi))*pf);

%off state loss when Vgs <0 extra loss
   Prev2=(Id^2*Rrev_on + Id*(Vgst+abs(Vgs_off)))*(0.01);


%Total Loss
Ptot=(Pss+Psw+Prev1+Prev2)*6;