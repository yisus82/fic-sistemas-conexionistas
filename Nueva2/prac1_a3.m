clear all;
close all;

%Muestreo una senhal como la pedida en el ejercicio
x1=-10:0.01:0;
x2=0.01:0.01:10;
x=[x1 x2];

%d=(cos(x.^2)./(pi*(1+x.^2))).*130;
d=[20*sin(x1) 200*sin(x2)];
%d=cos(x);

%Inicio aleatoriamente la matriz de pesos
W=rand(1,6)*5;
%W=zeros(1,6);
%Fijo la velocidad de aprendizaje
lp.lr=0.00001;

i=1;
s_obtenida(1:6)=zeros(1,6);
verror(1:6)=zeros(1,6);

while i<=(length(d)-6)
    %Genero un patron de cada vez
    entradas=[d(i);d(i+1);d(i+2);d(i+3);d(i+4);d(i+5)];
    salida=d(i+6);
    %Calculo el error asociado al patron
    e=salida - dotprod(W,entradas);
    %Calculo la variacion de pesos
    dW=learnwh([],entradas,[],[],[],[],e,[],[],[],lp,[]);
    W=W+dW;
    %Almaceno en un vector la salida obtenida
    s_obtenida(i+6)= dotprod(W,entradas);
    %Almaceno en un vector el error cometido
    verror(i+6)= salida -s_obtenida(i+6);
    i=i+1;
end


hold on;
plot(x,d,'k');

plot(x,s_obtenida,'r');
plot(x,verror,'g');
hold off;


