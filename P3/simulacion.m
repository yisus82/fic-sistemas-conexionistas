conjunto_de_prueba = [];
imagen_salida = [];
imagen_salida_clases_finales=[];
if (dimensionalidad == 2) tamanho_red = eps1 * eps2;
    else tamanho_red = eps1;
end;

% Clasificacion por tonos de grises
if (clasificacion == 1)
    patrones_som_2 = SOM.IW{1, 1}';
    SOM_2 = newsom([0 255], [1 numero_de_clases], 'gridtop', 'dist');
    SOM_2.trainParam.epochs = 250;
    SOM_2 = init(SOM_2);
    SOM_2 = train(SOM_2, patrones_som_2);
    for i = 1:alto
        for j = 1:ancho
            patron_prueba = double(imagen(i, j));
            resultado_clases_finales = sim(SOM_2, patron_prueba); 
            elemento_activo_finales=find(resultado_clases_finales==1);
            imagen_salida_clases_finales(i, j) = SOM_2.IW{1, 1}(elemento_activo_finales);
        end;
    end;
% Clasificacion por coordenadas    
else
   patrones_som_2 = SOM.IW{1, 1}';
   SOM_2 = newsom([1 ancho; 1 alto], [1 numero_de_clases], 'gridtop', 'dist');
   SOM_2.trainParam.epochs = 250;
   SOM_2 = init(SOM_2);
   SOM_2 = train(SOM_2, patrones_som_2);
   for i = 1:alto
        for j = 1:ancho
            patron_prueba = [j; i];
            resultado_clases_finales = sim(SOM_2, patron_prueba);
            elemento_activo_clases_finales = find (resultado_clases_finales == 1);
            imagen_salida_clases_finales(j, i) = SOM_2.IW{1, 1}(elemento_activo_clases_finales);
        end;
    end;
end;

% Mostramos la imagen de salida
figure;
imagesc(imagen_salida_clases_finales);
title('Imagen clasificada en superclases');
%colormap(gray);
