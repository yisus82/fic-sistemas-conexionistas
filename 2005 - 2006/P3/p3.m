% Inicializacion de los parametros
dimension1 = 5;
dimension2 = 10;
ciclos = 100;
numero_colores = 64;
% Distancia maxima a la que estan los PEs de una clase
distancia_maxima = 3;    
% Numero de activaciones para que un PE sea centro de cluster
minimo_activaciones = 1; 
numero_PEs = dimension1 * dimension2;

% Leemos la imagen
[tamanhoX tamanhoY] = size(imagen_obtenida);

% Mostramos la imagen
figure;
imagesc(imagen_obtenida);
mapa_color = [1 1 1; 0 0 0];
colormap(mapa_color);
title('Imagen de entrada');
ejes_imagen = axis;

% Generamos el conjunto de entrenamiento
[x y] = find(imagen_obtenida == 1);
conjunto_entrenamiento = [x y];
numero_patrones = size(conjunto_entrenamiento, 1);
patrones = [];
for i = 1:numero_patrones
    fila = conjunto_entrenamiento(i, 1);
    columna = conjunto_entrenamiento(i, 2);
    patrones = [patrones [columna; fila]];
end; 

SOM = newsom([1 tamanhoX; 1 tamanhoY], [dimension1 dimension2], 'gridtop', 'dist');

% Mostramos el espacio de entrada
figure;
plot(patrones(1, :), patrones(2, :), 'k.');
axis('ij');
axis(ejes_imagen);
title('Espacio de entrada');

% Mostramos el espacio de salida
figure;
plotsom(SOM.layers{1}.positions);
title('Espacio de salida');

% Mostramos el espacio de salidas sobre el de entradas antes del entrenamiento
figure;
plot(patrones(1, :), patrones(2, :), 'k.');
hold on;
plotsom(SOM.IW{1, 1}, SOM.layers{1}.distances);  
hold off;
axis('ij');
axis(ejes_imagen);
title('Espacio de salidas sobre el de entradas antes del entrenamiento');

% Entrenamos el SOM
SOM.trainParam.epochs = ciclos;
SOM = train(SOM, patrones);

% Mostramos el espacio de salidas sobre el de entradas despues del entrenamiento
figure;
plot(patrones(1, :), patrones(2, :), 'k.');
hold on;
plotsom(SOM.IW{1,1}, SOM.layers{1}.distances);
axis('ij');
axis(ejes_imagen);
hold off;
title('Espacio de salida sobre el de entrada despues del entrenamiento');

activaciones = zeros(1, numero_PEs);

% Vamos simulando uno a uno los patrones y buscando el PE de la capa de salida que se activa 
for i = 1:numero_patrones,
    patron(1, 1) = patrones(1, i);  
    patron(2, 1) = patrones(2, i);  
    resultado = sim(SOM, patron);      
    posicion = find(resultado == 1);  
    activaciones(posicion) = activaciones(posicion) + 1;   
end;
    
% Buscamos los centros de cluster (los PEs que superan el minimo de activaciones establecido)
activados = find(activaciones >= minimo_activaciones);

% Obtenemos las distancias entre los PEs
distancias = dist((SOM.IW{1})');
    
% Obtenemos las subclases
clases = zeros(numero_PEs);
for j = 1:length(activados),
    distancia = 0;
    iteraciones = 0;
    while ((distancia <= distancia_maxima) | (iteraciones <= numero_PEs)),
        z = activados(j);
        i = minimo(distancias, z);
        distancia = distancias(i, z);
        if (distancia < distancia_maxima)
            distancias(i, z) = Inf;
            clases(z, i) = 1;
        end;
        iteraciones = iteraciones + 1;
    end;
end;

% Obtenemos la imagen de salida  
imagen_salida = (numero_colores + 1) * ones(tamanhoX, tamanhoY);  
for i = 1:numero_PEs
    for j = 1:numero_PEs
        if (clases(i, j) == 1)
            x = round(SOM.iw{1, 1}(j, 1));
            y = round(SOM.iw{1, 1}(j, 2));
            color = i * floor(numero_colores / numero_PEs);
            ventana = ones(5);
            ventana = ventana * color;
            imagen_salida((y - 2):(y + 2),(x - 2):(x + 2)) = ventana;
        end;
    end
end;

mapa_color = [jet(numero_colores); 1 1 1];
% for i = 1:numero_colores
%     mapa_color = [mapa_color; (i / (numero_colores + 1))*(mod(i,2)==0) (i / (numero_colores + 1))*(mod(i,3)==0) (i / (numero_colores + 1))];
% end
% mapa_color = [mapa_color; 1 1 1];

% MOSTRAMOS LA IMAGEN DEFINITIVA  
figure;
imagesc(imagen_salida); 
hold on;
plotsom(SOM.iw{1,1},SOM.layers{1}.distances);
colormap(mapa_color);
hold off;
