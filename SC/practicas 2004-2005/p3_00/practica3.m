clear all;
close all;

imagen = imread('image','JPG');
imagen = double(imagen(:,:,1));
[f,c] = size(imagen);

%   opcion:
%   1.- Clasificacion por escala de gris
%   2.- Clasificacion por posicion
opcion = 2; 

capas = [4,4];
num_PEs = 16;

switch opcion
    
    case (1)

    %   Clasificacion por escala de gris
        rangos = [0,255];
        net = newsom(rangos,capas,'gridtop');

        %   Obtener patrones para entrenamiento
            Patrones = [];
            for i = 2:10:f,
                for j = 2:10:c,                
                    Patrones = [Patrones,obtener_patron(imagen,i,j)];
                end;
            end;
        
        %   Entrenamiento de la red
            net.trainParam.epochs = 100;
            net = train(net,Patrones);            
        
        %   Procesado de la imagen
            imagen_salida = zeros(f,c);
            for i = 2:(f-1),
                for j = 2:(c-1),
                    Out = sim(net,obtener_patron(imagen,i,j));
                    imagen_salida(i,j) = neurona_activa(Out)*(floor(64/num_PEs));
                end;
            end;
        
        %   Imagenes
            figure(1);
            image(imagen_salida);
     
    case (2)
        
    %   Clasificacion por posicion
        rangos(1,:) = [1,f];
        rangos(2,:) = [1,c];
        net = newsom(rangos,capas,'gridtop');
        
        %   Obtener patrones para entrenamiento
            Patrones = [];
            for i = 2:10:f,
                for j = 2:10:c,                
                    Patrones = [Patrones,[i;j]];
                end;
            end;
        
        %   Entrenamiento de la red
            net.trainParam.epochs = 100;
            net = train(net,Patrones);            
            
        %   Procesado de la imagen
            imagen_salida = zeros(f,c);
            for i = 2:(f-1),
                for j = 2:(c-1),
                    Out = sim(net,[i;j]);
                    imagen_salida(i,j) = neurona_activa(Out)*(floor(64/num_PEs));
                end;
            end;
        
        %   Imagenes
            figure(1);
            image(imagen_salida);                              
           
end;

%   Obtencion de imagen definitiva con n clases
subclases = 0;
if (subclases == 1),
    clases = 2;
    intervalo = floor(64/clases);
    inferior = 0;
    superior = intervalo;
    for k = 1:clases,
        for i=2:f-1,
            for j=2:c-1,
                if ((inferior<=imagen_salida(i,j)) & (imagen_salida(i,j)<superior)),
                    imagen_salida(i,j) = floor((inferior+superior)/2);
                end;
            end;
        end;
        inferior = superior;
        superior = superior + intervalo;
    end;

%   Obtencion de la imagen final
    figure(2);
    image(imagen_salida);
end;