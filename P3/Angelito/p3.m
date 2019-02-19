%Practica 3. Segmentacion imagen. Sistemas conexionistas 
clear all;
close all;
caso=input('Introduzca el caso a tratar(1/2):');

%CASO 1: Tomando los patrones de entrada como subventanas de 3x3 en base al
%color de cada pixel(escala de gris=entre 0 y 255).
if caso==1
  a=imread('imagenP3.JPG','jpg');  
  ce=input('Elija el conjunto de patrones de entrenamiento uniforme o no uniforme(u/n):');
  if ce=='u' 
    xy=floor(rand(2,500)*240)+1;
  end
  if ce=='n'
    xy=floor(PatronesNoUniformes)+1;
  end 
  p1=1;
  p2=1;
  for len=1:length(xy(1,:))
      x=xy(1,len);
      y=xy(2,len);
      for i=x:x+2
          for j=y:y+2
             P(p1,p2)=a(i,j);
             p1=p1+1;
         end
     end 
      p1=1;
      p2=p2+1;
  end   
  % Mostramos el espacio de entrada.
  figure(1)
  colormap(gray);
  imagesc(a);
  title('Espacio de entradas');
  %Mostramos el conjunto de entrenamiento:Ventanas de 3x3 tomadas de la
  %imagen
  figure(2)
  ce=conjuntoE(xy);
  colormap(gray);
  imagesc(ce);
  Title('Conjunto de entrenamiento');
  % Creamos el mapa.
  mapa=input('Elija el espacio de salidas unidimensional o bidimensional(u/b):');
  NPEcaso1=input('Elija el numero de pes del mapa:');
  save NPEcaso1;
  minmax=[0 255;0 255;0 255;0 255;0 255;0 255;0 255;0 255;0 255];
  if mapa=='u'
     somcaso1=newsom(minmax,[NPEcaso1],'gridtop','dist');
  end
  if mapa=='b'
     somcaso1=newsom(minmax,[NPEcaso1 NPEcaso1],'gridtop','dist');
  end   
  figure(3)
  plotsom(somcaso1.layers{1}.positions)
  Title('Espacio de salida');
  % Mostramos los pesos antes del entrenamiento.
  figure(4);
  plotsom(somcaso1.iw{1,1},somcaso1.layers{1}.distances,'b')
  title('Pesos de los PEs antes del entrenamiento.');
  pause;
  % Parametros de la red.
  somcaso1.trainParam.epochs=100;
  somcaso1.trainParam.goal=0.01;
  %Entrenamos el mapa autoorganizativo(som)
  P=double(P);
  somcaso1=train(somcaso1,P);
  % Mostramos los pesos despues del entrenamiento.
  figure(5);
  plotsom(somcaso1.iw{1,1},somcaso1.layers{1}.distances)
  title('Pesos de los PEs despues del entrenamiento.');
  save somcaso1;
end

%CASO 2: Tomando los patrones como sus coordenadas (x,y)

if caso==2
 ce=input('Elija el conjunto de patrones de entrenamiento uniforme o no uniforme(u/n):');
 if ce=='u' 
  P=rand(2,500)*250;
 end
 if ce=='n'
  P=PatronesNoUniformes;
 end
 %Mostramos el espacio de entrada.
 figure(1)
 a=imread('imagenP3.JPG','jpg');
 imagesc(a);
 title('Espacio de entradas.');
 % Mostramos el conjunto de entrenamiento tomado del espacio de entradas.
 figure(2); 
 plot(P(1,:),P(2,:),'.b','markersize',10)
 title('Conjunto de entrenamiento'); 
 % Creamos el mapa.
 mapa=input('Elija el espacio de salidas unidimensional o bidimensional(u/b):');
 NPEcaso2=input('Elija el numero de pes del mapa:');
 save NPEcaso2;
 if mapa=='u'
  somcaso2=newsom([0 250;0 250],[NPEcaso2],'gridtop','dist');
 end
 if mapa=='b'
  somcaso2=newsom([0 250;0 250],[NPEcaso2 NPEcaso2],'gridtop','dist');
 end
 figure(3)
 plotsom(somcaso2.layers{1}.positions)
 title('Espacio de salidas.');
 % Mostramos los pesos antes del entrenamiento.
 figure(4);
 plotsom(somcaso2.iw{1,1},somcaso2.layers{1}.distances,'b')
 title('Pesos de los PEs antes del entrenamiento.');
 pause;
 % Parametros de la red. 
 somcaso2.trainParam.epochs=5000; %veces que presento el conjunto de entrenamiento
 somcaso2.trainParam.goal=0.01;   %error que queremos
 P=double(P);
 somcaso2=train(somcaso2,P);

% Mostramos los pesos despues del entrenamiento.

figure(5);
plotsom(somcaso2.iw{1,1},somcaso2.layers{1}.distances)
title('Pesos de los PEs despues del entrenamiento.');
save somcaso2;
end
    