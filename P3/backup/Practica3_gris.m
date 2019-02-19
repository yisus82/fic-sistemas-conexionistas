% LEEMOS LA IMAGEN
[imagen mapa_color] = imread('ex011[2].bmp', 'bmp');
[alto, ancho, profundidad] = size(imagen);

% MOSTRAMOS LA IMAGEN A UTILIZAR
figure;
image(imagen);
colormap(mapa_color);
title('Imagen original');
hold on;

% GENERAMOS LOS PUNTOS PARA TOMAR LOS PATRONES
if (distribucion == 1) % DISTRIBUCION UNIFORME
    puntos_aleatorios = abs(rand(2, numero_de_patrones));
    puntos_aleatorios(1, :) = puntos_aleatorios(1, :) * (ancho - 3) + 2;
    puntos_aleatorios(2, :) = puntos_aleatorios(2, :) * (alto - 3) + 2;
else    % DISTRIBUCION NO UNIFORME
    puntos_aleatorios = [];
    for i = 1:numero_de_patrones
        [columna fila] = ginput(1);
        puntos_aleatorios = [puntos_aleatorios [columna; fila]];
        plot(columna, fila, 'rs-', 'markersize', 6);
    end;    
end;

% GENERAMOS LOS PATRONES
puntos_aleatorios = round(puntos_aleatorios);
patrones = [];

for i = 1:numero_de_patrones
    ventana = imagen((puntos_aleatorios(2, i) - 1):(puntos_aleatorios(2, i) + 1), (puntos_aleatorios(1, i) - 1):(puntos_aleatorios(1, i) + 1));
    nivel_medio_de_gris = mean(ventana(:));
    patrones = [patrones nivel_medio_de_gris];
end   

% CREAMOS EL SOM
SOM = newsom([0 255], capa_de_salida, 'gridtop', 'dist');

% MOSTRAMOS EL ESPACIO DE SALIDAS SOBRE EL DE ENTRADAS ANTES DEL ENTRENAMIENTO
% IMAGEN (ESPACIO DE ENTRADAS)
figure;
subplot(2,1,1);
image(imagen);
colormap(mapa_color);
hold on;
% CONJUNTO DE ENTRENAMIENTO
plot(puntos_aleatorios(1, :), puntos_aleatorios(2, :), 'b.', 'markersize', 10); 
title('Espacio de salidas sobre el de entradas antes del entrenamiento');
% ESPACIO DE SALIDAS
subplot(2,1,2);
plotsom(SOM.IW{1,1}, SOM.layers{1}.distances);  


% REALIZAMOS EL ENTRENAMIENTO
SOM.trainParam.epochs = pasos_del_entrenamiento;
SOM = init(SOM);
SOM = train(SOM, patrones);

% MOSTRAMOS LOS RESULTADOS
% IMAGEN (ESPACIO DE ENTRADAS)
figure;
subplot(2,1,1);
imagesc(imagen);
colormap(mapa_color);
hold on;
% CONJUNTO DE ENTRENAMIENTO
plot(puntos_aleatorios(1, :), puntos_aleatorios(2, :), 'b.', 'markersize', 10); 
title('Espacio de salidas sobre el de entradas despues del entrenamiento');
subplot(2,1,2);
% ESPACIO DE SALIDAS
plotsom(SOM.IW{1,1}, SOM.layers{1}.distances);
