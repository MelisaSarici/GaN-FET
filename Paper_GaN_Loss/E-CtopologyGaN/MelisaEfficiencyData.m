cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\mlv_inv\topologies to be evaluated\compact versions\compact2level\seriesparallel')
open_system('twolevel_seriesparallel.slx');
clear
N = 2^20;
%% values of the signals
ma = 0.9;
ref_frequency = 2*pi*50; %radians per sec
sw_frequency = 1050; %Hz
Sampling_time = 1/(15*sw_frequency); %sampling frequency of the model
Fs = 0.5/Sampling_time;  %Sampling Frequency for the spectrum analysis  %5e-6 goes up to 50kHz band
stop_time = 0.0201; %duration of the model
%% Load&Source settings
Load_Real_Power = 8000; %W
Load_Power_Factor = 0.9; 
Load_Apparent_Power = Load_Real_Power/Load_Power_Factor; %VA
Load_Reactive_Power = Load_Apparent_Power*sin(acos(Load_Power_Factor)); %VAr
DC_Voltage_Source = 540; %Volts
Load_Nominal_Freq = ref_frequency/(2*pi); %Hz

n = 2; %number of interleaved inverters
m = 2; %number of series DCLINKs (do not change this)

interleaving_angle = 360/(n);
intangle1 = 0;
intangle2 = interleaving_angle;
intangle3 = 0;
intangle4 = interleaving_angle;



Vll_rms = ma*DC_Voltage_Source*0.612/m;
Vln_rms = Vll_rms/sqrt(3);
Iline = Load_Apparent_Power/(Vll_rms*sqrt(3));
% Zbase = Vll_rms^2/Load_Apparent_Power;
% Xs = 0.5*Zbase;
theta = acos((Load_Real_Power/3)/(Vln_rms*Iline));
%% finding by force
% for delta = 0:0.000001*pi:2*pi
%     theformula = sin(delta)*Vln_rms/(cos(theta-delta)*Xs*Iline);
%     acilar(la) = theformula;
%     if (0.9999<theformula)&&(theformula<1.0001)
%         yukacisi = delta;
%         break
%     end
%     la = la+1;
% end
% %  delta = 0:0.000001*pi:2*pi;
% Load_Angle = yukacisi
% Ef = Vln_rms*cos(Load_Angle)-cos(pi/2-theta+Load_Angle)*Xs*Iline;
%%
% Zload = m*n*Vll_rms/(Iline*sqrt(3));
% Rload = Zload*Load_Power_Factor;
% Xload = Zload*sin(acos(Load_Power_Factor));
% Lload = Xload/ref_frequency;

%% equating the angle of the load angle and the powerfactor angle
Load_Angle = acos(Load_Power_Factor);
Ef = Vln_rms*cos(Load_Angle);
Xs = sqrt((Vln_rms^2-Ef^2)/Iline^2);
Ls = n*m*Xs/ref_frequency; % n: number of interleaved inverters  

DCLINK_Cap = 100e-6; %Farads

Rin = 1; %ohm
Vin = DC_Voltage_Source + Rin*(Load_Real_Power/DC_Voltage_Source);




%% commenting out the inverters depending on the 'n' value
if n == 2
    set_param('twolevel_seriesparallel/Inverter1','commented','off')
    set_param('twolevel_seriesparallel/Inverter2','commented','off')
    set_param('twolevel_seriesparallel/Inverter3','commented','off')
    set_param('twolevel_seriesparallel/Inverter4','commented','off')
    set_param('twolevel_seriesparallel/Inverter 1 Load','commented','off')
    set_param('twolevel_seriesparallel/Inverter 2 Load','commented','off')
    set_param('twolevel_seriesparallel/Inverter 3 Load','commented','off')
    set_param('twolevel_seriesparallel/Inverter 4 Load','commented','off')

end
if n == 1
    set_param('twolevel_seriesparallel/Inverter1','commented','off')
    set_param('twolevel_seriesparallel/Inverter2','commented','on')
    set_param('twolevel_seriesparallel/Inverter3','commented','off')
    set_param('twolevel_seriesparallel/Inverter4','commented','on')
    set_param('twolevel_seriesparallel/Inverter 1 Load','commented','off')
    set_param('twolevel_seriesparallel/Inverter 2 Load','commented','on')
    set_param('twolevel_seriesparallel/Inverter 3 Load','commented','off')
    set_param('twolevel_seriesparallel/Inverter 4 Load','commented','on')
