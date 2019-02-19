% Dibuja cuadrados blancos alrededor de cada centro de cada patron
function [imagen] = dibujaCuadro(imagen_entrada, centro, dim)

imagen=imagen_entrada;

valor=floor(dim/2);
% Linea de arriba
i=centro(1)-valor;
for j=centro(2)-valor:centro(2)+valor,
    imagen(i,j)=255;
end

% Linea de abajo
i=centro(1)+valor;
for j=centro(2)-valor:centro(2)+valor,
    imagen(i,j)=255;
end

% Linea de izquierda
j=centro(2)-valor;
for i=centro(1)-valor:centro(1)+valor,
    imagen(i,j)=255;
end

% Linea de derecha
j=centro(2)+valor;
for i=centro(1)-valor:centro(1)+valor,
    imagen(i,j)=255;
end
