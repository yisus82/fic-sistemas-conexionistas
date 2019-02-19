function validar(imagen, tipo, margen, red, precision)

% Leemos la imagen
[matriz_imagen mapa_color] = imread(imagen,tipo);
[alto, ancho, profundidad] = size(matriz_imagen);

% Dibujamos la imagen
figure;
image(matriz_imagen);
colormap(mapa_color);
title('Imagen de prueba');

conjunto_de_prueba = [];
for i = (margen + 1):(alto - margen),
    for j = (margen + 1):(ancho - margen),
    	ventana = matriz_imagen((i - margen):(i + margen), (j - margen):(j + margen));
        conjunto_de_prueba = [conjunto_de_prueba ventana(:)]; 
    end
end   
conjunto_de_prueba = double(conjunto_de_prueba);

salida_obtenida = sim(red, conjunto_de_prueba);

imagen_obtenida = [];
k = 1;
for i = (margen + 1):(alto - margen),
    for j = (margen + 1):(ancho - margen),
        if (salida_obtenida(k) >= precision) imagen_obtenida((i - margen):(i + margen), (j - margen):(j + margen)) = 1;
            else  imagen_obtenida((i - margen):(i + margen), (j - margen):(j + margen)) = 2;
        end;
        k = k + 1;
    end
end    

mapa_color_salida = [1 1 1; 0 0 0];

% Dibujamos la imagen obtenida
figure;
image(imagen_obtenida);
colormap(mapa_color_salida);
title('Imagen obtenida ');
