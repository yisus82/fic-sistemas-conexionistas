clear all;
close all;

% Parametros
tamanho_ventana = 7;
margen = floor(tamanho_ventana / 2); 

% Leemos la imagen
[imagen_original mapa_color_entrada] = imread('images2_06.bmp', 'bmp');

% PRIMERA RED: Manchas de cola
imagen_con_patrones1 = imagen_original;

% Mostramos la imagen
figure(1);
image(imagen_original);
colormap(mapa_color_entrada);
title('Boton izquierdo = Manchas de cola  Boton derecho = Resto');

% Generamos el conjunto de entrenamiento
patrones1 = [];
salidas_deseadas1 = [];

seguir = 1;
cola = 0;
resto = 0;

while  (seguir == 1)
    [x, y, boton] = ginput(1);
    % Si se presiona la tecla 'Esc' se sale
    if  (boton == 27) break; end;
    columna = round(x);
    fila = round(y);
    ventana = imagen_original((fila - margen):(fila + margen), (columna - margen):(columna + margen));
    %nivel_medio_de_gris = mean(ventana(:));
    patrones1 = [patrones1 ventana(:)];
    % Con el boton izquierdo (1) se cogen las manchas de cola (salida deseada = 1)
    % y con el derecho (3) el resto (salida deseada = 0)
    if (boton == 1) 
            salidas_deseadas1 = [salidas_deseadas1 1];
            color = 0;
            cola = cola + 1;
        else
            salidas_deseadas1 = [salidas_deseadas1 0];
            color = 256;
            resto = resto + 1;
        end
    % Coloreamos las ventanas que forman los patrones
    % Color negro (0) = cola y color blanco (256) = resto
    imagen_con_patrones1((fila - margen):(fila + margen), (columna - margen)) = color;       
    imagen_con_patrones1((fila - margen):(fila + margen), (columna + margen)) = color;       
    imagen_con_patrones1((fila - margen), (columna - margen):(columna + margen)) = color;       
    imagen_con_patrones1((fila + margen), (columna - margen):(columna + margen)) = color;       
    image(imagen_con_patrones1);   
    colormap(mapa_color_entrada);
    title('Boton izquierdo = Manchas de cola     Boton derecho = Resto     Tecla "Esc" = Terminar');
    texto = sprintf('Manchas de cola = %d     Resto =  %d     Total = %d ', cola, resto, (cola + resto));
    xlabel(texto);
end    
patrones1 = double(patrones1);

% Creamos la red 

rango_de_entradas = [];
for i = 1:(tamanho_ventana * tamanho_ventana)
	rango_de_entradas = [rango_de_entradas; [0 255]];
end

red1 = newff(rango_de_entradas, [length(patrones1) floor(length(patrones1) / 2) 1], {'logsig', 'logsig', 'logsig'}, 'traingdx');

red1.trainParam.epochs = 10000;
red1.trainParam.min_grad = 1e-30;
[red_entrenada1, registro_de_entrenamiento] = train(red1, patrones1, salidas_deseadas1);

% SEGUNDA RED: Manchas de secado

imagen_con_patrones2 = imagen_original;
% Mostramos la imagen
figure;
image(imagen_original);
colormap(mapa_color_entrada);
title('Boton izquierdo = Manchas de secado  Boton derecho = Resto');

% Generamos el conjunto de entrenamiento
patrones2 = [];
salidas_deseadas2 = [];

seguir = 1;
secado = 0;
resto = 0;

while  (seguir == 1)
    [x, y, boton] = ginput(1);
    % Si se presiona la tecla 'Esc' se sale
    if  (boton == 27) break; end;
    columna = round(x);
    fila = round(y);
    ventana = imagen_original((fila - margen):(fila + margen), (columna - margen):(columna + margen));
    %nivel_medio_de_gris = mean(ventana(:));
    patrones2 = [patrones2 ventana(:)];
    % Con el boton izquierdo (1) se cogen las manchas de secado (salida deseada = 1)
    % y con el derecho (3) el resto (salida deseada = 0)
    if (boton == 1) 
            salidas_deseadas2 = [salidas_deseadas2 1];
            color = 0;
            secado = secado + 1;
        else
            salidas_deseadas2 = [salidas_deseadas2 0];
            color = 256;
            resto = resto + 1;
        end
    % Coloreamos las ventanas que forman los patrones
    % Color negro (0) = cola y color blanco (256) = resto
    imagen_con_patrones2((fila - margen):(fila + margen), (columna - margen)) = color;       
    imagen_con_patrones2((fila - margen):(fila + margen), (columna + margen)) = color;       
    imagen_con_patrones2((fila - margen), (columna - margen):(columna + margen)) = color;       
    imagen_con_patrones2((fila + margen), (columna - margen):(columna + margen)) = color;       
    image(imagen_con_patrones2);   
    colormap(mapa_color_entrada);
    title('Boton izquierdo = Manchas de secado     Boton derecho = Resto     Tecla "Esc" = Terminar');
    texto = sprintf('Manchas de secado = %d     Resto =  %d     Total = %d ', secado, resto, (secado + resto));
    xlabel(texto);
end    
patrones2 = double(patrones2);

% Creamos la red 

rango_de_entradas = [];
for i = 1:(tamanho_ventana * tamanho_ventana)
	rango_de_entradas = [rango_de_entradas; [0 255]];
end

red2 = newff(rango_de_entradas, [length(patrones2) floor(length(patrones2) / 2) 1], {'logsig', 'logsig', 'logsig'}, 'traingdx');

red2.trainParam.epochs = 10000;
red2.trainParam.min_grad = 1e-30;
[red_entrenada2, registro_de_entrenamiento] = train(red2, patrones2, salidas_deseadas2);
