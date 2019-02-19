% LECTURA DE LA IMAGEN DE ENTRADA
[imagenEntrada mapaColoresEntrada] = imread('img.tif', 'tif');
imagenEntrada = double(imagenEntrada);
[alto ancho] = size(imagenEntrada);

% REPRESENTACION DE LA IMAGEN DE ENTRADA
figure;
imagesc(imagenEntrada);
colormap(mapaColoresEntrada);
title('Imagen utilizada en la simulacion de la red');

% OBTENCION DE TODOS LOS PATRONES DE LA IMAGEN
k = 1;
for i = (margenAltura + 1):(alto - margenAltura),
    for j = (margenAnchura + 1):(ancho - margenAnchura),
        patron = imagenEntrada((i - margenAltura):(i + margenAltura), (j - margenAnchura):(j + margenAnchura));
        patronesImagen(:, k) = patron(:);
        k = k + 1;
    end
end;    

% NORMALIZACION DE LOS PATRONES DE LA IMAGEN
patronesImagen = patronesImagen / 255;

% SIMULACION DE LA RED ENTRENADA UTILIZANDO TODOS LOS PATRONES DE LA IMAGEN
salidas = sim(perceptron, patronesImagen);

% CREACION DE LA IMAGEN OBTENIDA
umbral = 0.95;
imagenSalida = [];
k = 1;
for i = (margenAltura + 1):(alto - margenAltura),
    for j = (margenAnchura + 1):(ancho - margenAnchura),
        if salidas(k) >= umbral imagenSalida((i - margenAltura):(i + margenAltura), (j - margenAnchura):(j + margenAnchura)) = 255;
        else imagenSalida((i - margenAltura):(i + margenAltura), (j - margenAnchura):(j + margenAnchura)) = 0;
        end;
        k = k + 1;
    end
end;

% MOSTRAMOS LA IMAGEN OBTENIDA
figure;
imagesc(imagenSalida);
colormap(gray);
title('Resultado de la simulacion de la red');

% ACTIVAR SOLO UNA DE LAS SIGUIENTES OPCIONES
% SI ESTAMOS SIMULANDO PARA OBTENER LAS QUEMADURAS
save Quemaduras imagenSalida;

% SI ESTAMOS SIIMULANDO PARA OBTENER LAS MANCHAS DE COLA
%  = iimagenSalida2magenSalida;
% save ManchasDeCola imagenSalida2;