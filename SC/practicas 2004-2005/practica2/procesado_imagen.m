clear all;
close all;

%   Cargar red:
load red;

ventana = 7;
lado = (ventana-1)/2;

%   Crear variable para imagen
imagen = imread('image01','BMP');
imagen = double(imagen);

%   Procesado de la imagen y obtencion de la misma en blanco y negro
tam_im = size(imagen);
imagen_salida = zeros(tam_im);
for i = (lado+1):(tam_im(1)-lado),
    for j = (lado+1):(tam_im(2)-lado),        
        v = [];
        for k = -lado:lado,
            v = [v; imagen((i-lado):(i+lado),j+k)];        
        end;
        imagen_salida(i,j,:) = sim(net,v);
    end;
end;
imagen_salida = uint8(imagen_salida.*255);

%   Imagen tratada
image(imagen_salida);