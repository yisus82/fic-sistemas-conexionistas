% Parametros
tamanho_ventana_X = 3;
tamanho_ventana_Y = 7;
margenX = floor(tamanho_ventana_X / 2); 
margenY = floor(tamanho_ventana_Y / 2); 

% Leemos la imagen
[imagen_original mapa_color_entrada] = imread('images2_06.bmp', 'bmp');
imagen_con_patrones = imagen_original;

% Mostramos la imagen
figure;
imagesc(imagen_original);
colormap(mapa_color_entrada);
title('Boton izquierdo = Manchas de secado   Boton derecho = Resto');

% Generamos el conjunto de entrenamiento
patrones_secado = [];
salidas_deseadas_secado = [];

seguir = 1;
secado = 0;
resto = 0;

while  (seguir == 1)
    [x, y, boton] = ginput(1);
    if  (boton == 27) break; end;
    columna = round(x);
    fila = round(y);
    ventana = imagen_original((fila - margenX):(fila + margenX), (columna - margenY):(columna + margenY));
    patrones_secado = [patrones_secado ventana(:)];
    % Con el boton izquierdo (1) se cogen las manchas de secado (salida deseada = 1) y con el derecho (3) el resto (salida deseada = 0)
    if (boton == 1) 
            salidas_deseadas_secado = [salidas_deseadas_secado 1];
            color = 0;
            secado = secado + 1;
        else 
            salidas_deseadas_secado = [salidas_deseadas_secado 0];
            color = 256;
            resto = resto + 1;
    end
    imagen_con_patrones((fila - margenX):(fila + margenX), (columna - margenY)) = color;       
    imagen_con_patrones((fila - margenX):(fila + margenX), (columna + margenY)) = color;       
    imagen_con_patrones((fila - margenX), (columna - margenY):(columna + margenY)) = color;       
    imagen_con_patrones((fila + margenX), (columna - margenY):(columna + margenY)) = color;       
    imagesc(imagen_con_patrones);   
    colormap(mapa_color_entrada);
    title('Boton izquierdo = Manchas de secado     Boton derecho = Resto     Tecla "Esc" = Terminar');
    texto = sprintf('Manchas de secado = %d     Resto =  %d     Total = %d ' ,  secado ,  resto ,  (secado + resto));
    xlabel(texto);
end    
patrones_secado = double(patrones_secado);

% Normalizamos los patrones
patrones_secado = patrones_secado / 255;

rango_de_entradas = [];
for i = 1:(tamanho_ventana_X * tamanho_ventana_Y)
	rango_de_entradas = [rango_de_entradas; [0 255]];
end

red_secado = newff(rango_de_entradas, [length(patrones_secado) floor(length(patrones_secado) / 2) 1], {'logsig', 'logsig', 'logsig'}, 'traingdx');

red_secado.trainParam.epochs = 10000;
red_secado.trainParam.min_grad = 1e-30;
[red_entrenada_secado, registro_de_entrenamiento] = train(red_secado, patrones_secado, salidas_deseadas_secado);
