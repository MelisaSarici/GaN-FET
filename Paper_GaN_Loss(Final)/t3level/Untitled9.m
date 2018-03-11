cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\t3level\D_topology');

load('dataDd');
Id=I_diode;
for  (satir=1:20)

L=length(Id(satir,:));


for n=1:L
    
    if (Id(satir,n)>-1e-5 && Id(satir,n)<1e-5) %meaning that there is an on switching, the  swtiching period could take long
       Id(satir,n)=0;    
    end
end

end
save('dataDd_corrected', 'Id');

%%

cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\t3level\D_topology');
load('dataDGb');

Id=I_GaNbottom;
for  (satir=1:20)

L=length(Id(satir,:));


for n=1:L
    
    if (Id(satir,n)>-1e-5 && Id(satir,n)<1e-5) %meaning that there is an on switching, the  swtiching period could take long
       Id(satir,n)=0;    
    end
end

end
save('dataDGb_corrected', 'Id');

%%

cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\GaN-FET\Paper_GaN_Loss\t3level\D_topology');
load('dataDGt');

Id=I_GaNtop;

for  (satir=1:20)

L=length(Id(satir,:));


for n=1:L
    
    if (Id(satir,n)>-1e-5 && Id(satir,n)<1e-5) %meaning that there is an on switching, the  swtiching period could take long
       Id(satir,n)=0;    
    end
end

end
save('dataDGt_corrected', 'Id');