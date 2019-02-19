%   Obtencion de imagen definitiva con n clases
subclases = 0;
if (subclases == 1),
    clases = 2;
    intervalo = floor(64/clases);
    inferior = 0;
    superior = intervalo;
    for k = 1:clases,
        for i=2:f-1,
            for j=2:c-1,
                if ((inferior<=imagen_salida(i,j)) & (imagen_salida(i,j)<superior)),
                    imagen_salida(i,j) = floor((inferior+superior)/2);
                end;
            end;
        end;
        inferior = superior;
        superior = superior + intervalo;
    end;

%   Obtencion de la imagen final
    figure(2);
    image(imagen_salida);
end;