clear all;
close all;

%Definimos los puntos en donde esta definida la senhal
puntos = -10:0.02:10;

%Obtenemos las muestras de la senhal
paso=20/149;
muestras=[];
for i=0:149
    muestras=[muestras -10+paso*i];
end;
senhal=funcion(muestras);

%Dibujamos la senhal de entrada
figure(1)
plot(muestras,senhal)
title('Senhal de entrada')

%Construimos los vectores de patrones de entrada y salida deseada
patrones=muestras;
deseada=senhal;

%Dibujamos las muestras tomadas para el entrenamiento
figure(2)
stem(patrones)
title('Muestras tomadas para el entrenamiento')

%Creamos el perceptron
red=newff([-10 10],[25 1],{'tansig','purelin'});

%Ponemos 1000 iteraciones para el entrenamiento y entrenamos
%red.trainFcn = 'traingdx';
red.trainParam.epochs=1000;
[red,tr,Y,E,Pf,Af]=train(red,patrones,deseada);

%Dibujamos la senhal que da como salida el perceptron, la senhal original y el error cometido durante el entrenamiento
figure(3)
plot(muestras,Y)
hold on;
plot(muestras,E,'r')
plot(muestras,senhal,'g')
title('En azul la senhal obtenida, en verde la senhal de entrada y en rojo el error cometido durante el ENTRENAMIENTO')

%Procedemos a la validacion de la red con otra senhal
senhal2=funcion(muestras);
Y2=sim(red,puntos);

%Dibujamos la senhal usada para la validacion
figure(4)
plot(muestras,senhal2)
title('Senhal de Validacion')

%Dibujamos la senhal que da como salida el perceptron, la senhal original y el error cometido
figure(5)
plot(puntos,Y2)
hold on;
Error2=abs(funcion(puntos) - Y2);
plot(puntos,Error2,'r')
plot(puntos,funcion(puntos),'g')
title('En azul la senhal obtenida, en rojo el error cometido y en verde la senhal a obtener durante la VALIDACION')

%Dibujamos el error cometido en el entrenamiento y en la validacion
figure(6);
plot(muestras,E,'r')
hold on;
plot(puntos,Error2,'g')
title('En rojo error durante el ENTRENAMIENTO y en verde durante la VALIDACION')
