function v = obtener_patron(imagen,i,j)
    v = [];
    for k = -1:1,
        v = [v; imagen((i-1):(i+1),j+k)];
    end;