cur=0.85/3.6*0.069*75/80*295;
x0=0.31;
x1=0.255;
T=25;


    Vds=zeros();
    Vds(1)=-5;
    for k=1:1:99
        Vds(k+1)=Vds(k)+0.1;
    end

Vgs=0;
for k=1:1:6
  
    Ids=zeros();
    for n=1:1:100
        if Vds(n)==0
            Vds(n)=0.001;
        end
        if Vds(n)>0
            Ids(n)=cur*(0.8*((T-25+273)/300)^-2.7)*log(1+exp(26*(Vgs-7.9+6.2)))*Vds(n)/(1+max((x0+x1*(Vgs+4.1)),0.2)*Vds(n));
        else
            Ids(n)=-cur*(0.8*((T-25+273)/300)^-2.7)*log(1+exp(21*((Vgs-Vds(n))-7.9+6.2)))*(-Vds(n))/(1+max((x0+x1*((Vgs-Vds(n))+6.1)),0.2)*(-Vds(n)));
        end
    end
    Vgs=Vgs+1;
    
    plot(Vds,Ids,'linewidth', 2);
    hold on;

end
xlabel('Vds');
ylabel('Ids');
grid on;
legend('Vgs=0','Vgs=1','Vgs=2','Vgs=3','Vgs=4','Vgs=5','Vgs=6');