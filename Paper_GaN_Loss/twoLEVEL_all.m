%% A TOPOLOGY (2 Level parallel) parameters
clear all;
close all;

cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\A_topology');
load('data_corrected');

%%
P_IGBT=zeros();
P_diode=zeros();
Pper=zeros();
PtotalA=zeros();
E=zeros();
Efficiency_A=zeros();


%% 

for (satir=1:25)

L=length(Id(satir,:));
fsw=1050+(satir-1)*1000;
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
            Edcond= Edcond + abs(Id(n))* Vds*Ts;
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
PtotalA(satir)=Pper(satir)*6;
E(satir,1:4)=[Esw Econd Edsw Edcond];
Efficiency_A(satir)=8000/(8000+PtotalA(satir))*100;
end

      
%% B TOPOLOGY 

cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\B');
load('dataB_corrected');
%%

P_GaNB_cond=zeros();
P_GaNB_sw=zeros();
P_CossB=zeros();
Pmodule=zeros();
P_reverse_condB=zeros();
Pper=zeros();
PtotalB=zeros();
E=zeros();
Efficiency_B=zeros();

%% 

for (satir=1:20)

L=length(Id(satir,:));
fsw=1050+(satir-1)*5000;
Ts=1/(20*fsw);


Esw=0;
Eoff=0;
Eon=0;
Eoss=0;
Econd=0;
Erevcond=0;

swon=0;
swoff=0;
swrev=0;
cond=0;
revcond=0;
%%
for n=1:L
    if (Id(satir,n)>0  && n>1 && n<L) %meaning that IGBT is on operation
    
        if (Id(satir,n-1)==0) %meaning that there is an on switching, the  swtiching period could take long
            Eon=GaNB_sw(abs(Id(satir,n)),'on'); %J
            Esw = Esw + Eon;
            swon=swon+1;
            
  
        elseif (Id(satir,n+1)==0) %meaning that there is an off switching, a decline in the current
            Eoff=GaNB_sw(abs(Id(satir,n)),'off'); %j
            Esw = Esw + Eoff;
            swoff=swoff+1;
            
        else
            Vds=GaNB_cond(Id(satir,n));
            Econd= Econd + Id(satir,n)* Vds*Ts;
            cond=cond+1;
        end
        
        
    elseif  (Id(satir,n)<0 && n<L) %meaning that diode is on operation
        
        if (Id(satir,n+1)==0) %meaning that there is an off switching, a decline in the current
           Eoff=GaNB_sw(abs(Id(satir,n)),'off'); %j
           Esw = Esw + Eoff;
           swoff=swoff+1;
            
        elseif (Id(satir,n-1)==0)
            Eon=GaNB_sw(abs(Id(satir,n)),'on'); %J
            Esw = Esw + Eon;
            swon=swon+1;
            
        else
            Vds=GaNB_reverse_cond(Id(satir,n));
            Erevcond= Erevcond + abs(Id(satir,n))* Vds*Ts;
            revcond=revcond+1;
         end
    end
end

Eoss=swon*14.1e-6; %J

P_GaNB_cond(satir) = (Econd)*50;       %Total loss per IGBT
P_reverse_condB(satir) = (Erevcond)*50;
P_GaNB_sw(satir)= Esw*50;
P_CossB(satir)=Eoss*50;

%%Total Loss

Pper(satir)=P_GaNB_cond(satir)+P_reverse_condB(satir)+P_GaNB_sw(satir)+P_CossB(satir);
Pmodule(satir)=Pper(satir)*6;
PtotalB(satir)=Pmodule(satir)*2;
E(satir,1:4)=[Erevcond Esw Econd Eoss];
Efficiency_B(satir)=8000/(8000+PtotalB(satir))*100;
end

        
%% C TOPOLOGY 

cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\E-CtopologyGaN');
load('dataC_corrected');
%%

