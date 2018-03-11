clear all;
close all;
%%
cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\A_topology');
run('Atopology.m');
cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\A_topology');
run('AtopologyLOAD.m');
cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\B');
run('Btopology.m');
cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\B');
run('BtopologyLOAD.m');
cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\E-CtopologyGaN');
run('Ctopology.m');
cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\E-CtopologyGaN');
run('CtopologyLOAD.m');
cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\t3level\D_topology');
run('Dtopology.m');
cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\t3level\D_topology');
run('DtopologyLOAD.m');
cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\t3level\E_topology');
run('Etopology.m');
cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\t3level\E_topology');
run('EtopologyLOAD.m');
%%
clear all;
close all;
%%
cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\ForPlots');
load('P_a','P_a');
load('Efficiency_A','Efficiency_A');
load('E_a','E_a');
load('P_b','P_b');
load('Efficiency_B','Efficiency_B');
load('E_b','E_b');
load('P_c','P_c');
load('Efficiency_C','Efficiency_C');
load('E_c','E_c');
load('P_d','P_d');
load('Efficiency_D','Efficiency_D');
load('E_d','E_d');
load('P_e','P_e');
load('Efficiency_E','Efficiency_E');
load('E_e','E_e');
load('Eload_a','Eload_a');
load('Eload_b','Eload_b');
load('Eload_c','Eload_c');
load('Eload_d','Eload_d');
load('Eload_e','Eload_e');




 %% Loss
 
figure;
freq=(1.050:1:25.050);
plot(freq, P_a, 'linewidth', 2);
hold on;
freq=(1.050:5:100.050);
plot(freq, P_c, 'linewidth', 2);
freq=(1.050:1:100.050);
plot(freq, P_b, 'linewidth', 2);
plot(freq, P_d, 'linewidth', 2);
plot(freq, P_e, 'linewidth', 2);
hold off;
grid on;

xlabel('frequency (kHz)');
ylabel('Loss (W)');
xlim([0 105]);
legend('IGBT 2 level single','GaN 2 level 2 Series 2 parallel','GaN 2 level 2 Series','GaN 3 level NPC','GaN 3 level  2 parallel','NorthWest');
title('Loss per topology');   



%% Efficiency

figure;
freq=(1.050:1:25.050);
plot(freq, Efficiency_A, 'linewidth', 2);
hold on;
freq=(1.050:1:100.050);
plot(freq, Efficiency_B, 'linewidth', 2);
freq=(1.050:5:100.050);
plot(freq, Efficiency_C, 'linewidth', 2);
freq=(1.050:1:100.050);
plot(freq, Efficiency_D, 'linewidth', 2);
plot(freq, Efficiency_E, 'linewidth', 2);
hold off;
grid on;

xlabel('frequency (kHz)');
ylabel('Per cent efficiency %)');
xlim([0 105]);
legend('IGBT 2 level single','GaN 2 level 2 Series','GaN 2 level 2 Series 2 parallel','GaN 3 level NPC','GaN 3 level  2 parallel','NorthWest');
title('Efficiency per topology');   

%% Loss Distribution
E_a=cat(2,E_a,0);
E_b=cat(2,E_b,0);
E_c=cat(2,E_c,0);
%%
figure;
% all=[E_a/sum(E_a(1:5))*100  ; E_b/sum(E_b(1:5))*100 ; E_c/sum(E_c(1:5))*100; E_d/sum(E_d(1:5))*100; E_e/sum(E_e(1:5))*100];
all= [E_a; E_b; E_c; E_d; E_e];
bar(all,'stacked');
legend('Transistor Switching','Transistor Conduction','IGBT diode switching/ GaN Coss','Reverse Conduction','Clamping Diode(Only 3 level)','Orientation','horizontal','Location','North');
x=gca;
a{1}='IGBT 2 level single';
a{2}='GaN 2 level 2 Series';
a{3}='GaN 2 level 2 Series 2 parallel';
a{4}='GaN 3 level NPC';
a{5}='GaN 3 level  2 parallel';
set(x,'XTickLabels',a);
%title('Per cent (%) Loss Distribution per Topology ');
title(' Loss Distribution per Topology ');
ylabel(' Loss (W)');
xlabel('Topology');
grid on;

%% Load Variation

figure;
load=(800:800:8000);
hold on;
plot(load, Eload_a, 'linewidth', 2);
plot(load, Eload_b, 'linewidth', 2);
plot(load, Eload_c, 'linewidth', 2);
plot(load, Eload_d, 'linewidth', 2);
plot(load, Eload_e, 'linewidth', 2);
hold off;
grid on;
xlabel('load');
ylabel('Per cent efficiency %');
legend('IGBT 2 level single','GaN 2 level 2 Series','GaN 2 level 2 Series 2 parallel','GaN 3 level NPC','GaN 3 level  2 parallel','NorthWest');
title('Efficiency vs Load  per topology');   



        