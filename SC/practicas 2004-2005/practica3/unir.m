function C = unir(C,a,b)
    [f,c] = size(C);
    i = min(C(a),C(b));
    j = max(C(a),C(b));
    for k = 1:c,
        if (C(k) == j),
            C(k) = i;
        end;
    end;