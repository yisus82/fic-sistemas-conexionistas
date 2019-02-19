%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%           PRACTICA 2: TRATAMIENTO DE SEÑALES    				 %%%
%%%																				 %%%
%%%		      DIEGO MARTIN BARRERIO FANDIÑO							 %%%
%%%																				 %%%		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

% Funcion original
time=0.001:0.001:0.3; 
SignIni=sin(time.^(-1)).*(time.^2)./tan(time);
SignTrans=(SignIni*2);

figure(1);
hold on;
	title(' SEÑAL ORIGINAL Y TRANSFORMADA');
	xlabel('Valores en X');
	ylabel('Valores en Y');
	plot(SignIni(:),'b');
	plot(SignTrans(:),'r');
legend('Azul=> Señal original','Rojo=> Señal transformada',4);
hold off;  

%   Primer supuesto entradas unidimensionales en la
% red, tendra que dar como resultado la señal inicial
% Inicializacion de la red
figure(2);
lr=maxlinlr(SignIni,'bias');
adaline=newlin([-4,3],1,[0],lr);
adaline=init(adaline);
adaline.biasConnect=1;
adaline.trainParam.epochs= 100;
adaline.trainParam.goal=0.000000001;

[adaline,tr]=train(adaline,SignIni,SignTrans);
%[adaline,Y,Err]=adapt(adaline,Senhal1,Senhal2);


% Representacion de los resultados obtenidos
figure(3); 
SignRes=sim(adaline,SignIni);
hold on;
	title(' SEÑAL ORIGINAL, TRANSFORMADA Y RESULTANTE');
	xlabel('Valores en X');
	ylabel('Valores en Y');
	plot(SignIni,'b');
	plot(SignTrans,'r');
	plot (SignRes,'k');
	legend('Azul=> Señal original','Rojo=> Señal transformada','Negro=> Senhal resultado', 4);
hold off;