P_GaN_cond=zeros();
P_GaN_sw=zeros();
P_Coss=zeros();
P_reverse_cond=zeros();
Pper=zeros();
PtotalC=zeros();
Pmodule=zeros();
E=zeros();
Efficiency_C=zeros();


%% 

for (satir=1:20)

L=length(Id(satir,:));
fsw=1050+(satir-1)*5000;
Ts=1/(20*fsw);


Esw=0;
Eoff=0;
Eon=0;
Eoss=0;
Econd=0;
Erevcond=0;

swon=0;
swoff=0;
swrev=0;
cond=0;
revcond=0;
%%
for n=1:L
    if (Id(satir,n)>0  && n>1 && n<L) %meaning that IGBT is on operation
    
        if (Id(satir,n-1)==0) %meaning that there is an on switching, the  swtiching period could take long
            Eon=GaN_sw(abs(Id(satir,n)),'on'); %J
            Esw = Esw + Eon;
            swon=swon+1;
            
  
        elseif (Id(satir,n+1)==0) %meaning that there is an off switching, a decline in the current
            Eoff=GaN_sw(abs(Id(satir,n)),'off'); %j
            Esw = Esw + Eoff;
            swoff=swoff+1;
            
        else
            Vds=GaN_cond(Id(satir,n));
            Econd= Econd + Id(satir,n)* Vds*Ts;
            cond=cond+1;
        end
        
        
    elseif  (Id(satir,n)<0 && n<L) %meaning that diode is on operation
        
        if (Id(satir,n+1)==0) %meaning that there is an off switching, a decline in the current
           Eoff=GaN_sw(abs(Id(satir,n)),'off'); %j
           Esw = Esw + Eoff;
           swoff=swoff+1;
            
        elseif (Id(satir,n-1)==0)
            Eon=GaN_sw(abs(Id(satir,n)),'on'); %J
            Esw = Esw + Eon;
            swon=swon+1;
            
        else
            Vds=GaN_reverse_cond(Id(satir,n));
            Erevcond= Erevcond + abs(Id(satir,n))* Vds*Ts;
            revcond=revcond+1;
         end
    end
end

Eoss=swon*11e-6; %J

P_GaN_cond(satir) = (Econd)*50;       %Total loss per IGBT
P_reverse_cond(satir) = (Erevcond)*50;
P_GaN_sw(satir)= Esw*50;
P_Coss(satir)=Eoss*50;

%%Total Loss

Pper(satir)=P_GaN_cond(satir)+P_reverse_cond(satir)+P_GaN_sw(satir)+P_Coss(satir);
Pmodule(satir)=Pper(satir)*6;
PtotalC(satir)=Pmodule(satir)*4;
E(satir,1:4)=[Erevcond Esw Econd Eoss];
Efficiency_C(satir)=8000/(8000+PtotalC(satir))*100;
end

        
 %% GRAPHS
 
figure;
subplot(1,2,1);
freq=(1.050:1:25.050);
plot(freq, PtotalA, 'linewidth', 2);

hold on;
freq=(1.050:5:100.050);
plot(freq, PtotalB, 'linewidth', 2);
plot(freq, PtotalC, 'linewidth', 2);
hold off;
grid on;
xlabel('frequency (kHz)');
ylabel('Loss (W)');
xlim([0 105]);
legend('IGBT 2 level single','GaN 2 level 2 Series','GaN 2 level 2 Series 2 parallel','NorthWest');
title('Total loss per topology');   


subplot(1,2,2);
freq=(1.050:1:25.050);
plot(freq,Efficiency_A,'linewidth', 2);

hold on;
freq=(1.050:5:100.050);
plot(freq,Efficiency_B,'linewidth', 2);
plot(freq,Efficiency_C,'linewidth', 2);
hold off;
grid on;
xlabel('frequency (kHz)');
ylabel('Efficiency (%)');
xlim([0 105]);
legend('IGBT 2 level single','GaN 2 level 2 Series','GaN 2 level 2 Series 2 parallel','NorthWest');
title('Per cent efficiency per topology');


        