function [x,y] = localiza_minimo(M)

    [f,c] = size(M);
    minimo = Inf;
    for i = 1:f,
        for j = 1:c,
            if (M(i,j)<minimo),
                minimo = M(i,j);
                x = i;
                y = j;
            end;
        end;
    end;            