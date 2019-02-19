function validar(imagen, tipo, margenX, margenY, red_entrenada1, red_entrenada2)

% Leemos la imagen
[matriz_imagen mapa_color] = imread(imagen,tipo);
[alto, ancho, profundidad] = size(matriz_imagen);

precision = 0.9;

% Dibujamos la imagen
figure;
imagesc(matriz_imagen);
colormap(mapa_color);
title('Imagen de prueba');

% Generamos el conjunto de prueba
conjunto_de_prueba = [];
for i = (margenX + 1):(alto - margenX),
    for j = (margenY + 1):(ancho - margenY),
    	ventana = matriz_imagen((i - margenX):(i + margenX), (j - margenY):(j + margenY));
        %nivel_medio_de_gris = mean(ventana(:));
        conjunto_de_prueba = [conjunto_de_prueba ventana(:)]; 
    end
end   
conjunto_de_prueba = double(conjunto_de_prueba);

% Normalizamos el conjunto de prueba
conjunto_de_prueba = conjunto_de_prueba / 255;

% Simulamos para obtener una imagen

% PRIMERA RED: Manchas de cola

salida_obtenida = sim(red_entrenada1, conjunto_de_prueba);

imagen_obtenida = [];
k = 1;
for i = (margenX + 1):(alto - margenX),
    for j = (margenY + 1):(ancho - margenY),
         if (salida_obtenida(k) > precision) imagen_obtenida((i - margenX):(i + margenX), (j - margenY):(j + margenY)) = 2;
              else imagen_obtenida((i - margenX):(i + margenX), (j - margenY):(j + margenY)) = 1;
              end
          %imagen_obtenida((i - margen):(i + margen), (j - margen):(j + margen)) = salida_obtenida(k)
          k = k + 1;
    end
end    

% Ajustamos la imagen obtenida a las dimensiones que debe tener la salida
salida = [];
for i = (margenX + 1):(alto - margenX),
    for j = (margenY + 1):(ancho - margenY),
        salida(i - margenX, j - margenY) = imagen_obtenida(i - margenX, j - margenY);
    end
end

mapa_color_salida = [0 0 0; 0.5 0.5 0.5; 1 1 1];

% Dibujamos la salida
figure;
imagesc(salida);
colormap(mapa_color_salida);
title('Salida de la primera red');

% SEGUNDA RED: Manchas de secado

salida_obtenida = sim(red_entrenada2, conjunto_de_prueba);

k = 1;
for i = (margenX + 1):(alto - margenX),
    for j = (margenY + 1):(ancho - margenY),
         if (salida_obtenida(k) > precision) imagen_obtenida(i,j) = 3;
         end;
          %imagen_obtenida((i - margen):(i + margen), (j - margen):(j + margen)) = salida_obtenida(k)
          k = k + 1;
    end
end    

% Ajustamos la imagen obtenida a las dimensiones que debe tener la salida
salida = [];
for i = (margenX + 1):(alto - margenX),
    for j = (margenY + 1):(ancho - margenY),
        salida(i - margenX, j - margenY) = imagen_obtenida(i - margenX, j - margenY);
    end
end

mapa_color_salida = [0 0 0; 0.5 0.5 0.5; 1 1 1];

% Dibujamos la salida
figure;
imagesc(salida);
colormap(mapa_color_salida);
title('Salida final');
