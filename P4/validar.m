function validar(imagen, tipo, margen, red_entrenada)

% Leemos la imagen
[matriz_imagen mapa_color] = imread(imagen,tipo);
[alto, ancho, profundidad] = size(matriz_imagen);

% Dibujamos la imagen
figure;
image(matriz_imagen);
colormap(mapa_color);
title('Imagen de prueba');

% Generamos el conjunto de prueba
conjunto_de_prueba = [];
for i = (margen + 1):(alto - margen),
    for j = (margen + 1):(ancho - margen),
    	ventana = matriz_imagen((i - margen):(i + margen), (j - margen):(j + margen));
        nivel_medio_de_gris = mean(ventana(:));
        conjunto_de_prueba = [conjunto_de_prueba nivel_medio_de_gris]; 
    end
end   
conjunto_de_prueba = double(conjunto_de_prueba);

% Simulamos para obtener una imagen
salida_obtenida = sim(red_entrenada, conjunto_de_prueba);

imagen_obtenida = [];
k = 1;
for i = (margen + 1):(alto - margen),
    for j = (margen + 1):(ancho - margen),
%         if (salida_obtenida(k) > 0.5) imagen_obtenida((i - margen):(i + margen), (j - margen):(j + margen)) = 3;
%         else if (salida_obtenida(k) > 0) imagen_obtenida((i - margen):(i + margen), (j - margen):(j + margen)) = 2;
%             else imagen_obtenida((i - margen):(i + margen), (j - margen):(j + margen)) = 1;
%             end
%         end;
        if (salida_obtenida(k) > 1.7) imagen_obtenida(i,j) = 3;
        else if (salida_obtenida(k) > 0.5) imagen_obtenida(i, j) = 2;
            else imagen_obtenida(i, j) = 1;
            end
        end;
        %imagen_obtenida((i - margen):(i + margen), (j - margen):(j + margen)) = salida_obtenida(k);
        k = k + 1;
    end
end    

% Ajustamos la imagen obtenida a las dimensiones que debe tener la salida
salida = [];
for i = (margen + 1):(alto - margen),
    for j = (margen + 1):(ancho - margen),
        salida(i-margen,j-margen) = imagen_obtenida(i-margen,j-margen);
    end
end

mapa_color_salida = [0 0 0; 0.5 0.5 0.5; 1 1 1];

% Dibujamos la salida
figure;
%image(salida);
image(imagen_obtenida);
%colormap(gray);
colormap(mapa_color_salida);
title('Imagen obtenida ');