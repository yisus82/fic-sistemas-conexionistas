clear all;
close all;

senhal = -10:0.02:10;

%obtencion de las muestras de la senhal
paso=20/149;
muestras=[];
for i=0:149
    muestras=[muestras -10+paso*i];
end;
signal=funcion(muestras);
figure(1)
plot(muestras,signal)
title('Senhal de entrada')

patrones=[];
deseada=[];
for i=1:length(signal)-1
    patrones=[patrones muestras(i)];%signal(i)
    deseada=[deseada signal(i)];%signal(i+1)
end;

figure(2)
% stem(patrones,'r')
stem(deseada,'r')
title('Muestras tomadas para el entrenamiento')

red=newff([-10 10],[25 1],{'tansig','purelin'});
%red.trainFcn='traingdx';
%red.trainParam.mc=0.7;
red.trainParam.epochs=1000;
red=train(red,patrones,deseada);
Y=sim(red,senhal);

figure(3)
plot(senhal,Y)
hold on;
Error=abs(funcion(senhal) - Y);
plot(senhal,Error,'r')
plot(senhal,funcion(senhal),'g')
title('En azul la senhal obtenida, en verde la senhal de entrada y en rojo el error cometido durante el ENTRENAMIENTO')

%validacion

paso=40/149;
muestras=[];
for i=0:149
    muestras=[muestras -20+paso*i];
end;
senhal2=[-20:0.04:20];

signal2=funcion(muestras);
patrones2=[];
deseada2=[];
for i=1:length(signal2)-1
    patrones2=[patrones2 muestras(i)];
    deseada2=[deseada2 signal2(i)];
end;

Y2=sim(red,senhal2);
Error2=abs(funcion(senhal2) - Y2);

figure(4)
plot(muestras,signal2,'g')
title('Senhal de Validacion')

figure(5)
plot(senhal2,Y2)
hold on;
plot(senhal2,Error2,'r')
plot(senhal2,funcion(senhal2),'g')
title('En azul la senhal obtenida, en rojo el error cometido y en verde la senhal a obtener durante la VALIDACION')

figure(6);
plot(senhal2,Error,'r')
hold on;
plot(senhal2,Error2,'g')
title('En rojo error durante el ENTRENAMIENTO y en verde durante la VALIDACION')
