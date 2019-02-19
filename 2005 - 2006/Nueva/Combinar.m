close all;
clear all;
clc;

load Quemaduras;
load ManchasDeCola;

[alto ancho] = size(imagenSalida);

for i = 1:alto,
    for j = 1:ancho,
        if ((imagenSalida(i, j) == 255) || (imagenSalida2(i, j) == 255)) salida(i, j) = 255;
        else salida(i, j) = 0;
        end;
    end
end;

imagesc(salida);
colormap(gray);