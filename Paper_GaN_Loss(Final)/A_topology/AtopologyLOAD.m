%% A TOPOLOGY 
clear all
close all
load('A_loadvariated.mat')

%%
P_IGBT=zeros();
P_diode=zeros();
Pper=zeros();
PLA=zeros();
E=zeros();
%Id=Id;

fsw=10050;
%% 

for (satir=1:10)

L=length(Id(satir,:));
Ts=1/(20*fsw);

Esw=0;
Eoff=0;
Eon=0;
Edoff=0;
Econd=0;
Edcond=0;
Edsw=0;

swon=0;
swoff=0;
swd=0;
cond=0;
dcond=0;

for n=1:L
    if (Id(satir,n)>0  && n>1 && n<L) %meaning that IGBT is on operation
    
        if (Id(satir,n-1)==0) %meaning that there is an on switching, the  swtiching period could take long
            Eon=IGBT_sw(abs(Id(satir,n)),'on')*1e-3; %J
            Esw = Esw + Eon;
            swon=swon+1;
  
        elseif ((Id(satir,n+1)==0) ) %meaning that there is an off switching, a decline in the current
            Eoff=IGBT_sw(abs(Id(satir,n)),'off')*1e-3; %j
            Esw = Esw + Eoff;
            swoff=swoff+1;
            
        else
            Vds=IGBT_cond(Id(satir,n));
            Econd= Econd + Id(satir,n)* Vds*Ts;
            cond=cond+1;
        end
        
        
    elseif  (Id(satir,n)<0 && n<L) %meaning that diode is on operation
        
        if ((Id(satir,n+1)==0)) %meaning that there is an off switching, a decline in the current
            Edoff=diode_sw(Id(satir,n))*1e-3;
            Edsw = Edsw + Edoff;
            swd=swd+1;
            
        else
            Vds=diode_cond(Id(satir,n));
            Edcond= Edcond + abs(Id(satir,n))* Vds*Ts;
            dcond=dcond+1;
         end
    end
end

% IGBT Loss : Switching+Conduction(steady state)

P_IGBT(satir) = (Esw+Econd)*50;       %Total loss per IGBT

% Diode Loss : Condunction(ss) + Reverse Recovery

P_diode(satir) = (Edsw + Edcond)*50;



%%Total Loss

Pper(satir)=P_IGBT(satir)+P_diode(satir);
PLA(satir)=Pper(satir)*6;
%Eload_a(satir)=load/(PLA(satir)+load)*100;
E(satir,1:4)=[Esw Econd Edsw Edcond];
end
load=[800 1600 2400 3200 4000 4800 5600 6400 7200 8000];
Pout=PLA+load;
Eload_a=load./(Pout)*100;

%% Graphs

%%
% figure;
% freq=(1.050:1:10.050);
% plot(freq, Ptotal);
% xlabel('frequency (kHz)');
% ylabel('Loss (W)');
% title('IGBT loss calculation vs frequency');
% figure;
% bar(E,'stacked');
% legend('IGBT sw', 'IGBT cond', 'Diode sw', 'diode cond');
% 
% 

        
%subpot
figure;
load=(800:800:8000);
subplot(1,2,1);
plot(load, PLA, 'linewidth', 2);
xlabel('Load');
ylabel('Loss (W)');
legend('Total Loss','Location','NorthWest')
title('IGBT 2 level-single Topology Loss');

subplot(1,2,2);
bar(load,E,'stacked');
ylabel('E (joule) per transistor');
xlabel('Load');
legend('IGBT sw', 'IGBT cond', 'Diode sw', 'diode cond','Location','NorthWest');
title('Energy distribution');
%%

cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\ForPlots');
save('Eload_a','Eload_a');

              
 
   
        
        
 
   
        
        
        
            
            
        
            
            
        
        
 




    
    
    
