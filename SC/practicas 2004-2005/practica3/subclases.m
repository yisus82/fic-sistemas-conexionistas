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
            figure(1);
            image(imagen_color);
            
        case(2)
            imagen_color = zeros(f,c);
            for i = 2:f-1,
                for j = 2:c-1,
                    salida = find(sim(net,[i;j]));
                    imagen_color(j,i) = salida*floor(64/num_PEs);
                end;
            end;
            figure(1);
            image(imagen_color);
            hold on;
            plotsom(net.iw{1,1},net.layers{1}.distances);
            hold off;
            
    end;
    
    

%   Obtencion de la imagen definitiva con subclases de la anterior:
%   ---------------------------------------------------------------
    imagen_final = [];
    
    switch clasificacion
        
        case(1)
            
            for i = 2:f-1,
                for j = 2:c-1,
                    salida = find(sim(net,media_gris(imagen(i-1:i+1,j-1:j+1))));
                    imagen_final(j,i) = obtener_clase(clases,salida)*floor(64/num_PEs);
                end;
            end;
            
        case(2)
            
            for i = 2:f-1,
                for j = 2:c-1,
                    salida = find(sim(net,[i;j]));
                    imagen_final(j,i) = obtener_clase(clases,salida)*floor(64/num_PEs);
                end;
            end;
            
    end;
    
    figure(2);
    image(imagen_final);
    hold on;
    plotsom(net.iw{1,1},net.layers{1}.distances);
    hold off;