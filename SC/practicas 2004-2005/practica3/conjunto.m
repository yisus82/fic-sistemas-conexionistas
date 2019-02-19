function T = conjunto(M)
    [f,c] = size(M);
    for k = 1:f,
        C = [k];
        for i = k-1:-1:1,
            if (M(k,i) == Inf),
                C = [C i];
            end;
        end;
        for j = k+1:f,
            if (M(j,k) == Inf),
                C = [C j];
            end;
        end;
        C = sort(C);
        T{k} = C;
    end;        