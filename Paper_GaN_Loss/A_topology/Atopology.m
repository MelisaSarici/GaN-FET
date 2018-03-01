%% A TOPOLOGY (2 Level parallel) parameters

fsw=sw_frequency; %get from workspace of the saved data
Id=Idtop;
%%
figure;
plot(Id);
L=length(Id);
Esw=0;
Eoff=0;
Eon=0;
Edoff=0;
Econd=0;
Edcond=0;
Edsw=0;
P_IGBT=0;
P_diode=0;
Pper=0;
Ptotal=0;
Ts=Sampling_time;
swon=0;
swoff=0;
swd=0;
cond=0;
dcond=0;
%% 

for n=1:L
    if (Id(n)>1e-9  && n>1 && n<L) %meaning that IGBT is on operation
    
        if (Id(n-1)>-1e-9 && Id(n-1)<1e-9) %meaning that there is an on switching, the  swtiching period could take long
            Eon=IGBT_sw(abs(Id(n)),'on')*1e-3; %J
            Esw = Esw + Eon;
            swon=swon+1;
  
        elseif ((Id(n+1)>-1e-9 && Id(n+1)<1e-9) ) %meaning that there is an off switching, a decline in the current
            Eoff=IGBT_sw(abs(Id(n)),'off')*1e-3; %j
            Esw = Esw + Eoff;
            swoff=swoff+1;
            
        else
            Vds=GaN_cond(Id(n));
            Econd= Econd + Id(n)* Vds*Ts;
            cond=cond+1;
        end
        
        
    elseif  (Id(n)<-1e-9 && n<L) %meaning that diode is on operation
        
        if ((Id(n+1)>-1e-9 && Id(n+1)<1e-9)) %meaning that there is an off switching, a decline in the current
            Edoff=diode_sw(Id(n))*1e-3;
            Edsw = Edsw + Edoff;
            swd=swd+1;
            
        else
            Vds=diode_cond(Id(n));
            Edcond= Edcond + abs(Id(n))* Vds*Ts;
            dcond=dcond+1;
         end
    end
end

% IGBT Loss : Switching+Conduction(steady state)

P_IGBT = (Esw+Econd)*50;       %Total loss per IGBT

% Diode Loss : Condunction(ss) + Reverse Recovery

P_diode = (Edsw + Edcond)*50;

%% Total Loss

Pper=P_IGBT+P_diode;
Ptotal=Pper*6;

%% Graphs
figure;
E=[Esw Edsw Econd Edcond]*1000; %since the numbers are too low, multiplied by 1000
pie(E);
legend([E(1), E(2), E(3), E(4)], 'IGBT switching loss','diode switching loss','IGBT conduction loss','diode conduction loss')

title('I exp.- V data driven Loss Distribution IGBT inverter');



        

        
    
   
        
        
        
            
            
        
            
            
        
        
 




    
    
    
