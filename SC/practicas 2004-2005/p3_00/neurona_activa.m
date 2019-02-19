function n = neurona_activa(M)
    n = 1;
    while (M(n,1) ~= 1),
        n = n+1;
    end;