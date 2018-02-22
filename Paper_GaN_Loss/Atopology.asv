%% A TOPOLOGY (2 Level parallel) parameters

m_a=0.9;
fsw=; %get from workspace of the saved data

%%
%There will be an if statement where both Vgs are low, that is dead time,
%there will be the loss calculation of diodes. Else, normal calculation
%will be performed. Different from the formulas, these will be piecewise
%calculated, so there will be a for loop for one period where the loss
%accumulates.


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

%Must do this part when Vgs1>=Vupperbound || Vgs2>=Vupperbound


%% Id-Vds characteristics

%In this part, knowing the current drawn from the load, we can compute the
%voltage across the IGBT for calculating the conduction losses.

%In this part, I have divided the characteristics of 150C 15 Volts Vgs plot
%into 4 regions:

%Must do this part when Vgs1>=Vupperbound || Vgs2>=Vupperbound


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

%% Vf during dead time 
%In this part the diode's forward voltage is deduced according to its I-V
%graph:

%Must do this part when Vgs1<=Vlowerbound && Vgs2<=Vlowerbound
If=Id;

if (0<If<0.44)
    Vf=(0)/(0.44)*If;
end

if (0.44<=If<2.42)
    Vf=(0.62-0.39)/(2.42-0.44)*If;
end

if (2.42<=If<8.15)
     Vf=(0.87-0.62)/(8.15-2.42)*If;
end

if (8.15<=If<19.8)
     Vf=(1.15-0.87)/(19.8-8.15)*If;
end

if (19.8<=If<50)
     Vf=(1.65-1.15)/(50-19.8)*If;
end



%% Err of IGBTdiode
%In this part the reverse recovery which is the switching loss of the diode
%is found from the datasheet graph:

%Must do this part when Vgs1<=Vlowerbound && Vgs2<=Vlowerbound
If=Id;

if (0<If<3.8)
    Err=(0.83)/(3.8)*If;
end

if (3.8<=If<20)
    Err=(2.1-0.833)/(20-3.8)*If;
end

if (20<=Id<35)
     Err=(3-2.15)/(35-20)*If;
end

if (35<=Id<54.5)
     Err=(3.74-3)/(54.5-35)*If;
end



%% IGBT Loss : Switching+Conduction(steady state)

%Must do this part when Vgs1>=Vupperbound || Vgs2>=Vupperbound


Pss=Id*Vds*((1/8)+(m_a/(3*pi))*pf);   %Steady-state loss per switching IGBT
Psw=(Eon+Eoff)*fsw*(1/pi);              %Switching Loss per switching IGBT
P_IGBT = Pss+Psw;                       %Total loss per IGBT

%% Diode Loss : Condunction(ss) + Reverse Recovery

%Must do this part when Vgs1<=Vlowerbound && Vgs2<=Vlowerbound

Pssdiode=Id*Vf*((1/8)-(m_a/(3*pi))*pf);
Prr=Err*fsw*(1/pi);
P_diode=Pssdiode+Prr;

%% Total Loss

Pper=P_IGBT+P_diode;
Ptotal=Pper+6;


%% 

%for (buraya time arrayin eleman sayýsý gelecek){
% o zamana denk gelen Id bulunacak Id load akýmý bulunacak, Vgs lerin 
%durumuna göre hangi loss bulunuyorsa o bulunacak P per e eklenecek
% bu katsayýlarýn hiçbirine gerek olmayacak sadece I*V 
 




    
    
    
