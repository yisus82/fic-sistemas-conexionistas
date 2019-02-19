function validar(imagen, tipo, margenX, margenY, red, precision)

% Leemos la imagen
[matriz_imagen mapa_color] = imread(imagen,tipo);
[alto, ancho, profundidad] = size(matriz_imagen);

% Dibujamos la imagen
figure;
imagesc(matriz_imagen);
colormap(mapa_color);
title('Imagen de prueba');

conjunto_de_prueba = [];
for i = (margenX + 1):(alto - margenX),
    for j = (margenY + 1):(ancho - margenY),
    	ventana = matriz_imagen((i - margenX):(i + margenX), (j - margenY):(j + margenY));
        conjunto_de_prueba = [conjunto_de_prueba ventana(:)]; 
    end
end   
conjunto_de_prueba = double(conjunto_de_prueba);

% Normalizamos el conjunto de prueba
conjunto_de_prueba = conjunto_de_prueba / 255;

salida_obtenida = sim(red, conjunto_de_prueba);

imagen_obtenida = [];
k = 1;
for i = (margenX + 1):(alto - margenX),
    for j = (margenY + 1):(ancho - margenY),
        if (salida_obtenida(k) >= precision) imagen_obtenida((i - margenX):(i + margenX), (j - margenY):(j + margenY)) = 1;
            else  imagen_obtenida((i - margenX):(i + margenX), (j - margenY):(j + margenY)) = 2;
        end;
        k = k + 1;
    end
end    

mapa_color_salida = [1 1 1; 0 0 0];

% Dibujamos la imagen obtenida
figure;
imagesc(imagen_obtenida);
colormap(mapa_color_salida);
title('Imagen obtenida ');

% Guardamos la imagen obtenida
save imagen imagen_obtenida;