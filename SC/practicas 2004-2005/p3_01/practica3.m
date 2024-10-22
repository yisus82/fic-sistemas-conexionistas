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
                    Patrones = [Patrones,media_gris(obtener_patron(imagen,i,j))];
                end;
            end;
        
        %   Entrenamiento de la red
            net.trainParam.epochs = 100;
            [net,tr,Y] = train(net,Patrones);
        
        %   Agrupar en subclases
%            clases_finales = [5];
%            [ganadores,salida] = find(Y);
%            ganadores = ganadores';
%            netaux = newsom([1,25],clases_finales,'gridtop');
%            netaux = train(netaux,ganadores);
            
        %   Procesado de la imagen
%            imagen_salida = zeros(f,c);
%            for i = 2:(f-1),
%                for j = 2:(c-1),
%                    Out1 = find(sim(net,media_gris(obtener_patron(imagen,i,j))));
%                    Out2 = find(sim(netaux,Out1));
%                    imagen_salida1(i,j) = Out1*(floor(64/num_PEs));
%                    imagen_salida2(i,j) = Out2*(floor(64/clases_finales));
%                end;
%            end;
        
        %   Imagenes
%            figure(1);
%            image(imagen_salida1);
%            figure(2);
%            image(imagen_salida2);
     
    case (2)
        
    %   Clasificacion por posicion
        rangos(1,:) = [1,f];
        rangos(2,:) = [1,c];
        net0 = newsom(rangos,capas,'gridtop');
        
        %   Obtener patrones para entrenamiento
            Patrones = [];
            for i = 2:10:f,
                for j = 2:10:c,                
                    Patrones = [Patrones,[i;j]];
                end;
            end;
        
        %   Entrenamiento de la red
            net0.trainParam.epochs = 100;
            [net0,tr,Y] = train(net0,Patrones);            
            
            subclases = [5];
            [ganadores,salidas] = find(Y);
            net1 = newsom([1,16],subclases,'gridtop');
            net1 = train(net1,ganadores');
            
        %   Procesado de la imagen
            paleta = [0,4,12,24,8,16,28,40,20,32,44,52,36,48,56,60];
            imagen_salida = zeros(f,c);
            for i = 2:(f-1),
                for j = 2:(c-1),
                    out0 = find(sim(net0,[i;j]));
                    out1 = find(sim(net1,out0));
                    imagen_salida0(i,j) = paleta(out0);
                    imagen_salida1(i,j) = out1*floor(64/subclases);
                end;
            end;
        
        %   Imagenes
            figure(1);
            image(imagen_salida0);  
            figure(2);
            image(imagen_salida1);
           
end;