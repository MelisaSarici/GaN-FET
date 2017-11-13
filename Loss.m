 I_cp=30;
 V_ce=650;
 E_swon=47.5e-6; 
 E_swoff=7.5e-6;
 f_sw=100e3;
T=0;
x=0:0.1:2*pi;
%%
% 
% Psw=(E_swon+E_swoff)*f_sw/pi;
% Ptot=Psw+Pss;

% %%
% 
% for D=0:0.1:1
% A=power(sin(x),2).*(1+sin(x+T).*D)./2;
% plot(x,A);
% hold on;
% title('Integral term in the formula');
% %B=int(power(sin(x),2).*(1+sin(x+T).*D)./2, x, 0, pi);
% end

%% Conduction Losses wrt D
D=zeros(101,9);
Pss=zeros(101,9);
T=zeros();

for m=1:9
    T(m+1)=T(m)+10/180*pi;

    for k=1:100
        D(k+1,m)=D(k,m)+0.01;
    Pss(k,m)=I_cp*V_ce*(1/8+D(k,m)/3/pi*cos(T(m)));
    end
Pss(101,m)=I_cp*V_ce*(1/8+D(101,m)/3/pi*cos(T(m)));

u=plot(D,Pss,'linewidth',1.5);
hold on
end

legend(u,'\theta=0','\theta=10','\theta=20','\theta=30','\theta=40','\theta=50','\theta=60','\theta=70','\theta=80','\theta=90')
title('Conduction Losses wrt \theta  and D');
xlabel('D=0:0.01:1');


