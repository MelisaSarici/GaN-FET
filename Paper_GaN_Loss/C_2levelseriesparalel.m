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
Eoss=0;
Econd=0;
P_GaN_cond=0;
Pper=0;
Ptotal=0;
Ts=Sampling_time;
swon=0;
swoff=0;
swrev=0;
cond=0;

%% 

for n=1:L
    if (Id(n)>1e-9  && n>1 && n<L) %meaning that IGBT is on operation
    
        if (Id(n-1)>-1e-9 && Id(n-1)<1e-9) %meaning that there is an on switching, the  swtiching period could take long
            Eon=GaN_sw(abs(Id(n)),'on'); %J
            Esw = Esw + Eon;
            swon=swon+1;
            
  
        elseif ((Id(n+1)>-1e-9 && Id(n+1)<1e-9) ) %meaning that there is an off switching, a decline in the current
            Eoff=GaN_sw(abs(Id(n)),'off'); %j
            Esw = Esw + Eoff;
            swoff=swoff+1;
            
        else
            Vds=GaN_cond(Id(n));
            Econd= Econd + Id(n)* Vds*Ts;
            cond=cond+1;
        end
        
        
    elseif  (Id(n)<-1e-9 && n<L) %meaning that diode is on operation
        
        if ((Id(n+1)>-1e-9 && Id(n+1)<1e-9)) %meaning that there is an off switching, a decline in the current
           Eoff=GaN_sw(abs(Id(n)),'off'); %j
           Esw = Esw + Eoff;
           swoff=swoff+1;
            
        elseif (Id(n-1)>-1e-9 && Id(n-1)<1e-9)
            Eon=GaN_sw(abs(Id(n)),'on'); %J
            Esw = Esw + Eon;
            swon=swon+1;
            
        else
            Vds=GaN_reverse_cond(Id(n));
            Erevcond= Erevcond + abs(Id(n))* Vds*Ts;
            revcond=revcond+1;
         end
    end
end

% IGBT Loss : Switching+Conduction(steady state)
Eoss=swon*11e-6; %J

P_GaN_cond = (Econd)*50;       %Total loss per IGBT
P_reverse_cond = (Erevsw + Erevcond)*50;
P_GaN_sw= Esw*50;
P_Coss=Eoss*50;

% Diode Loss : Condunction(ss) + Reverse Recovery



%% Total Loss

Pper=P_GaN_cond+P_reverse_cond+P_GaN_sw+P_Coss;
Ptotal=Pper*6;

%% Graphs
figure;
P=[P_GaN_cond P_reverse_cond P_GaN_sw P_Coss]*1000; %since the numbers are too low, multiplied by 1000
pie(P);
legend([P(1), P(2), P(3), P(4)], 'IGBT switching loss','diode switching loss','IGBT conduction loss','diode conduction loss')

title('I exp.- V data driven Loss Distribution IGBT inverter');



        

        
    
   
        
        
        
            
            
        
            
            
        
        
 




    
    
    
