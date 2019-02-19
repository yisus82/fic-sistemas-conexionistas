clear all;
close all;

% Parametros
numero_de_patrones = 70;
tamanho_ventana = 7;
precision = 0.9;
margen = floor(tamanho_ventana / 2); 

% Leemos la imagen
[imagen mapaColorEntrada] = imread('image01.bmp', 'bmp');

% Mostramos la imagen
figure(1);
image(imagen);
colormap(mapaColorEntrada);
title(' -- IMAGEN ORIGINAL -- ');

% OBTENEMOS LAS DIMENSIONES DE LA IMAGEN
[alto, ancho, profundidad] = size(imagen);

% GENERAMOS EL CONJUNTO DE ENTRENAMIENTO
patrones = [];
salidas_deseadas = [];

for i = 1:numero_de_patrones
    [c, f, boton] = ginput(1);
    columna = round(c);
    fila = round(f);
    ventana = imagen((fila - margen):(fila + margen), (columna - margen):(columna + margen));
    patrones = [patrones ventana(:)];
    if (boton == 1) salidas_deseadas = [salidas_deseadas 1];
    else salidas_deseadas = [salidas_deseadas 0]; 
    end
    imagen_2((fila - margen):(fila + margen), columna - margen) = 256;       
    imagen_2((fila - margen):(fila + margen), columna + margen) = 256;       
    imagen_2(fila - margen, (columna - margen):(columna + margen)) = 256;       
    imagen_2(fila + margen, (columna - margen):(columna + margen)) = 256;       
    image(imagen_2);   
    colormap(mapa_color_entrada);
end    
patrones = double(patrones);

rango_de_entradas = [];
for i = 1:(tamanho_ventana * tamanho_ventana)
	rango_de_entradas = [rango_de_entradas; [0 255]];
end

red = newff(rango_de_entradas, [50 50 1], {'tansig', 'tansig', 'tansig'}, 'traingdx');

red.trainParam.epochs = 10000;
red.trainParam.min_grad = 1e-30;
[red, registro_de_entrenamiento] = train(red, patrones, salidas_deseadas);
