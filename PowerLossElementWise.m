%% run before simulink 
mf=51;
Ts=1e-5;
Ts1=Ts/100;
f=50;
f_sw=f*mf;

time=20e-3;
Vs=7;
Vt=15;
ma=Vs/Vt;
cycle=time*f;
Ls=1e-9;
%% Calculation of loss by integrating over the whole time in two different methods
t=size(tout,1);
P=zeros();
P_second_way=0;
for k=1:t
    P(k+1)=P(k)+Ids(k)*Vce(k)*(1e-5)*f/cycle; %per cycle loss
    P_second_way=Power(k)+P_second_way;
end
 P_second_way= P_second_way/t; %per cycle loss
plot(P)
 %addition of 2001 values, therefore the integral adds 2001 terms. For average sum is divided to 2001
%first method uses zero hold method, multiplying the sampled value with
%delta t and then with frequency o get the average voltage, the latter gets
%the multiplied data from Simulink to workspace and adds the discrete 2001
%values and then averaging. Both give the same result. 

%% 
