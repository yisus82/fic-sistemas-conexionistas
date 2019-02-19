clear all;
close all;
clc;

% PARAMETROS DEL PROBLEMA
altoVentana = 7;
anchoVentana = 7;
margenAltura = floor(altoVentana / 2);
margenAnchura = floor(anchoVentana / 2);
dimensionEntrada = altoVentana * anchoVentana;

% LECTURA DE LA IMAGEN DE ENTRADA
[imagenEntrada mapaColoresEntrada] = imread('imagen1.bmp', 'bmp');
imagenEntrada = double(imagenEntrada);
imagenEntrada2 = imagenEntrada;
[alto ancho] = size(imagenEntrada);

% REPRESENTACION DE LA IMAGEN DE ENTRADA (SU COPIA)
figure;
imagesc(imagenEntrada2);
colormap(mapaColoresEntrada);
title('Imagen utilizada en el entrenamiento de la red');

% OBTENCION DE LOS PATRONES DE ENTRENAMIENTO
numeroPatrones = 30;
for i = 1:numeroPatrones,
    [columna fila salida] = ginput(1);
    columna = floor(columna);
    fila = floor(fila);
    patronEntrada = imagenEntrada((fila - margenAltura):(fila + margenAltura), (columna - margenAnchura):(columna + margenAnchura));
    patronesEntrada(:, i) = patronEntrada(:);
    if (salida == 1) salidasDeseadas(i) = 0;    % 0 (BOTON IZQUIERDO) -> COLOR NEGRO
        color = 50;
    else salidasDeseadas(i) = 1;                % 1 (OTRO BOTON) -> COLOR BLANCO
        color = 256;
    end;
    imagenEntrada2((fila - margenAltura):(fila + margenAltura), columna - margenAnchura) = color;
    imagenEntrada2((fila - margenAltura):(fila + margenAltura), columna + margenAnchura) = color;
    imagenEntrada2(fila - margenAltura, (columna - margenAnchura):(columna + margenAnchura)) = color;
    imagenEntrada2(fila + margenAltura, (columna - margenAnchura):(columna + margenAnchura)) = color;
    imagesc(imagenEntrada2);
end;    

% NORMALIZACION DE LOS PATRONES DE ENTRADA
patronesEntrada = patronesEntrada / 255;

% ESPECIFICACION DE LA ARQUITECTURA DE LA RED
capaOculta1 = 64;
capaOculta2 = 49;
for i = 1:dimensionEntrada,
    rangoEntradas(i, :) = [0 255];
end;

% ENTRENAMIENTO DE LA RED
perceptron = newff(rangoEntradas, [capaOculta1 capaOculta2 1], {'logsig' 'logsig' 'logsig'}, 'traingdx');
perceptron.trainParam.lr = 0.5;
perceptron.trainParam.mc = 0.75;
perceptron.trainParam.epochs = 10000;
perceptron.trainParam.goal = 1e-9;
perceptron.trainParam.min_grad = 1e-15;
perceptron = init(perceptron);
[perceptron registroDeEntrenamiento] = train(perceptron, patronesEntrada, salidasDeseadas);