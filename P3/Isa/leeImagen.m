function [img, mapa] = leeImagen(nombre, tipo)
% Objetivo: devolver la imagen y el mapa de color en escala de grises
% Entrada:
%   nombre: imagen que se desea leer
%   tipo: extension de la imagen
% Salida:
%   img: array de dos dimensiones que contiene la imagen (en escala de grises)
%   mapa: mapa de color de la imagen (escala de grises)

info = imfinfo(nombre);

[img,mapa]=imread(nombre,tipo);

if ((info.BitDepth~=8)|(info.ColorType~='indexed')) % la imagen no esta en escala de grises, hay que convertirla
    imggrises=img(:,:,1);
    imwrite(imggrises,'imagegrises.bmp','bmp');
    [img,mapa]=imread('imagegrises.bmp','bmp');
    
end