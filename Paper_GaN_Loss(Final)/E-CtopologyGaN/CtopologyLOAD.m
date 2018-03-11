%% C TOPOLOGY
clear all
close all
load('C_loadvariated.mat')



P_GaN_cond=zeros();
P_GaN_sw=zeros();
P_Coss=zeros();
P_reverse_cond=zeros();
Pper=zeros();
PLC=zeros();
Pmodule=zeros();
E=zeros();
fsw=51050;
Eload_c=zeros();

%% 

for (satir=1:10)

L=length(Id(satir,:));
Ts=1/(20*fsw);
load=800*satir;

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
PLC(satir)=Pmodule(satir)*4;
Eload_c(satir)=load/(PLC(satir)+load)*100;

E(satir,1:4)=[Esw  Econd Eoss Erevcond ];
end

%% Graphs
% figure;
% freq=(1.050:5:100.050);
% plot(freq, Ptotal, 'linewidth', 2);
% hold on;
% plot(freq,Pmodule,'linewidth', 2);
% xlabel('frequency (kHz)');
% ylabel('Loss (W)');
% legend('Total Loss','Module Loss')
% title('GaN 2 Series- 2 Parallel Topology Loss');
% figure;
% bar(E,'stacked');
% legend('GaN revcond', 'Switch', 'Conduction', 'Coss');
% title('Loss distribution');

% Subplot
 figure;
load=(800:800:8000);
subplot(1,2,1);
plot(load, PLC, 'linewidth', 2);
xlabel('Load');
ylabel('Loss (W)');
legend('Total Loss','Module Loss','Location','NorthWest')
title('GaN 2level/2 Series- 2 Parallel Topology Loss');
hold off;

subplot(1,2,2);
bar(load,E,'stacked');
ylabel('E (joule) per transistor');
xlabel('Load');
legend('Total Loss','Module Loss','Location','NorthWest')
title('GaN 2level/2 Series- 2 Parallel Topology Loss');
hold off;
      
 %%

cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\ForPlots');
save('Eload_c','Eload_c');

        
        
   
    
   
        
        
        
            
            
        
            
            
        
        
 




    
    
    
