%% Eon and Eoff regions extracted from the datasheet

%In this part, the datasheet curves were very much linear so, instead of
%pointwise selecting the values, a linear approximation is applied for a
%more generous and sensitive range. note that the worst case 150 C is taken
%for calculations. 
%Note that Rg is kept constant at 15 ohm. If changed, the loss will change
%linearly. Yet, their calculations are not included.

k_on=5.79/40; %from the slope of two points
% alternatively two regions can be estimated for Eon since there was no
% data points between (0,0) and (3.84,1.09)
k_off=3.9/40; % This line was quite linear and could be extrapolated to origin

Id=; %This will be drived from the simulation results

Eon=Id*k_on; %mJ
Eoff=Id*k_off; %mJ

%% Ediode

%This part similar to the previous one is extracted from the datasheets and
%represents the loss for the IGBT diode during reverse conduction

%There will be 3 regions for better calculation:

if (0<Id<=4.3)
    k_diode=0.81/4.3;
end

if (4.3<Id<18)
    k_diode=(1.99-0.81)/(18-4.3);
end

if (18<Id<35)
     k_diode=(3-1.99)/(35-18);
end

Ediode=Id*k_diode;

%% Id-Vds characteristics

%In this part, knowing the current drawn from the load, we can compute the
%voltage across the IGBT for calculating the conduction losses.

%In this part, I have divided the characteristics of 150C 15 Volts Vgs plot
%into 4 regions:

if (0<Id<0.94)
    Vds=0;
end

if (0.94<Id<4.33)
    Vds=(0.795-0.5)/(4.33-0.94)*Id;
end

if (4.33<Id<14.7)
     Vds=(1.23-0.795)/(14.7-4.33)*Id;
end

if (14.7<Id<40)
     Vds=(1.99-1.23)/(40-14.7)*Id;
end



    
    
    
