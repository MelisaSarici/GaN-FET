cd('C:\Users\syf.DESKTOP-JNMNU9A\Documents\GitHub\mlv_inv\topologies to be evaluated\compact versions\compact2level\seriesparallel')

load('dataC.mat');
Id=Ids1;
for  (satir=1:20)

L=length(Id(satir,:));


for n=1:L
    
    if (Id(satir,n)>-1e-5 && Id(satir,n)<1e-5) %meaning that there is an on switching, the  swtiching period could take long
       Id(satir,n)=0;    
    end
end

end
save('dataC_corrected', 'Id');
