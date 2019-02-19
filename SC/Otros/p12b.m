%Practica 2.2 (Bloque 1)
%Predicion de valores futuros de una señal a partir de varios valores
%pasados.
%Se usa un tipo de aprendizaje adaptativo lineal con adaline. 
%A la red se le presentan como patrones de entrenamiento n puntos consecutivos
%En el tiempo de la señal de entrada y la salida deseada que es el 
%punto siguiente a los anteriores.


clear all;
echo off; 
subplot(1,1,1);
clf;

tiempo=-5:0.01:5;

X1=sin(cos(tiempo.^2).*tiempo/10);
figure(1);
plot(tiempo,X1);
title('Representacion de la señal de entrada');
xlabel('Tiempo');
ylabel('Entrada');
X2=-2*X1 + 1;
pause

numero_entradas=3

P=delaysig(X1,1,numero_entradas);
T=X2;

[W,b]=initlin(P,T);
lr=0.5;
[A,E,W,b]=adaptwh(W,b,P,T,lr);
W
b

figure(2);
plot(tiempo,X2,'y',tiempo,A,'r--');
title('Representacion de salida deseada frente a la obtenida');
xlabel('Tiempo');
ylabel('Salida deseada __      Salida red _ _');
pause;

figure(3);
plot(tiempo,E)
hold on
plot([min(tiempo) max(tiempo)],[0 0],':r')
hold off
title('Representacion del error')
xlabel('Tiempo')
ylabel('Error')
