function [x] = localiza_minimo(M,pos)

    [f,c] = size(M);
    minimo = Inf;
    for i = 1:f
        if (M(i,pos)<minimo)
            minimo = M(i,pos);
            x = i;
        end
    end     