clear all;
close all;

% Parametros
tamanho_ventana = 7;
margen = floor(tamanho_ventana / 2); 

% Leemos la imagen
[imagen_original mapa_color_entrada] = imread('image01.bmp', 'bmp');
imagen_con_patrones = imagen_original;

% Mostramos la imagen
figure(1);
image(imagen_original);
colormap(mapa_color_entrada);
title('Boton izquierdo = Carretera   Boton derecho = No-carretera');

% Generamos el conjunto de entrenamiento
patrones = [];
salidas_deseadas = [];

seguir = 1;
carreteras = 0;
no_carreteras = 0;

while  (seguir == 1)
    [x, y, boton] = ginput(1);
    if  (boton == 27) break; end;
    columna = round(x);
    fila = round(y);
    ventana = imagen_original((fila - margen):(fila + margen), (columna - margen):(columna + margen));
    patrones = [patrones ventana(:)];
    % Con el boton izquierdo (1) se cogen las carreteras (salida deseada = 1) y con el derecho (3) las no-carreteras (salida deseada = 0)
    if (boton == 1) 
            salidas_deseadas = [salidas_deseadas 1];
            color = 0;
            carreteras = carreteras + 1;
        else 
            salidas_deseadas = [salidas_deseadas 0];
            color = 256;
            no_carreteras = no_carreteras + 1;
    end
    imagen_con_patrones((fila - margen):(fila + margen), (columna - margen)) = color;       
    imagen_con_patrones((fila - margen):(fila + margen), (columna + margen)) = color;       
    imagen_con_patrones((fila - margen), (columna - margen):(columna + margen)) = color;       
    imagen_con_patrones((fila + margen), (columna - margen):(columna + margen)) = color;       
    image(imagen_con_patrones);   
    colormap(mapa_color_entrada);
    title('Boton izquierdo = Carretera     Boton derecho = No-carretera     Tecla "Esc" = Terminar');
    texto = sprintf('Carreteras = %d     No-carreteras =  %d     Total = %d ' ,  carreteras ,  no_carreteras ,  (carreteras + no_carreteras));
    xlabel(texto);
end    
patrones = double(patrones);

rango_de_entradas = [];
for i = 1:(tamanho_ventana * tamanho_ventana)
	rango_de_entradas = [rango_de_entradas; [0 255]];
end

red = newff(rango_de_entradas, [length(patrones) floor(length(patrones)/2) 1], {'logsig', 'logsig', 'logsig'}, 'traingdx');

red.trainParam.epochs = 10000;
red.trainParam.min_grad = 1e-30;
[red_entrenada, registro_de_entrenamiento] = train(red, patrones, salidas_deseadas);
