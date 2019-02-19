% SIMULACION
conjunto_de_prueba = [];
imagen_salida = [];
imagen_salida_clases_finales=[];
if (dimensionalidad == 2) tamanho_red = eps1 * eps2;
else tamanho_red = eps1;
end;



if (clasificacion == 1)
    patrones_som_2 = SOM.IW{1, 1}';
    rango = minmax(patrones_som_2);
    SOM_2 = newsom([0 255], [1 numero_de_clases], 'gridtop', 'dist');
    SOM_2.trainParam.epochs = 250;
    SOM_2 = init(SOM_2);
    SOM_2 = train(SOM_2, patrones_som_2);
    for i = 1:alto
        for j = 1:ancho
            patron_prueba = double(imagen(i, j));
            resultado = sim(SOM, patron_prueba); %clasifica en tantas clases como pe's en la capa de salida
            resultado_clases_finales = sim(SOM_2, patron_prueba); %clasifica en tantas clases como superclases indique el usuario
            elemento_activo = find(resultado == 1);
            imagen_salida(i, j) = SOM.IW{1, 1}(elemento_activo);
            elemento_activo_finales=find(resultado_clases_finales==1);
            imagen_salida_clases_finales(i, j) = SOM_2.IW{1, 1}(elemento_activo_finales);
        end;
    end;
    
else
   patrones_som_2 = SOM.IW{1, 1}';
%    rango = minmax(patrones_som_2);
   SOM_2 = newsom([1 ancho; 1 alto], [1 numero_de_clases], 'gridtop', 'dist');
   SOM_2.trainParam.epochs = 250;
   SOM_2 = init(SOM_2);
   SOM_2 = train(SOM_2, patrones_som_2);
   for i = 1:alto
        for j = 1:ancho
            patron_prueba = [j; i];
            resultado = sim(SOM, patron_prueba);
            resultado_clases_finales = sim(SOM_2, patron_prueba);
            elemento_activo = find(resultado == 1);
            elemento_activo_clases_finales = find (resultado_clases_finales == 1);
            imagen_salida(j, i) = SOM.IW{1, 1}(elemento_activo);
            imagen_salida_clases_finales(j, i) = SOM_2.IW{1, 1}(elemento_activo_clases_finales);

        end;
    end;
end;

figure;
imagesc(imagen_salida);
title('Imagen Intermedia');
colormap(gray);
figure;
imagesc(imagen_salida_clases_finales);
title('Imagen tras pasarle el segundo SOM para clasificar en subclases');
colormap(gray);

