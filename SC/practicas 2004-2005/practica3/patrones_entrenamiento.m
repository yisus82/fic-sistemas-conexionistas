function patrones = patrones_entrenamiento(imagen,clasificacion,distribucion)

    [f,c] = size(imagen);
    num_pat = 250;

    switch clasificacion

    case(1)

    %   Seleccion patrones entrenamiento para clasificacion por escala de gris

        switch distribucion

        case(1)
    
        %   Seleccion patrones entrenamiento con distribucion uniforme
            patrones = [];
            for k = 1:num_pat,
                i = floor(rand*(f-3)) + 2;
                j = floor(rand*(c-3)) + 2;
                patrones = [patrones,media_gris(imagen(i-1:i+1,j-1:j+1))];
            end;
    
        case(2)
        
        %   Selecion de patrones entrenamiento con distribucion no uniforme
            patrones = [];
            for k = 1:floor(num_pat/2),
                i = floor(rand*(floor((f/4)-3))+2);
                j = floor(rand*(floor((c/4)-3))+2);
                patrones = [patrones,media_gris(imagen(i-1:i+1,j-1:j+1))];
            end;
            
            for k = 1:floor(num_pat/2),
                i = floor(rand*(f-3)) + 2;
                j = floor(rand*(c-3)) + 2;
                patrones = [patrones,media_gris(imagen(i-1:i+1,j-1:j+1))];
            end;

        end;
        
    case(2)
        
    %   Seleccion patrones entrenamiento para clasificacion por posicion

        switch distribucion
    
        case(1)
    
        %   Seleccion patrones entrenamiento con distribucion uniforme
            patrones = [];
            for k = 1:num_pat,
                i = floor(rand*(f-1)) + 1;
                j = floor(rand*(c-1)) + 1;
                patrones = [patrones,[i;j]];
            end;
    
        case(2)
        
        %   Selecion de patrones entrenamiento con distribucion no uniforme
            patrones = [];
            for k = 1:floor(num_pat/2),
                i = floor(rand*(floor((f/4)-1))+1);
                j = floor(rand*(floor((c/4)-1))+1);
                patrones = [patrones,[i;j]];
            end;
            
            for k = 1:floor(num_pat/2),
                i = floor(rand*(f-1)) + 1;
                j = floor(rand*(c-1)) + 1;
                patrones = [patrones,[i;j]];
            end;
        
        end;
        
    end; 