end
if n == 0
    set_param('twolevel_seriesparallel/Inverter1','commented','on')
    set_param('twolevel_seriesparallel/Inverter2','commented','on')
    set_param('twolevel_seriesparallel/Inverter3','commented','on')
    set_param('twolevel_seriesparallel/Inverter4','commented','on')
    set_param('twolevel_seriesparallel/Inverter 1 Load','commented','on')
    set_param('twolevel_seriesparallel/Inverter 2 Load','commented','on')
    set_param('twolevel_seriesparallel/Inverter 3 Load','commented','on')
    set_param('twolevel_seriesparallel/Inverter 4 Load','commented','on')
end
    
                

 twolevelseriesparallel_interleaved = sim('twolevel_seriesparallel.slx','SimulationMode','normal','AbsTol','1e-6','SaveState','on','StateSaveName','xout','SaveOutput','on','OutputSaveName','yout','SaveFormat', 'Dataset');
%% Spectrum of DCLINK1_voltage
% Fs = numel(DCLINK_voltage.data);  %Sampling Frequency
DCLINK1_voltage_spectrum = fft(twolevelseriesparallel_interleaved.get('DCLINK1_voltage').data,N*2);
DCLINK1_voltage_spectrum_abs = abs(DCLINK1_voltage_spectrum(2:N/2));
freq = (1:N/2-1)*Fs/N;   

DCLINK1_voltage_spectrum_abs = DCLINK1_voltage_spectrum_abs/max(DCLINK1_voltage_spectrum_abs); % normalization
figure;
semilogy(freq,DCLINK1_voltage_spectrum_abs) % Plot the magnitude of the samples of CTFT of the audio signal
title('Spectrum of DCLINK1 voltage');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
%% Spectrum of DCLINK1_current
% Fs = numel(DCLINK1_current.data);  %Sampling Frequency
DCLINK1_current_spectrum = fft(twolevelseriesparallel_interleaved.get('DCLINK1_current').data,N*2);
DCLINK1_current_spectrum_abs = abs(DCLINK1_current_spectrum(2:N/2));
freq = (1:N/2-1)*Fs/N;   

% DCLINK1_current_spectrum_abs = DCLINK1_current_spectrum_abs/max(DCLINK1_current_spectrum_abs); % normalization
figure;
semilogy(freq,DCLINK1_current_spectrum_abs) % Plot the magnitude of the samples of CTFT of the audio signal
title('Spectrum of DCLINK1 current');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
%% Spectrum of DCLINK2_voltage
% Fs = numel(DCLINK_voltage.data);  %Sampling Frequency
DCLINK1_voltage_spectrum = fft(twolevelseriesparallel_interleaved.get('DCLINK2_voltage').data,N*2);
DCLINK1_voltage_spectrum_abs = abs(DCLINK1_voltage_spectrum(2:N/2));
freq = (1:N/2-1)*Fs/N;   

DCLINK1_voltage_spectrum_abs = DCLINK1_voltage_spectrum_abs/max(DCLINK1_voltage_spectrum_abs); % normalization
figure;
semilogy(freq,DCLINK1_voltage_spectrum_abs) % Plot the magnitude of the samples of CTFT of the audio signal
title('Spectrum of DCLINK2 voltage');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
%% Spectrum of DCLINK2_current
% Fs = numel(DCLINK1_current.data);  %Sampling Frequency
DCLINK1_current_spectrum = fft(twolevelseriesparallel_interleaved.get('DCLINK2_current').data,N*2);
DCLINK1_current_spectrum_abs = abs(DCLINK1_current_spectrum(2:N/2));
freq = (1:N/2-1)*Fs/N;   

DCLINK1_current_spectrum_abs = DCLINK1_current_spectrum_abs/max(DCLINK1_current_spectrum_abs); % normalization
figure;
semilogy(freq,DCLINK1_current_spectrum_abs) % Plot the magnitude of the samples of CTFT of the audio signal
title('Spectrum of DCLINK2 current');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
%% Spectrum of VAB1 only
% Fs = numel(LL_voltages.signals(1).values);  %Sampling Frequency
LL_voltages_spectrum = fft(twolevelseriesparallel_interleaved.get('LL_voltages1').signals(1).values,N*2);
LL_voltages_spectrum_abs = abs(LL_voltages_spectrum(2:N/2));
freq = (1:N/2-1)*Fs/N;   

