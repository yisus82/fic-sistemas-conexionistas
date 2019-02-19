clear all;
close all;
clc;

% PARAMETROS
dimension1 = 8;
dimension2 = 8;
ciclos = 100;
numeroDeColores = 64;
distanciaMaxima = 8;    % DISTANCIA MAXIMA A LA QUE PUEDEN ESTAR LOS PEs PARA SER CONSIDERADOS DE LA MISMA CLASE
minimoActivaciones = 1; % NUMERO DE ACTIVACIONES MINIMAS PARA QUE UN PE PUEDA SER CONSIDERADO CENTRO DE CLUSTER. SI HAY MUCHAS MANCHAS PONER A 1

numeroDePEs = dimension1 * dimension2;



%%%%%%%%%%%%%%%%%% PRIMER APARTADO %%%%%%%%%%%%%%%%%%

% CARGAMOS LA IMAGEN RESULTADO DE LA SEGUNDA PRACTICA
load Quemaduras;
[tamanhoX tamanhoY] = size(imagenSalida);

% CONSTRUIMOS EL CONJUNTO DE ENTRENAMIENTO
[x y] = find(imagenSalida == 255);
CE = [x y];
numeroDePatrones = size(CE, 1);

% MOSTRAMOS LA IMAGEN DE ENTRADA
figure;
imagesc(imagenSalida);
colormap(gray);
title('Imagen de entrada');
ejesImagen = axis;

% CONSTRUCCION DEL CONJUNTO DE ENTRENAMIENTO
patrones = [];
for i = 1:numeroDePatrones
    fila = CE(i, 1);
    columna = CE(i, 2);
    patrones = [patrones [columna; fila]];
end; 

% CREAMOS EL SOM
SOM = newsom([1 tamanhoX; 1 tamanhoY], [dimension1 dimension2], 'gridtop', 'dist'); % OJO CON LOS TAMANHOS SI LA IMAGEN NO ES CUADRADA

% MOSTRAMOS EL ESPACIO DE ENTRADA
figure;
plot(patrones(1, :), patrones(2, :), '.b', 'markersize', 20);
axis('ij');
axis(ejesImagen);
title('Espacio de entrada');

% MOSTRAMOS EL ESPACIO DE SALIDA
figure;
plotsom(SOM.layers{1}.positions);
title('Espacio de salida');

% MOSTRAMOS EL ESPACIO DE SALIDA SOBRE EL DE ENTRADA ANTES DEL ENTRENAMIENTO
figure;
plot(patrones(1, :), patrones(2, :), '.g', 'markersize', 20);
hold on;
plotsom(SOM.IW{1, 1}, SOM.layers{1}.distances);  
hold off;
axis('ij');
axis(ejesImagen);
title('Espacio de salidas sobre el de entradas antes del entrenamiento');

% REALIZAMOS EL ENTRENAMIENTO DEL SOM
SOM.trainParam.epochs = ciclos;
SOM = train(SOM, patrones);

% MOSTRAMOS EL ESPACIO DE SALIDA SOBRE EL DE ENTRADA TRAS EL ENTRENAMIENTO
figure;
plot(patrones(1, :), patrones(2, :), '.g', 'markersize', 20);
hold on;
plotsom(SOM.IW{1,1}, SOM.layers{1}.distances);
axis('ij');
axis(ejesImagen);
hold off;
title('Espacio de salida sobre el de entrada despues del entrenamiento');



%%%%%%%%%%%%%%%%%% SEGUNDO APARTADO %%%%%%%%%%%%%%%%%%

% SIMULACION 
activaciones = zeros(1, numeroDePEs);
for i = 1:numeroDePatrones,
    entSim(1, 1) = patrones(1, i);  % EXTRAEMOS EL I-ESIMO PATRON DEL CONJUNTO DE PATRONES
    entSim(2, 1) = patrones(2, i);  % PARA REALIZAR LA SIMULACION CON EL SOM
    resSim = sim(SOM, entSim);      % SIMULAMOS EL SOM CON DICHO PATRON
    posicion = find(resSim == 1);   % BUSCAMOS EL PE DE LA CAPA DE SALIDA QUE SE ACTIVA
   activaciones(posicion) = activaciones(posicion)+1;   % CONTAMOS LAS VECES QUE SE ACTIVA CADA PE
end;
    
% BUSCAMOS LOS PATRONES QUE SE ACTIVAN MAS VECES DE LAS ESTABLECIDAS COMO MINIMO PARA SER CENTRO DE CLUSTER
vectorPos = find(activaciones >= minimoActivaciones);
for i = 1:length(vectorPos),
    array_pesos_ganadores(i, 1) = SOM.iw{1, 1}(vectorPos(i), 1);
    array_pesos_ganadores(i, 2) = SOM.iw{1, 1}(vectorPos(i), 2);
end

% CLASIFICACION EN NUEVAS CLASES
% TABLA DE DISTANCIAS ENTRE PE'S
distancias = dist((SOM.IW{1})');
    
% OBTENCION DE LAS SUBCLASES
clases = -ones(numeroDePEs);
for j = 1:length(vectorPos),
    dist = 0;
    it = 0;
    while ((dist <= distanciaMaxima) | (it <= numeroDePEs)),
        z = vectorPos(j);
        i = LocalizarMinimo(distancias, z);
        dist = distancias(i, z);
        if (dist < distanciaMaxima)
            distancias(i, z) = Inf;
            clases(z, i) = 1;
        end;
        it = it + 1;
    end;
end;

% OBTENEMOS LA IMAGEN DEFINITIVA  
imagen_final = 100 * ones(tamanhoX, tamanhoY);  
for i = 1:numeroDePEs
    for j = 1:numeroDePEs
        if (clases(i, j) == 1)
            coordenadaX = round(SOM.iw{1, 1}(j, 1));
            coordenadaY = round(SOM.iw{1, 1}(j, 2));
            color = i * floor(numeroDeColores / numeroDePEs);
            ventana = ones(5);
            ventana = ventana * color;
            imagen_final((coordenadaY - 2):(coordenadaY + 2),(coordenadaX - 2):(coordenadaX + 2)) = ventana;
        end;
    end
end;

% MOSTRAMOS LA IMAGEN DEFINITIVA  
figure;
image(imagen_final); 
hold on;
plotsom(SOM.iw{1,1},SOM.layers{1}.distances);
colormap(jet);
hold off;