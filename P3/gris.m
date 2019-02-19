% Leemos la imagen
[imagen mapa_color] = imread('ex011[2].bmp', 'bmp');
[alto, ancho, profundidad] = size(imagen);

% Mostramos la imagen original
figure;
image(imagen);
colormap(mapa_color);
title('Imagen original');
hold on;

% Generamos los puntos aleatorios
% Distribucion uniforme
if (distribucion == 1)
    puntos_aleatorios = abs(rand(2, numero_de_patrones));
    puntos_aleatorios(1, :) = puntos_aleatorios(1, :) * (ancho - 3) + 2;
    puntos_aleatorios(2, :) = puntos_aleatorios(2, :) * (alto - 3) + 2;
% Distribucion no uniforme
else
    puntos_aleatorios = [];
    for i = 1:numero_de_patrones
        [columna fila] = ginput(1);
        puntos_aleatorios = [puntos_aleatorios [columna; fila]];
        plot(columna, fila, 'rs-', 'markersize', 6);
    end;    
end;
puntos_aleatorios = round(puntos_aleatorios);

% Generamos los patrones
patrones = [];
for i = 1:numero_de_patrones
    ventana = imagen((puntos_aleatorios(2, i) - 1):(puntos_aleatorios(2, i) + 1), (puntos_aleatorios(1, i) - 1):(puntos_aleatorios(1, i) + 1));
    nivel_medio_de_gris = mean(ventana(:));
    patrones = [patrones nivel_medio_de_gris];
end   

% Creamos el SOM
SOM = newsom([0 255], capa_de_salida, 'gridtop', 'dist');

% Mostramos el espacio de salidas sobre el de entradas antes del entrenamiento
figure;
subplot(2,1,1);
% image(imagen);
% colormap(mapa_color);
degradado = 1:256;
imagesc(degradado);
colormap(gray);
title('Espacio de salidas sobre el de entradas antes del entrenamiento');
hold on;
%plot(puntos_aleatorios(1, :), puntos_aleatorios(2, :), 'b.', 'markersize', 10); 
subplot(2,1,2);
axis([0.5 1.5 1 256]);
plotsom(SOM.IW{1,1}, SOM.layers{1}.distances);  



% Entrenamiento del SOM
SOM.trainParam.epochs = pasos_del_entrenamiento;
SOM = init(SOM);
SOM = train(SOM, patrones);

% Mostramos los resultados obtenidos
figure;
subplot(2,1,1);
% image(imagen);
% colormap(mapa_color);
degradado = 1:256;
imagesc(degradado);
colormap(gray);
title('Espacio de salidas sobre el de entradas despues del entrenamiento');

hold on;
%plot(puntos_aleatorios(1, :), puntos_aleatorios(2, :), 'b.', 'markersize', 10); 
subplot(2,1,2);
axis([0.5 1.5 1 256]);
plotsom(SOM.IW{1,1}, SOM.layers{1}.distances);  
