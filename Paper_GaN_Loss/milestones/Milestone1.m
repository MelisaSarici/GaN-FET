clear all
close all

% %% Wrt to frequency
%%
m_a= 0.9 ;  % - PWM duty factor (Modulation depth)
RePower=8e3; %Total power at the output is 8 kW 3 phase
Vac=540*m_a*0.612;        % line to line rms
Vce_peak=540;         % - Peak voltage across the diode at recovery, specified as Vdc in the milestone
pf=0.9;
fsw = 20e3;         %Hz - PWM switching frequency for every inverter arm-switch


Icp= RePower/(Vac*sqrt(3))*sqrt(2);    %A - Peak value of sinusoidal output current,taken wrt to 100kW active power of desired load 
Iep= Icp;           %A Icp=Iep
Esw_on=3*1e-3;     %J - IGBT's turn-on switching energy per pulse at Ic (Icp, T=150C) found from curve
Esw_off=2*1e-3;    %J - IGBT's turn-off switching energy per pulse at Ic (Icp, T=150C) found from curve


Vce_sat=2.25  ;        %V - IGBT saturation voltage drop @Icp and T=150 C
Vec = 1.2;                     %V - FWD forward voltage drop @Iep
Qr=10e-6; %C 

%IGBT Loss
Pss=Icp*Vce_sat*((1/8)+(m_a/(3*pi))*pf); %Steady-state loss per switching IGBT
Psw=(Esw_on+Esw_off)*fsw*(1/pi);                      %Switching Loss per switching IGBT
P_IGBT = Pss+Psw;                                        %Total loss per IGBT


 %Diode Loss

Pdc=Iep*Vec*((1/8)-(m_a/(3*pi))*pf);             %Steady-state loss per diode
Prr=0.125*Qr*Vce_peak*fsw;                  %Switcihng Loss per diode
P_Diode=Pdc+Prr;         


Ptotal=6*(P_Diode+P_IGBT) %since the data sheet is for half bridge module and there are total 6 IGBTs

%%

% 
%   I=zeros();
%     D=zeros();
%     
% for k=1:10
% 
% fsw=k*2000;
%     
% Pss=Icp*Vce_sat*((1/8)+(m_a/(3*pi))*pf); %Steady-state loss per switching IGBT
% Psw=(Esw_on+Esw_off)*fsw*(1/pi);                      %Switching Loss per switching IGBT
% P_IGBT = Pss+Psw;                                        %Total loss per IGBT
% 
% 
%  %Diode Loss
% 
% Pdc=Iep*Vec*((1/8)-(m_a/(3*pi))*cos(phase_angle));%Steady-state loss per diode
% Prr=0.125*Irr*trr*Vce_peak*fsw;                  %Switcihng Loss per diode
% P_Diode=Pdc+Prr;                                      %Total loss per diode
% 
% I(k)=P_IGBT;
% D(k)=P_Diode;
% end
% 
% subplot(1,3,1)
% plot(I,'linewidth',2);
% hold on
% plot(D,'linewidth',2);
% hold off
% title(' Wrt to frequency')
% xlabel('frequency x 2000 Hz')
% ylabel('Power Loss Watt')
% legend('IGBT', 'Diode')

% %% Wrt to modulation depth
% %Loss Calculation Parameters
% Esw_on=41*1e-3;     %J - IGBT's turn-on switching energy per pulse at peak current (Icp, T=125C)
% Esw_off=32*1e-3;    %J - IGBT's turn-off switching energy per pulse at peak current (Icp, T=125C)
% fsw = 10000;         %Hz - PWM switching frequency for every inverter arm-switch
% Icp= 300;           %A - Peak value of sinusoidal output current
% Iep= 300;           %A Icp=Iep
% Vce_sat=2  ;        %V - IGBT saturation voltage drop @Icp and T=125C
% Vec =1.8 ;          %V - FWD forward voltage drop @Iep
% m_a= 0.85 ;  % - PWM duty factor (Modulation depth)
% pf=0.6;
% phase_angle=acos(pf)/pi*180; %degree - phase angle btw. output voltage and current 
% trr= 300*1e-9;        %s - Diode reverse recovery time
% Irr= 200   ;              % - Diode peak recovery current
% Vce_peak=300 ;         % - Peak voltage across the diode at recovery
%     I=zeros();
%     D=zeros();
% for k=1:10
% m_a=k*0.1;
%     
% Pss=Icp*Vce_sat*((1/8)+(m_a/(3*pi))*pf); %Steady-state loss per switching IGBT
% Psw=(Esw_on+Esw_off)*fsw*(1/pi);                      %Switching Loss per switching IGBT
% P_IGBT = Pss+Psw;                                        %Total loss per IGBT
% 
% 
%  %Diode Loss
% 
% Pdc=Iep*Vec*((1/8)-(m_a/(3*pi))*cos(phase_angle));%Steady-state loss per diode
% Prr=0.125*Irr*trr*Vce_peak*fsw;                  %Switcihng Loss per diode
% P_Diode=Pdc+Prr;                                      %Total loss per diode
% 
% I(k)=P_IGBT;
% D(k)=P_Diode;
% end
% 
% subplot(1,3,2)
% plot(I,'linewidth',2);
% hold on
% plot(D,'linewidth',2);
% hold off
% title(' Wrt to m_a')
% xlabel('m_a x 0.1')
% ylabel('Power Loss Watt')
% legend('IGBT', 'Diode')
% 
% %% Wrt power factor
% 
% %Loss Calculation Parameters
% Esw_on=41*1e-3;     %J - IGBT's turn-on switching energy per pulse at peak current (Icp, T=125C)
% Esw_off=32*1e-3;    %J - IGBT's turn-off switching energy per pulse at peak current (Icp, T=125C)
% fsw = 10000;         %Hz - PWM switching frequency for every inverter arm-switch
% Icp= 300;           %A - Peak value of sinusoidal output current
% Iep= 300;           %A Icp=Iep
% Vce_sat=2  ;        %V - IGBT saturation voltage drop @Icp and T=125C
% Vec =1.8 ;          %V - FWD forward voltage drop @Iep
% m_a= 0.85 ;  % - PWM duty factor (Modulation depth)
% pf=0.6;
% phase_angle=acos(pf)/pi*180; %degree - phase angle btw. output voltage and current 
% trr= 300*1e-9;        %s - Diode reverse recovery time
% Irr= 200   ;              % - Diode peak recovery current
% Vce_peak=300 ;         % - Peak voltage across the diode at recovery
%     I=zeros();
%     D=zeros();
% 
% for k=1:10
% 
%  pf=k*0.1;
% Pss=Icp*Vce_sat*((1/8)+(m_a/(3*pi))*pf); %Steady-state loss per switching IGBT
% Psw=(Esw_on+Esw_off)*fsw*(1/pi);                      %Switching Loss per switching IGBT
% P_IGBT = Pss+Psw;                                        %Total loss per IGBT
% 
% 
%  %Diode Loss
% 
% Pdc=Iep*Vec*((1/8)-(m_a/(3*pi))*cos(phase_angle));%Steady-state loss per diode
% Prr=0.125*Irr*trr*Vce_peak*fsw;                  %Switcihng Loss per diode
% P_Diode=Pdc+Prr;                                      %Total loss per diode
% 
% I(k)=P_IGBT;
% D(k)=P_Diode;
% end
% 
% subplot(1,3,3)
% plot(I,'linewidth',2);
% hold on
% plot(D,'linewidth',2);
% hold off
% title(' Wrt power factor')
% xlabel('pf x 0.1')
% ylabel('Power Loss Watt')
% legend('IGBT', 'Diode')
% 
% 