% LL_voltages_spectrum_abs = LL_voltages_spectrum_abs/max(LL_voltages_spectrum_abs); % normalization
figure;
plot(freq,LL_voltages_spectrum_abs) % Plot the magnitude of the samples of CTFT of the audio signal
title('Spectrum of Vab1');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
%% Spectrum of Ia1 only
% Fs = numel(Phase_currents.signals(1).values);  %Sampling Frequency
Ia_Spectrum = fft(twolevelseriesparallel_interleaved.get('Phase_currents1').signals(1).values,N*2);
Ia_Spectrum_abs = abs(Ia_Spectrum(2:N/2));
freq = (1:N/2-1)*Fs/N;   

Ia_Spectrum_abs =Ia_Spectrum_abs/max(Ia_Spectrum_abs); % normalization
figure;
semilogy(freq,Ia_Spectrum_abs) % Plot the magnitude of the samples of CTFT of the audio signal
title('Spectrum of Ia1');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
%% plotting of THD's
figure
subplot(2,1,1);
plot(twolevelseriesparallel_interleaved.get('THD_Ia1').time, 100*twolevelseriesparallel_interleaved.get('THD_Ia1').data)
title('THD of Ia1');
xlabel('Time(sec)');
ylabel('THD (%)');

% subplot(3,1,2);
% plot(twolevelspwm.get('THD_Van').time, 100*twolevelspwm.get('THD_Van').data)
% title('THD of Van');
% xlabel('Time(sec)');
% ylabel('THD (%)');

subplot(2,1,2);
plot(twolevelseriesparallel_interleaved.get('THD_Vab1').time, 100*twolevelseriesparallel_interleaved.get('THD_Vab1').data)
title('THD of Vab1');
xlabel('Time(sec)');
ylabel('THD (%)');

figure
subplot(2,1,1);
plot(twolevelseriesparallel_interleaved.get('THD_Ia3').time, 100*twolevelseriesparallel_interleaved.get('THD_Ia3').data)
title('THD of Ia3');
xlabel('Time(sec)');
ylabel('THD (%)');

% subplot(3,1,2);
% plot(twolevelspwm.get('THD_Van').time, 100*twolevelspwm.get('THD_Van').data)
% title('THD of Van');
% xlabel('Time(sec)');
% ylabel('THD (%)');

subplot(2,1,2);
plot(twolevelseriesparallel_interleaved.get('THD_Vab3').time, 100*twolevelseriesparallel_interleaved.get('THD_Vab3').data)
title('THD of Vab3');
xlabel('Time(sec)');
ylabel('THD (%)');



timelength = round((numel(twolevelseriesparallel_interleaved.get('DCLINK1_voltage').time))*0.9);
maxvoltage = max(twolevelseriesparallel_interleaved.get('DCLINK1_voltage').data(timelength:end));
minvoltage = min(twolevelseriesparallel_interleaved.get('DCLINK1_voltage').data(timelength:end));
twolevelseriesparallel_DC1Ripple = maxvoltage - minvoltage;
maxvoltage = max(twolevelseriesparallel_interleaved.get('DCLINK2_voltage').data(timelength:end));
minvoltage = min(twolevelseriesparallel_interleaved.get('DCLINK2_voltage').data(timelength:end));
twolevelseriesparallel_DC2Ripple = maxvoltage - minvoltage;

fprintf('Vc1rms value is: %d \n',mean(twolevelseriesparallel_interleaved.get('Vc1rms').signals(1).values(timelength:end)));
fprintf('Ic1rms value is: %d \n',mean(twolevelseriesparallel_interleaved.get('Ic1rms').signals(1).values(timelength:end)));
fprintf('Vc2rms value is: %d \n',mean(twolevelseriesparallel_interleaved.get('Vc2rms').signals(1).values(timelength:end)));
fprintf('Ic2rms value is: %d \n',mean(twolevelseriesparallel_interleaved.get('Ic2rms').signals(1).values(timelength:end)));


close all
%% 2 series
count = 1;
n = 2;
interleaving_angle = 360/(n);
intangle1 = 0;
intangle2 = interleaving_angle;
intangle3 = 0;
intangle4 = interleaving_angle;
Ls = n*m*Xs/ref_frequency; % n: number of interleaved inverters  


