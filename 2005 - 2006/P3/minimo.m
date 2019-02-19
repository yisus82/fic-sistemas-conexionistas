function [x] = minimo(vector, posicion)
    [fila, columna] = size(vector);
    min = Inf;
    for i = 1:fila
        if (vector(i, posicion) < min)
            min = vector(i, posicion);
            x = i;
        end
    end     