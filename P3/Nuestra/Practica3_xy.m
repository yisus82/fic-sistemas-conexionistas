% LEEMOS LA IMAGEN
[imagen mapa_color] = imread('p3sc.bmp', 'bmp');
[alto, ancho, profundidad] = size(imagen);

% MOSTRAMOS LA IMAGEN
figure;
image(imagen);
colormap(mapa_color);
hold on;

if (distribucion == 1) 
    puntos_aleatorios = abs(rand(2, numero_de_patrones));
else puntos_aleatorios = abs(randn(2, numero_de_patrones));
end;

% GENERAMOS LOS PATRONES
patrones = [];

puntos_aleatorios(1, :) = puntos_aleatorios(1, :) * (ancho - 1) + 1;
puntos_aleatorios(2, :) = puntos_aleatorios(2, :) * (alto - 1) + 1;
patrones = round(puntos_aleatorios);

% CREAMOS EL SOM
SOM = newsom([1 ancho; 1 alto], capa_de_salida, 'hextop', 'dist');

% REALIZAMOS EL ENTRENAMIENTO
SOM.trainParam.epochs = pasos_del_entrenamiento;
SOM = init(SOM);
SOM = train(SOM, patrones);

% MOSTRAMOS LOS RESULTADOS
plotsom(SOM.IW{1,1}, SOM.layers{1}.distances);
hold on;
plot(patrones(1, :), patrones(2, :), 'g*', 'markersize', 10);