%% commenting out the inverters depending on the 'n' value
if n == 2
    set_param('twolevel_seriesparallel/Inverter1','commented','off')
    set_param('twolevel_seriesparallel/Inverter2','commented','off')
    set_param('twolevel_seriesparallel/Inverter3','commented','off')
    set_param('twolevel_seriesparallel/Inverter4','commented','off')
    set_param('twolevel_seriesparallel/Inverter 1 Load','commented','off')
    set_param('twolevel_seriesparallel/Inverter 2 Load','commented','off')
    set_param('twolevel_seriesparallel/Inverter 3 Load','commented','off')
    set_param('twolevel_seriesparallel/Inverter 4 Load','commented','off')

end
if n == 1
    set_param('twolevel_seriesparallel/Inverter1','commented','off')
    set_param('twolevel_seriesparallel/Inverter2','commented','on')
    set_param('twolevel_seriesparallel/Inverter3','commented','off')
    set_param('twolevel_seriesparallel/Inverter4','commented','on')
    set_param('twolevel_seriesparallel/Inverter 1 Load','commented','off')
    set_param('twolevel_seriesparallel/Inverter 2 Load','commented','on')
    set_param('twolevel_seriesparallel/Inverter 3 Load','commented','off')
    set_param('twolevel_seriesparallel/Inverter 4 Load','commented','on')
end
if n == 0
    set_param('twolevel_seriesparallel/Inverter1','commented','on')
    set_param('twolevel_seriesparallel/Inverter2','commented','on')
    set_param('twolevel_seriesparallel/Inverter3','commented','on')
    set_param('twolevel_seriesparallel/Inverter4','commented','on')
    set_param('twolevel_seriesparallel/Inverter 1 Load','commented','on')
    set_param('twolevel_seriesparallel/Inverter 2 Load','commented','on')
    set_param('twolevel_seriesparallel/Inverter 3 Load','commented','on')
    set_param('twolevel_seriesparallel/Inverter 4 Load','commented','on')
end
    
   
for sw_frequency = 1050:5000:100050
    capacitorsabiti = 200e-6*14000;
    DCLINK_Cap = 1.3*capacitorsabiti/sw_frequency;
    Capacitor_values(count) = DCLINK_Cap;
    Sampling_time = 1/(20*sw_frequency); %sampling frequency of the model
    Fs = 0.5/Sampling_time;  %Sampling Frequency for the spectrum analysis  %5e-6 goes up to 50kHz band
    twolevelseriesparallel_interleaved = sim('twolevel_seriesparallel.slx','SimulationMode','normal','AbsTol','1e-6','SaveState','on','StateSaveName','xout','SaveOutput','on','OutputSaveName','yout','SaveFormat', 'Dataset');
    
    numberelement = numel(twolevelseriesparallel_interleaved.get('Ids1').data);
    Ids1(count,1:numberelement) = twolevelseriesparallel_interleaved.get('Ids1').data;
   % Ids1_Inv1_time(count,1:numberelement) = twolevelseriesparallel_interleaved.get('Ids1_1').time;
    
   
    count = count + 1;
    
end
save('dataC','Ids1');
    

