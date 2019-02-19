clear all
close all

[A,B]=imread('ojo1copia','bmp');
colormap(B)
image(A)
[m,n]=size(A);
k=1;
%generamos el conjunto de entrenamiento
for i=1:m-6,
    for j=1:n-6,
        P2=[];
        for ii=0:6,
            P2=[P2 A(i+ii,j:j+6)];
        end
        P(k,:)=double(P2);
        k=k+1;
    end
end
%generamos los valores de la red
for i=1:49,
    E(i,:)=[0 255];
end
red=newsom(E,[8 8],'gridtop','dist');
red.trainFcn='trainwb1';
red.trainParam.epochs=10000000;
figure
plotsom(red.layers{1}.positions)
red=train(red,P');
%entrenamos la red
figure
plotsom(red.IW{1,1},red.layers{1}.distances)
%Pesos=red.IW{1};
%for i=1:64,
 %   Pesosmedia(i,:)=mean(Pesos(i,:));
 %end
%sacar las clases
I=sim(red,P');
%simulamos la red
for i=1:length(I)
for j=1:64
if (not (I(j,i)==0))
clases(k)=j;
%cojemos un vector con el numero de clase para cada patron

k=k+1;
end
end

a=red.iw{1,1};
colores=a(:,25); % cogemos el color del patron central
k=1;
for i=1:length(clases)
    if((colores(clases(i)))<=20)
        resultado(k)=0;
        k=k+1;
    elseif((colores(clases(i)))<=30)
         resultado(k)=25;
         k=k+1; 
     elseif((colores(clases(i)))<=60)
         resultado(k)=50;
         k=k+1;
     elseif((colores(clases(i)))<=80)
         resultado(k)=70;
         k=k+1;
     elseif((colores(clases(i)))<=100)
         resultado(i)=90;
         k=k+1;
     elseif((colores(clases(i)))<=120)
         resultado(k)=110;
         k=k+1;
     elseif((colores(clases(i)))<=140)
         resultado(k)=130;
         k=k+1;
     else
         resultado(i)=150;
         k=k+1;
     end;
 end; %generamos los colores resultantes
    
 k=1;
 for i=1:286
     for j=1:378
         imagenfinal(i,j)=resultado(k);
         k=k+1;
     end
 end %generamos la imagen final
 colormap(B);
 image(imagenfinal);
 
    
    
    
    
    
         
    
