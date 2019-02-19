function M = union_subconjuntos(M)
    [f,c] = size(M);
    for i = 1:c-1,
        for j = i+1:c,
            if (size(intersect(M{i},M{j})) ~= 0),
                M{i} = union(M{i},M{j});
                M{j} = [];
            end;
        end;
    end;