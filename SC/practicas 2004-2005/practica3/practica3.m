clear all;
close all;
disp('PRACTICA 3 - SOM');

%   Imagen de entrada:
%   ------------------
imagen = imread('image','JPG');
imagen = double(imagen(:,:,1));
[f,c] = size(imagen);

%   Seleccion de opciones de clasificacion y distribucion:
%   ------------------------------------------------------
    disp('1.- Clasificacion por escala de gris');
    disp('2.- Clasificacion por posicion');
    clasificacion = input('Tipo de clasificacion?');
    disp('1.- Distribucion uniforme');
    disp('2.- Distribucion no uniforme');
    distribucion = input('Tipo de distribucion?');

%   Seleccion de SOM:
%   -----------------
    disp('1.- Espacio de salidas unidimensional');
    disp('2.- Espacio de salidas bidimensional');
    dimension = input('Tipo de espacio de salidas?');
    
    switch dimension
        case(1)
            n = input('Numero de PEs?'); 
            num_PEs = n;
            switch clasificacion
                case(1)
                    net = newsom([0,255],[n],'gridtop');
                case(2)
                    net = newsom([2,(f-1);2,(c-1)],[n],'gridtop');
            end;
        case(2)
            n = input('Numero de filas de PEs?');
            m = input('Numero de columnas de PEs?');
            num_PEs = n*m;
            switch clasificacion
                case(1)
                    net = newsom([0,255],[n,m],'gridtop');
                case(2)
                    net = newsom([2,(f-1);2,(c-1)],[n,m],'gridtop');
            end;
    end;

%   Obtencion de patrones de entrada:
%   ---------------------------------
    pat = patrones_entrenamiento(imagen,clasificacion,distribucion); 

    switch clasificacion
        case(1)
            figure;          
            gris = zeros(50,255);
            for i = 1:255,
                gris(:,i) = i;
            end;            
            color_gris(:,:,1) = gris;
            color_gris(:,:,2) = gris;
            color_gris(:,:,3) = gris;
            color_gris = uint8(color_gris);
            image(color_gris);
            hold on;
            plot(pat(1,:),25,'.g','markersize',20);
            hold off;
        case(2)
            figure;            
            plot(pat(1,:),pat(2,:),'.g','markersize',20);    
        end;
        
%   Entrenamiento SOM:
%   ------------------
    net.trainFcn = 'trainwb1';
    net.trainParam.epochs = 5000;
    net = train(net,pat); 
    hold on;
    plotsom(net.iw{1,1},net.layers{1}.distances)
    hold off;    
    
%   Obtencion imagen en color con clases iniciales:
%   -----------------------------------------------
    switch clasificacion
        
        case(1)
            
            imagen_color = zeros(f,c);
            for i = 2:f-1,
                for j = 2:c-1,
                    salida = find(sim(net,media_gris(imagen(i-1:i+1,j-1:j+1))));
                    imagen_color(i,j) = salida*floor(64/num_PEs);
                end;
            end;
            figure;
            image(imagen_color);
            
        case(2)
            imagen_color = zeros(f,c);
            for i = 2:f-1,
                for j = 2:c-1,
                    salida = find(sim(net,[i;j]));
                    imagen_color(j,i) = salida*floor(64/num_PEs);
                end;
            end;
            figure;
            image(imagen_color);
            hold on;
            plotsom(net.iw{1,1},net.layers{1}.distances);
            hold off;
            
    end;
    
%   Obtencion de tabla con distancias entre PEs:
%   --------------------------------------------
    distancias = dist((net.IW{1})');
    for i = 1:num_PEs,
        for j = 1:i,
            distancias(j,i) = Inf;
        end;
    end;
    
%   Obtencion de subclases:
%   -----------------------    
    clases = [];
    for i = 1:num_PEs,
        clases(i) = i;
    end;
    
    clases_actuales = size(clases);
    subclases = input('Numero de clases finales?');        
    
    while not (clases_actuales(2) == subclases),
        [i,j] = localiza_minimo(distancias);
        distancias(i,j) = Inf;
        clases = unir(clases,i,j);
        clases_actuales = size(unique(clases));
    end;
    
%   Obtencion de la imagen definitiva con subclases de la anterior:
%   ---------------------------------------------------------------    
    imagen_final = [];
    
    switch clasificacion
        
        case(1)
            
            for i = 2:f-1,
                for j = 2:c-1,
                    salida = find(sim(net,media_gris(imagen(i-1:i+1,j-1:j+1))));
                    imagen_final(i,j) = clases(salida)*floor(64/num_PEs);
                end;
            end;
            
        case(2)
            
            for i = 2:f-1,
                for j = 2:c-1,
                    salida = find(sim(net,[i;j]));
                    imagen_final(j,i) = clases(salida)*floor(64/num_PEs);
                end;
            end;
            
    end;
    
    figure;
    image(imagen_final);
    
    if (clasificacion == 2),
    hold on;
    plotsom(net.iw{1,1},net.layers{1}.distances);
    hold off;
    end;