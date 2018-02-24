%% A TOPOLOGY (2 Level parallel) parameters

m_a=0.9;
fsw=; %get from workspace of the saved data

%% 

for (n=n1:(n1+0.02/Ts))
    if (Id(n)>0) %meaning that IGBT is on operation
    
        if ((Id(n-1)==0) || (Id(n-2)==0) || (Id(n-3)==0)) %meaning that there is an on switching, the  swtiching period could take long
            Eon=IGBT_sw(Id(n),'on');
            Esw = Esw + Eon*Ts;
        
        elseif ((Id(n+1)==0) || (Id(n+2)==0) || (Id(n+3)==0)) %meaning that there is an off switching, a decline in the current
            Eoff=IGBT_sw(Id(n),'off');
            Esw = Esw + Eoff*Ts;
            
        else
            Vds=IGBT_cond(I(n));
            Econd= Econd + Id(n)* Vds;
        end
        
        
    elseif  (Id(n)<0) %meaning that diode is on operation
        
        if ((Id(n+1)==0) || (Id(n+2)==0) || (Id(n+3)==0)) %meaning that there is an off switching, a decline in the current
            Edoff=diode_sw(Id(n));
            Edsw = Edsw + Edoff*Ts;
            
        else
            Vds=diode_cond(I(n));
            Edcond= Edcond + Id(n)* Vds*Ts;
         end
    end
end

% IGBT Loss : Switching+Conduction(steady state)

P_IGBT = (Esw+Econd)*fsw;       %Total loss per IGBT

% Diode Loss : Condunction(ss) + Reverse Recovery

P_diode = (Edsw + Edcond)*fsw;

%% Total Loss

Pper=P_IGBT+P_diode;
Ptotal=Pper+6;



        

        
    
   
        
        
        
            
            
        
            
            
        
        
 




    
    
    
