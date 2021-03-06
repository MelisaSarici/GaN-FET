%% A TOPOLOGY (2 Level parallel) parameters

clear all;
close all;

cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\E-CtopologyGaN');
load('dataB_corrected');
%%

P_GaN_cond=zeros();
P_GaN_sw=zeros();
P_Coss=zeros();
P_reverse_cond=zeros();
Pper=zeros();
Ptotal=zeros();
E=zeros();

%% 

for (satir=1:20)

L=length(Id(satir,:));
fsw=1050+(satir-1)*1000;
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
Ptotal(satir)=Pper(satir)*6;
E(satir,1:4)=[Erevcond Esw Econd Eoss];
end

%% Graphs
figure;
freq=(1.050:5:100.050);
plot(freq, Ptotal);
xlabel('frequency (kHz)');
ylabel('Loss (W)');
title('IGBT loss calculation vs frequency');
figure;
bar(E,'stacked');
legend('GaN revcond', 'Switch', 'Conduction', 'Coss');


        

        
    
   
        
        
        
            
            
        
            
            
        
        
 




    
    
    
