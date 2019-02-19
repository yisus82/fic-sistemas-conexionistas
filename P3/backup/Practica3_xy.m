% LEEMOS LA IMAGEN
[imagen mapa_color] = imread('ex011[2].bmp', 'bmp');
[alto, ancho, profundidad] = size(imagen);

% MOSTRAMOS LA IMAGEN A UTILIZAR
figure;
title('Imagen original');
image(imagen);
colormap(mapa_color);
hold on;

% GENERAMOS LOS PUNTOS PARA TOMAR LOS PATRONES
if (distribucion == 1) % DISTRIBUCION UNIFORME
    puntos_aleatorios = abs(rand(2, numero_de_patrones));
    puntos_aleatorios(1, :) = puntos_aleatorios(1, :) * (ancho - 1) + 1;
    puntos_aleatorios(2, :) = puntos_aleatorios(2, :) * (alto - 1) + 1;
else    % DISTRIBUCION NO UNIFORME
    puntos_aleatorios = [];
    for i = 1:numero_de_patrones
        [columna fila] = ginput(1);
        puntos_aleatorios = [puntos_aleatorios [columna ;fila]];
        plot(columna, fila, 'rs-', 'markersize', 6);
    end;    

end;


% GENERAMOS LOS PATRONES
patrones = round(puntos_aleatorios);

% CREAMOS EL SOM
SOM = newsom([1 ancho; 1 alto], capa_de_salida, 'gridtop', 'dist');

%MOSTRAMOS LA CONFIGURACION INICIAL DE LOS PES
figure;
plotsom(SOM.layers{1}.positions);
title('Espacio de Salidas');

% MOSTRAMOS EL ESPACIO DE SALIDAS SOBRE EL DE ENTRADAS ANTES DEL ENTRENAMIENTO
% IMAGEN (ESPACIO DE ENTRADAS)
figure;
image(imagen);
colormap(mapa_color);
hold on;
% ESPACIO DE SALIDAS
plotsom(SOM.IW{1,1}, SOM.layers{1}.distances);  
title('Espacio de salidas sobre el de entradas antes del entrenamiento');
hold on;
% CONJUNTO DE ENTRENAMIENTO
plot(patrones(1, :), patrones(2, :), 'g*', 'markersize', 10);   

% REALIZAMOS EL ENTRENAMIENTO
SOM.trainParam.epochs = pasos_del_entrenamiento;
SOM = init(SOM);
SOM = train(SOM, patrones);

% MOSTRAMOS LOS RESULTADOS
% IMAGEN (ESPACIO DE ENTRADAS)
figure;
imagesc(imagen);
colormap(mapa_color);
hold on;
% ESPACIO DE SALIDAS
plotsom(SOM.IW{1,1}, SOM.layers{1}.distances);
title('Espacio de salidas sobre el de entradas despues del entrenamiento');
hold on;
% CONJUNTO DE ENTRENAMIENTO
plot(patrones(1, :), patrones(2, :), 'g*', 'markersize', 10);  