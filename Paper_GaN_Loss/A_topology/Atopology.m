%% A TOPOLOGY (2 Level parallel) parameters

fsw=sw_frequency; %get from workspace of the saved data
%%
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

%% 

for n=1:L
    if (Id(n)>1e-9  && n>1 && n<L) %meaning that IGBT is on operation
    
        if (Id(n-1)>-1e-9 && Id(n-1)<1e-9) %meaning that there is an on switching, the  swtiching period could take long
            Eon=IGBT_sw(Id(n),'on')*1e-3; %J
            Esw = Esw + Eon;
  
        elseif ((Id(n+1)>-1e-9 && Id(n+1)<1e-9) ) %meaning that there is an off switching, a decline in the current
            Eoff=IGBT_sw(Id(n),'off')*1e-3; %j
            Esw = Esw + Eoff;
            
        else
            Vds=IGBT_cond(Id(n));
            Econd= Econd + Id(n)* Vds*Ts;
        end
        
        
    elseif  (Id(n)<-1e-9 && n<L) %meaning that diode is on operation
        
        if ((Id(n+1)>-1e-9 && Id(n+1)<1e-9)) %meaning that there is an off switching, a decline in the current
            Edoff=diode_sw(Id(n))*1e-3;
            Edsw = Edsw + Edoff;
            
        else
            Vds=diode_cond(Id(n));
            Edcond= Edcond + (-Id(n))* Vds*Ts;
         end
    end
end

% IGBT Loss : Switching+Conduction(steady state)

P_IGBT = (Esw+Econd)*fsw;       %Total loss per IGBT

% Diode Loss : Condunction(ss) + Reverse Recovery

P_diode = (Edsw + Edcond)*fsw;

%% Total Loss

Pper=P_IGBT+P_diode;
Ptotal=Pper*6;

%% Graphs
figure;
E=[Esw Edsw Econd Edcond]*1000; %since the numbers are too low, multiplied by 1000
pie(E);
legend([E(1), E(2), E(3), E(4)], 'IGBT switching loss','diode switching loss','IGBT conduction loss','diode conduction loss')

title('Loss Distribution in two level series IGBT inverter');



        

        
    
   
        
        
        
            
            
        
            
            
        
        
 




    
    
    
