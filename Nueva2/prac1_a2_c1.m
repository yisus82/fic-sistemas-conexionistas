clear all;
close all;

delta=0.01;
extremo1=-5;
extremo2=5;
x=extremo1:delta:extremo2;
f=x.^3;

%Posibilidad de introducir ruido en la señal
ruido = wgn(length(x),1,10);
fruido=f+ruido';
%f=fruido;



%Inicio aleatoriamente la matriz de pesos
W=rand(1,3)*1;
%W=zeros(1,3);
%Fijo la velocidad de aprendizaje
lp.lr=0.000001;


i=1;
while i<=(length(f)-2)
    %Genero un patron de cada vez
    entradas=[f(i);f(i+1);f(i+2)];
    salida=f(i+2);
    %Calculo el error asociado al patron
    e=salida - dotprod(W,entradas);
    %Calculo la variacion de pesos
    dW=learnwh([],entradas,[],[],[],[],e,[],[],[],lp,[]);
    W=W+dW;
    %Almaceno en un vector la salida obtenida
    s_obtenida(i+1)= dotprod(W,entradas);
    %Almaceno en un vector el error cometido
    verror(i+1)= salida -s_obtenida(i+1);
    i=i+1;
end



hold on;
plot(x,f,'b');
plot(x(2:length(x)-1),s_obtenida(2:length(x)-1),'r');
plot(x(2:length(x)-1),verror(2:length(x)-1),'g');
hold off;


