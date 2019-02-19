clear all;
close all;

% Parametros
tamanho_ventana = 3;
margen = floor(tamanho_ventana / 2); 

% Leemos la imagen
[imagen_original mapa_color_entrada] = imread('image01.bmp', 'bmp');
imagen_con_patrones = imagen_original;

% Mostramos la imagen
figure(1);
image(imagen_original);
colormap(mapa_color_entrada);
title('Boton izquierdo = Carretera   Boton central = Bosque   Boton derecho = Resto');

% Generamos el conjunto de entrenamiento
patrones = [];
salidas_deseadas = [];

seguir = 1;
carreteras = 0;
bosques = 0;
resto = 0;

while  (seguir == 1)
    [x, y, boton] = ginput(1);
    % Si se presiona la tecla 'Esc' se sale
    if  (boton == 27) break; end;
    columna = round(x);
    fila = round(y);
    ventana = imagen_original((fila - margen):(fila + margen), (columna - margen):(columna + margen));
    nivel_medio_de_gris = mean(ventana(:));
    patrones = [patrones nivel_medio_de_gris];
    % Con el boton izquierdo (1) se cogen las carreteras (salida deseada = 1), con el boton central (2) se cogen los bosques 
    % (salida deseada = 2) y con el derecho (3) el resto (salida deseada = 0)
    if (boton == 1) 
            salidas_deseadas = [salidas_deseadas 1];
            color = 0;
            carreteras = carreteras + 1;
        else if (boton == 2)
            salidas_deseadas = [salidas_deseadas 2];
            color = 128;
            bosques = bosques + 1;
        else
            salidas_deseadas = [salidas_deseadas 0];
            color = 256;
            resto = resto + 1;
        end
    end
    % Coloreamos las ventanas que forman los patrones
    % Color verde (0) = carreteras, color rosa (128) = bosques y color rojo (256) = resto
    imagen_con_patrones((fila - margen):(fila + margen), (columna - margen)) = color;       
    imagen_con_patrones((fila - margen):(fila + margen), (columna + margen)) = color;       
    imagen_con_patrones((fila - margen), (columna - margen):(columna + margen)) = color;       
    imagen_con_patrones((fila + margen), (columna - margen):(columna + margen)) = color;       
    image(imagen_con_patrones);   
    colormap(mapa_color_entrada);
    title('Boton izquierdo = Carretera     Boton central = Bosques     Boton derecho = Resto     Tecla "Esc" = Terminar');
    texto = sprintf('Carreteras = %d     Bosques = % d     Resto =  %d     Total = %d ', carreteras, bosques, resto, (carreteras + bosques + resto));
    xlabel(texto);
end    
patrones = double(patrones);

% Creamos la red 

[red_entrenada registro_de_entrenamiento] = newrb(patrones, salidas_deseadas, 0.000001, 0.1);