%  PRACTICA 1
%  ADALINE
% 1 ASOCIOACION DE PATRONES

%%%%%%%%%%%%%%%%  CASO 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%% a1)

% agrupamos por componentes
clear all; close all;

P=[-4 1; 3 2];
D=[5 -2];
a1=-4:0.2:4;
a2=a1;

%  Dibuja la superficie de error

for i=1:length(a1)
   for j=1:length(a2)
       SupError(i,j)=sumsqr(D-[a1(i) a2(j)]*P)/2;
 end;
end;

% figure(1);
% plotes( a1, a2, SupError);
% hold on;


% % Entrenamiento con velocidad de aprendizaje baja, entrenamiento del adaline
% 
% % Inicializacion del adaline
% adaline= newlin([-5 5 ; -5 5],1);
% %adaline= newlin([-5 5 ; -5 5],1,0,0.01);
% adaline.biasConnect=0;
% 
% %adaline.IW{1}(1)=randn(1)*5
% %adaline.IW{1}(2)=randn(1)*5
% 
% Y=sim (adaline,P);
% 
% Er=D-Y;
% minErr=( (D(1)-Y(1))^2 + (D(2)-Y(2))^2)/2;
% lp.lr= 0.01;
% 
% plotep (adaline.IW{1}(2),adaline.IW{1}(1),minErr);
% it=0;
% 
% % ENTRENAMIENTO
% while ( (minErr > 0.0001) & (it < 50) ),   
%    it=it+1
%    dw= learnwh(adaline.IW{1},P,[],[],[],D,Er,[],[],[],lp,[]);
%    Y=sim(adaline,P);
%    Er=D-Y;
%    dw
%    adaline.IW{1}=adaline.IW{1} + dw;
%    minErr= ( (D(1)-Y(1))^2 + (D(2)-Y(2))^2)/2;
%    VectErr(it)=minErr;
%    plotep(adaline.IW{1}(1),adaline.IW{1}(2),minErr);
% end;
% 
% 
% figure(2); 
% hold on;
% % Variacion del error
% for i=1:it,
%     plot(i,VectErr(i),'r*-');
% end; 
% hold off;

% %%%%%%%%%%%%% A2)
% 
% %adaline.IW{1}(1)=rand(1)*5;
% %adaline.IW{1}(2)=rand(1)*5;
% 
% Y=sim(adaline, P)
% Er=D-Y;
% minErr= ( (D(1)-Y(1))^2 + (D(2)-Y(2))^2 )/2
% lp.lr=0.09;
% it=0;
% 
% figure(3);
% hold on;
% plotes(a1,a2,SupError);
% plotep(adaline.IW{1}(2),adaline.IW{1}(1),minErr);
% while ( (minErr>0.0001) & (it < 30) ) ,
%     it=it+1
%     dw=learnwh(adaline.IW{1},P,[],[],[],D,Er,[],[],[],lp,[]);
%     Y=sim(adaline,P);
%     Er=D-Y;
%     adaline.IW{1}=adaline.IW{1}+dw;
%     minErr= ( (D(1)-Y(1))^2 + (D(2)-Y(2))^2 )/2;
%     VectErr(it)=minErr;
%     plotep(adaline.IW{1}(2),adaline.IW{1}(1),minErr);
% end;  
% hold off;
% 
% figure(4);
% hold on;
% for i=1:it,
%     plot(i,VectErr(1),'r.-');
% end;
% hold off;  	
% 
% %%%%%%%%%%%%%%%%%%%% CASO 3 %%%%%%%%%%%%%%%%%%%%%
% 
% % Vectores linealmente dependientes
% 
% P= [-4 2; 2 -1];
% D= [2 -1];
%  
% 
% %  Dibuja la superficie de error
% 
% for i=1:length(a1)
%    for j=1:length(a2)
%        SupError(i,j)=sumsqr(D-[a1(i) a2(j)]*P)/2;
%  end;
% end;
% 
% adaline.IW{1}(1)=rand(1)*5;
% adaline.IW{1}(2)=rand(1)*5;
%  
% Y=sim(adaline,P);
% Er=D-Y;	
% minErr= ( (D(1)-Y(1))^2 +(D(2)-Y(2))^2 ) /2 ;
% lp.lr=0.01;
% it=0;
% 
% figure(5); 
% hold on;
% plotes(a1,a2,SupError);
% plotep(adaline.IW{1}(1),adaline.IW{1}(2),minErr);
% 
% while ( (minErr > 0.0001) & (it < 30) ),
%     it=it+1
%     dw=learnwh(adaline.IW{1},P,[],[],[],D,Er,[],[],[],lp,[]); 
%     Y=sim(adaline,P);
%     Er=D-Y;
%     minErr= ( (D(1)-Y(1))^2 +(D(2)-Y(2))^2 ) /2 ; 	
%     adaline.IW{1}=adaline.IW{1}+dw;
%     VectErr(it)=minErr;
%     plotep(adaline.IW{1}(1),adaline.IW{1}(2),minErr);
% end;
% hold off;  
% 
% figure(6); 
% hold on;
% % Variacion del error
% for i=1:it,
%     plot(i,VectErr(i),'r*-');
% end; 
% hold off;
  