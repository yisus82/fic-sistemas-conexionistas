%-------------------------------------------------------
%   PRACTICA 3 - Sistemas Conexionistas - Curso 04/05
%   Alumno: Marcos Martinez Romero (infmmr01)
%-------------------------------------------------------
clear all;
close all;

% Inicializacion de variables

img_entrenar = 'p3sc.bmp'; tipo_entrenar='bmp';
img_salida='p3sc.bmp'; tipo_salida='bmp';

dim=3; %Dimension de la ventana sobre la cual se calculara el nivel medio de gris

% MENU PRINCIPAL
opcion=0;
while (opcion~=4)
    
    fprintf('\n\n  S.C. - Practica 3 - Clasificacion con SOM\n');
    fprintf('-----------------------------------------------\n');
    fprintf('  1. Clasificar en funcion del nivel medio de gris de ventana 3x3.\n');
    fprintf('  2. Clasificar cada punto en funcion de sus dos coordenadas\n');
    fprintf('  3. Clasificar cada punto en funcion de su nivel de gris\n');
    fprintf('  4. Salir\n');
    opcion=input('Opcion: ');
    
    if (opcion<4)
        
        [img,mapa]=leeImagen(img_entrenar,tipo_entrenar);
        figure;
        image(img); % Visualizacion de la imagen
        colormap(mapa); % Establezco el mapa de color de la figura
        
        
        tam = size(img); dimimgX = tam(1); dimimgY = tam(2); %Dimensiones de la imagen
        P=[];
        paso=10;
        i=1+paso;
        imagen=img;
        while i<dimimgX,
            j=1+paso;
            while j<dimimgY,
                if (opcion==1)
                    Puntos = calculaEntrada(img, mapa, dim, i, j); %Puntos de la ventana centrada en i,j
                    valorMedio = floor(sum(Puntos) / length(Puntos)); %Valor medio de gris de la ventana
                    P=[P valorMedio];
                    
                elseif(opcion==2)
                    P=[P; i j];
                    
                elseif(opcion==3)
                    P=[P img(i,j)]; % Eleccion del nivel de gris de un punto determinado
                    
                end
                
                imagen=dibujaCuadro(imagen,[i j],dim);
                j=j+paso;
              
                
            end
            i=i+paso;
              paso=paso*2;
        end
        P=double(P); %Hacemos la traspuesta y pasamos a doble precision para que no de error
        
        if (opcion==1)
            red=newsom([0 255],[4 4]);
        elseif(opcion==2)
            red=newsom([0 dimimgX; 0 dimimgY],[4 4],'gridtop'); P=P';  %por defecto hextop, tambien hay gridtop y randtop
        elseif(opcion==3)
            red=newsom([0 255],[4 4]);
        end
        
        if (opcion==2)
            hold on;
            plotsom(red.IW{1,1},red.layers{1}.distances) % Representacion del mapa
            hold off;
        else end
        
        
        red.trainParam.epochs=200;
        red=train(red,P);
        
        
        %Visualizacion de los patrones usados para entrenar
        figure;
        image(imagen); % Visualizacion de la imagen
        colormap(mapa); % Establezco el mapa de color de la figura
        title('Patrones utilizados en el entrenamiento');
        %--------------------------
        
        
        
        
        extremo=(floor(dim/2));
        clases = [];
        color=1;
        for i=1+extremo:tam(1)-extremo,
            for j=1+extremo:tam(2)-extremo,
                
                if (opcion==1)
                    Puntos = calculaEntrada(img, mapa, dim, i, j); %Puntos de la ventana centrada en i,j
                    entrada = floor(sum(Puntos) / length(Puntos)); %Valor medio de gris de la ventana      
                    
                elseif(opcion==2)
                    entrada=[i;j];
                    
                elseif(opcion==3)
                    entrada=double(img(i,j));
                end
                
                
                salida = sim(red,entrada); %Obtenemos la salida de la red para ese punto
                clase = cualSeActiva(salida); %Obtencion de la clase a la que pertenece ese punto (o es la ventana entera??)
                
                esta = estaEn(clase, clases);
                if (esta==0) % Esa clase no esta, la agregamos
                    clases = [clases; clase tablaColores(color)];
                    color=color+1;
                end
                
                for z=1:length(clases),
                    if (clase==clases(z))
                        imgsalida(i-extremo,j-extremo,:)=uint8(clases(z,2:4)); % Coloreamos el punto segun la clase a la que pertenece
                    end
                end
                
            end
        end
        
        imwrite(imgsalida,img_salida,tipo_salida); % Escritura de la imagen de salida
        
        [img2,mapa2]=imread(img_salida,tipo_salida); % Lectura de la imagen de salida
        figure;
        image(img2); % Visualizacion de la imagen de salida
        colormap(mapa2); % Establezco el mapa de color de la figura de salida
        
        if (opcion==2)
            hold on;
            plotsom(red.IW{1,1},(red.layers{1}.distances)) % Representacion del mapa
            %view(90,90)
            hold off;
        else end
        
        
    else %opcion>=4
        opcion=4;
        
    end %del if
    
end %del while