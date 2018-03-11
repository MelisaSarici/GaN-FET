%%  TOPOLOGY 
clear all
close all
load('topology_E_loadvariated.mat')

fsw=51050;


%% 
P_diode=zeros();

Pper=zeros();
PLE=zeros();

Id=diode1_current_all;
for (satir=1:10)

L=length(Id(satir,:));

Ts=1/(20*fsw);


Edcond=0;
Ecap=0;
swoff=0;
dcond=0;
Ron=(3.96-0.76)/(45);

for n=1:L
    if (Id(satir,n)>0  && n>1 && n<L) %meaning that IGBT is on operation
    
       if ((Id(satir,n+1)<0) ) %meaning that there is an off switching, a decline in the current
        swoff=swoff+1;
       end

      Edcond= Edcond + abs(Id(satir,n))^2*Ron*Ts+abs(Id(satir,n))*0.76*Ts;
      dcond=dcond+1;
    end
end

Ecap=swoff*3.44*1e-6; %@ 270 C it has this amount of loss uJ

P_diode(satir) = (Ecap + Edcond)*50;

end
       

%%
Id=lowersw_current_all;
P_GaNtop=zeros();
P_GaNtop_sw=zeros();
P_Cossbottom=zeros();
P_reverse_condbottom=zeros();
Pbottom=zeros();

%% 

for (satir=1:10)

L=length(Id(satir,:));
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

P_GaNbottom(satir) = (Econd)*50;       %Total loss per IGBT
P_reverse_condbottom(satir) = (Erevcond)*50;
P_GaNbottom_sw(satir)= Esw*50;
P_Cossbottom(satir)=Eoss*50;

%%Total Loss

Pbottom(satir)=P_GaNbottom(satir)+P_reverse_condbottom(satir)+P_GaNbottom_sw(satir)+P_Cossbottom(satir);
end


%%
Id=uppersw_current_all;

P_GaNtop=zeros();
P_GaNtop_sw=zeros();
P_Cosstop=zeros();
P_reverse_condtop=zeros();
Ptop=zeros();


%% 

for (satir=1:10)

L=length(Id(satir,:));
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

P_GaNtop(satir) = (Econd)*50;       %Total loss per IGBT
P_reverse_condtop(satir) = (Erevcond)*50;
P_GaNtop_sw(satir)= Esw*50;
P_Cosstop(satir)=Eoss*50;
Ptop(satir)=P_GaNtop(satir)+P_reverse_condtop(satir)+P_GaNtop_sw(satir)+P_Cosstop(satir);

end


%% Total Loss
load=[800 1600 2400 3200 4000 4800 5600 6400 7200 8000];
Pper=Ptop+Pbottom+P_diode;
Pmodule=Pper*12;
PLE=Pmodule*2;
Eload_e=load./(PLE+load)*100;




%% GRAPHS

figure;
load=(800:800:8000);
plot(load, PLE, 'linewidth', 2);
grid on;
xlabel('frequency (kHz)');
ylabel('Loss (W)');
title('GaN 3level/2 Parallel Topology Loss');

% 
% figure;
% %freq=(1.050:1:101.050);
% plot(freq, eff_E, 'linewidth', 2);
% grid on;
% xlabel('frequency (kHz)');
% ylabel('Efficiency');
% title('GaN 3level/2 Parallel Topology Loss');
% %%
% save('efficiency_ELOAD','eff_E');
% 
%       
%         

%%

cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\ForPlots');
save('Eload_e','Eload_e');

 
        

