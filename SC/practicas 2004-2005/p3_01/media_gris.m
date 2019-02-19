function n = media_gris(M)
    sum = 0;
    for i = 1:3,
        for j = 1:3,
            sum = sum + M(i,j);
        end;
    end;
    n = floor(sum/9);