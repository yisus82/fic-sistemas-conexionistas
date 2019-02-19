function imagen = subclases(imagen,clases0,clases1)
    [f,c]=size(imagen);
    intervalo = floor(clases0/clases1);
    inferior = 0;
    superior = intervalo;
    for k = 1:clases1,
        for i=2:f-1,
            for j=2:c-1,
                if (inferior<imagen(i,j)<superior),
                    imagen(i,j) = inferior;
                end;
            end;
        end;
        inferior = superior;
        superior = superior + intervalo;
    end;