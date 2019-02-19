% funcion para ver si un elemento esta en un conjunto o no
function [esta] = estaEn(elemento, conjunto)

esta=0;
tamano=length(conjunto);

for i=1:tamano,
    if (elemento==conjunto(i))
        esta=1;
    end
end