% %% 2 series 2 parallel
% 
% count = 1;
% n = 2;
% 
% interleaving_angle = 360/(n);
% intangle1 = 0;
% intangle2 = interleaving_angle;
% intangle3 = 0;
% intangle4 = interleaving_angle;
% Ls = n*m*Xs/ref_frequency; % n: number of interleaved inverters  
% 
% 
%     %% commenting out the inverters depending on the 'n' value
% if n == 2
%     set_param('twolevel_seriesparallel/Inverter1','commented','off')
%     set_param('twolevel_seriesparallel/Inverter2','commented','off')
%     set_param('twolevel_seriesparallel/Inverter3','commented','off')
%     set_param('twolevel_seriesparallel/Inverter4','commented','off')
%     set_param('twolevel_seriesparallel/Inverter 1 Load','commented','off')
%     set_param('twolevel_seriesparallel/Inverter 2 Load','commented','off')
%     set_param('twolevel_seriesparallel/Inverter 3 Load','commented','off')
%     set_param('twolevel_seriesparallel/Inverter 4 Load','commented','off')
% 
% end
% if n == 1
%     set_param('twolevel_seriesparallel/Inverter1','commented','off')
%     set_param('twolevel_seriesparallel/Inverter2','commented','on')
%     set_param('twolevel_seriesparallel/Inverter3','commented','off')
%     set_param('twolevel_seriesparallel/Inverter4','commented','on')
%     set_param('twolevel_seriesparallel/Inverter 1 Load','commented','off')
%     set_param('twolevel_seriesparallel/Inverter 2 Load','commented','on')
%     set_param('twolevel_seriesparallel/Inverter 3 Load','commented','off')
%     set_param('twolevel_seriesparallel/Inverter 4 Load','commented','on')
% end
% if n == 0
%     set_param('twolevel_seriesparallel/Inverter1','commented','on')
%     set_param('twolevel_seriesparallel/Inverter2','commented','on')
%     set_param('twolevel_seriesparallel/Inverter3','commented','on')
%     set_param('twolevel_seriesparallel/Inverter4','commented','on')
%     set_param('twolevel_seriesparallel/Inverter 1 Load','commented','on')
%     set_param('twolevel_seriesparallel/Inverter 2 Load','commented','on')
%     set_param('twolevel_seriesparallel/Inverter 3 Load','commented','on')
%     set_param('twolevel_seriesparallel/Inverter 4 Load','commented','on')
% end
%     
%    
% for sw_frequency = 1050:4000:100050
%     capacitorsabiti = 200e-6*14000;
%     DCLINK_Cap = 0.9*capacitorsabiti/sw_frequency;
%     Capacitor_values(count) = DCLINK_Cap;
%     Sampling_time = 1/(20*sw_frequency); %sampling frequency of the model
%     Fs = 0.5/Sampling_time;  %Sampling Frequency for the spectrum analysis  %5e-6 goes up to 50kHz band
%     
%     twolevelseriesparallel_interleaved = sim('twolevel_seriesparallel.slx','SimulationMode','normal','AbsTol','1e-6','SaveState','on','StateSaveName','xout','SaveOutput','on','OutputSaveName','yout','SaveFormat', 'Dataset');
%    
%    
%     count = count+1;
%     
%     
%     
%     
%     freq(count,1:numel((1:N/2-1)*Fs/N)) = (1:N/2-1)*Fs/N;   
%     fprintf('swf = %d , ripplepercent = %d , Capacitor size = %d',sw_frequency,ripplepercent,DCLINK_Cap);
%     fprintf('\n') 
%     
% end
% save('topologyB_n22','Capacitor_values','THDV_2levelseries_IGBTVab1','THDV_2levelseries_IGBTIa1'...
%     ,'ripple1vector','ripple1percent','ripple2vector','ripple2percent','DCLINK_Vc1rms','DCLINK_Vc2rms','DCLINK_Ic1rms','DCLINK_Ic2rms'...
%     ,'DCLINK_cap1_voltage_spectrum_abs','DCLINK_cap1_current_spectrum_abs','DCLINK_cap2_voltage_spectrum_abs'...
%     ,'DCLINK_cap2_current_spectrum_abs','LLab1_voltages_spectrum_abs','LLbc1_voltages_spectrum_abs','LLca1_voltages_spectrum_abs',...
%     'Ia1_Spectrum_abs','Ib1_Spectrum_abs','Ic1_Spectrum_abs','LLab3_voltages_spectrum','LLbc3_voltages_spectrum','LLca3_voltages_spectrum'...
%     ,'Ia3_Spectrum_abs','Ib3_Spectrum_abs','Ic3_Spectrum_abs','LLab2_voltages_spectrum_abs','LLbc2_voltages_spectrum_abs','LLca2_voltages_spectrum_abs',...
%     'Ia2_Spectrum_abs','Ib2_Spectrum_abs','Ic2_Spectrum_abs','LLab4_voltages_spectrum_abs','LLbc4_voltages_spectrum_abs','LLca4_voltages_spectrum_abs',...
%     'Ia4_Spectrum_abs','Ib4_Spectrum_abs','Ic4_Spectrum_abs','freq');
% save('efficiencypart_sp_n2','Ids1_Inv1_data','Ids1_Inv1_time','Ids1_Inv3_data'...
%         ,'Ids1_Inv3_time','Ids2_Inv1_data','Ids2_Inv1_time','Ids2_Inv3_data'...
%         ,'Ids2_Inv3_time','Vds1_Inv1_data','Vds1_Inv1_time'...
%         ,'Vds1_Inv3_data','Vds1_Inv3_time'...
%         ,'Vds2_Inv1_data','Vds2_Inv1_time','Vds2_Inv3_data','Vds2_Inv3_time')
%     
