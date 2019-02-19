% Leemos la imagen
[imagen mapa_color] = imread('ex011[2].bmp', 'bmp');
[alto, ancho, profundidad] = size(imagen);

% Mostramos la imagen original
figure;
image(imagen);
colormap(mapa_color);
title('Imagen original');
hold on;

% Generamos los puntos aleatorios, que luego seran los patrones
% Distribucion uniforme
if (distribucion == 1)
    puntos_aleatorios = abs(rand(2, numero_de_patrones));
    puntos_aleatorios(1, :) = puntos_aleatorios(1, :) * (ancho - 1) + 1;
    puntos_aleatorios(2, :) = puntos_aleatorios(2, :) * (alto - 1) + 1;
% Distribucion no uniforme
else
    puntos_aleatorios = [];
    for i = 1:numero_de_patrones
        [columna fila] = ginput(1);
        puntos_aleatorios = [puntos_aleatorios [columna ; fila]];
        plot(columna, fila, 'rs-', 'markersize', 6);
    end;    

end;
patrones = round(puntos_aleatorios);

% Creamos el SOM
SOM = newsom([1 ancho; 1 alto], capa_de_salida, 'gridtop', 'dist');

% Mostramos la configuracion inicial del SOM
figure;
plotsom(SOM.layers{1}.positions);
title('Espacio de Salidas');

% Mostramos el espacio de salidas sobre el de entradas antes del entrenamiento
figure;
imagesc(imagen);
colormap(mapa_color);
hold on;
plotsom(SOM.IW{1,1}, SOM.layers{1}.distances);  
title('Espacio de salidas sobre el de entradas antes del entrenamiento');
hold on;
plot(patrones(1, :), patrones(2, :), 'g*', 'markersize', 10);   

% Entrenamiento del SOM
SOM.trainParam.epochs = pasos_del_entrenamiento;
SOM = init(SOM);
SOM = train(SOM, patrones);

% Mostramos los resultados obtenidos
figure;
imagesc(imagen);
colormap(mapa_color);
hold on;
plotsom(SOM.IW{1,1}, SOM.layers{1}.distances);
title('Espacio de salidas sobre el de entradas despues del entrenamiento');
hold on;
plot(patrones(1, :), patrones(2, :), 'g*', 'markersize', 10);  