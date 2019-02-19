%Ivan Perez Mozos ITIS

close all;
clear all;

%Patrones linealmente dependientes. Infinitas soluciones con error 0

%Patrones de entrada
entradas=[1 2;2 4];
d=[2 4];


%Entrenamiento del adaline

%Inicio aleatoriamente la matriz de pesos
W=rand(1,2)*10;

%Fijo la velocidad de aprendizaje
lp.lr=0.02;

%Vector con dos posiciones donde se iran guardando los errores relativos a
%cada uno de los patrones
e=[d(1)- dotprod(W,entradas(:,1)),d(2)-dotprod(W,entradas(:,2))];

error=((d(1)- dotprod(W,entradas(:,1)))^2+(d(2)-dotprod(W,entradas(:,2)))^2)*0.5;
verror(1)=error;
iters=0;

%Entrenamiento; En vpesos almacenare los pesos segun vayan variando con
%cada iteracion, mientras que en verror se hara lo propio con el ECM
while error>0.0001 & iters<200
    dW=learnwh([],entradas,[],[],[],[],e,[],[],[],lp,[]);
    vpesos(iters+1,:)=W;
    W=W+dW;
    e=[d(1)- dotprod(W,entradas(:,1)),d(2)-dotprod(W,entradas(:,2))];
    error=((d(1)- dotprod(W,entradas(:,1)))^2+(d(2)-dotprod(W,entradas(:,2)))^2)*0.5;
    verror(iters+2)=error;
    iters=iters+1;
end
vpesos(iters+1,:)=W;    

%Ahora dibujaremos las graficas

x=-10:0.2:10;
y=-10:0.2:10;

[X,Y]=meshgrid(x,y);

%Sea Z la matriz de valores de la funcion:

Z=((d(1)-X*entradas(1,1)-Y*entradas(2,1)).^2+(d(2)-X*entradas(1,2)-Y*entradas(2,2)).^2)*0.5;

%A continuacion dibujamos la grafica de la funcion del error


mesh(X,Y,Z)
hold on
plot3(vpesos(1:iters+1,1)',vpesos(1:iters+1,2)',verror,'k')
hold off


%Representamos las curvas de nivel de la grafica

figure(2);

contour(X,Y,Z,10)
hold on
plot3(vpesos(1:iters+1,1)',vpesos(1:iters+1,2)',verror,'k')
hold off

%Dibujo la variacion del error con respecto al numero de ciclos
figure(3);
plot(0:iters,verror);



