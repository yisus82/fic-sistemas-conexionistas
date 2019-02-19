function [Pent] = calculaEntrada(img, mapa, dim, centroX, centroY)  
% Entrada:
%   img: imagen
%   mapa: mapa de  color de la imagen
%   dim: dimension de la ventana
%   centroX: coordenada x del punto central
%   centroY: coordenada y del punto central
% Salida:
%   Pent: patron de entrada para el perceptron que contiene la informacion de una subimagen
%   de la imagen original, de dimension dim y centrada en centroX, centroY
    
Pmatriz = img(centroX-floor(dim/2):centroX+floor(dim/2),centroY-floor(dim/2):centroY+floor(dim/2));

%image(Pmatriz); % Visualizacion de la imagen
%colormap(mapa); % Establezco el mapa de color de la figura

% Es necesario poner P en forma de vector 
elementos=dim*dim;
P=[];
P(1:elementos)=Pmatriz(1:dim,1:dim);
P=P'; %hago la traspuesta para que sea solo de una columna
Pent=[];
Pent=P;