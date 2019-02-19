switch clasificacion
        
        case(1)
            
            centros = net.IW{1};
            distancias = [];
            for i = 1:num_PEs,
                distancias(i,i) = Inf;
                for j = i+1:num_PEs,
                    distancias(j,i) = abs(centros(i)-centros(j));
                    distancias(i,j) = Inf;
                end;
            end;
            
        case(2)
            
            centros = net.IW{1};
            distancias = [];
            for i = 1:num_PEs,
                distancias(i,i) = Inf;
                for j = i+1:num_PEs,
                    distancias(j,i) = sqrt((centros(i,1)-centros(j,1))^2 + (centros(i,2)-centros(j,2))^2);
                    distancias(i,j) = Inf;
                end;
            end;
            
    end;