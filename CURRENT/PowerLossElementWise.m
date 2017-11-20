% %% run before simulink 
% mf=51;
% Ts=1e-5;
% Ts1=Ts/100;
% f=50;
% f_sw=f*mf;
% 
% time=20e-3;
% Vs=7;
% Vt=15;
% ma=Vs/Vt;
% cycle=time*f;
% Ls=1e-9;
% %% Calculation of loss by integrating over the whole time in two different methods
% t=size(tout,1);
% P=zeros();
% P_second_way=0;
% for k=1:t
%     P(k+1)=P(k)+Ids(k)*Vce(k)*(1e-5)*f/cycle; %per cycle loss
%     P_second_way=Power(k)+P_second_way;
% end
%  P_second_way= P_second_way/t; %per cycle loss
% plot(P)
%  %addition of 2001 values, therefore the integral adds 2001 terms. For average sum is divided to 2001
% %first method uses zero hold method, multiplying the sampled value with
% %delta t and then with frequency o get the average voltage, the latter gets
% %the multiplied data from Simulink to workspace and adds the discrete 2001
% %values and then averaging. Both give the same result. 

%% %Loss Calculation Parameters
Esw_on=47.5*1e-6;     %J - IGBT's turn-on switching energy per pulse at peak current (Icp, T=125C)
Esw_off=7.5*1e-6;    %J - IGBT's turn-off switching energy per pulse at peak current (Icp, T=125C)
fsw = 100e3;         %Hz - PWM switching frequency for every inverter arm-switch
Ids= 16;           %A - Peak value of sinusoidal output current
Iep= 300;           %A Icp=Iep
Vds=400  ;        %V - IGBT saturation voltage drop @Icp and T=125C
Rg_on=10;
Rg_off=1;
Lp=10e-9;
L=40e-6;
td_on=4.1e-9;
td_off=8e-9;
tr=3.7e-9;
tf=3.4e-9;
% D= 0.85 ;            % - PWM duty factor (Modulation depth)
% phase_angle=25.841933; %degree - phase angle btw. output voltage and current pf=0.9
% trr= 300*1e-9;        %s - Diode reverse recovery time
% Irr= 200   ;              % - Diode peak recovery current
% Vce_peak=300 ;         % - Peak voltage across the diode at recovery
% 
% %IGBT Loss

% Pss=Ids*Vds*((1/8)+(D/(3*pi))*cos(phase_angle)); %Steady-state loss per switching IGBT
% Psw=(Esw_on+Esw_off)*fsw*(1/pi);                      %Switching Loss per switching IGBT
% PQ = Pss+Psw;                                        %Total loss per IGBT
% 
%  %Diode Loss
% 
% Pdc=Iep*Vec*((1/8)-(D/(3*pi))*cos(phase_angle));%Steady-state loss per diode
% Prr=0.125*Irr*trr*Vce_peak*fsw;                  %Switcihng Loss per diode
% PD=Pdc+Prr;                                      %Total loss per diode

