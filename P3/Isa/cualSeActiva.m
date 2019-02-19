% devuelve el EP  que se pone a uno al presentarle una entrada a la red
function [cual] = cualSeActiva(elementos)

tamano = length(elementos);

for i=1:tamano,
    if (elementos(i)==1)
        cual=i;
    end
end
