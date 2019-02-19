close all;
clear all;

%en A se guarda la imagen asociada al fichero y en B el mapa de colores
[Imagen,mapa_colores]=imread('image01','bmp');
colormap(mapa_colores);
image(Imagen);
[filas,columnas]=size(Imagen);
X=[];
Y=[];
Z=[]; %boton izquierdo (1) ---> carreteras //// boton derecho (3) ---> campos
muestras=10;
tamanho_ventana=5;
patrones=[];
salida_deseada=[];
margen = floor(tamanho_ventana/2);

ImagenB=Imagen;

for i=1:muestras
    [Y,X,boton]=ginput(1);
    eje_x=round(X);
    eje_y=round(Y);
    patron=Imagen(eje_x - margen:eje_x + margen,eje_y - margen:eje_y + margen); 
    patrones=[patrones patron(:)];
    if (boton==1) salida_deseada=[salida_deseada 1];
        else salida_deseada=[salida_deseada 0];
    end;  
    ImagenB(eje_x - margen:eje_x + margen,eje_y - margen) = 256;
    ImagenB(eje_x - margen:eje_x + margen,eje_y + margen) = 256;
    ImagenB(eje_x - margen,eje_y - margen:eje_y + margen) = 256;
    ImagenB(eje_x + margen,eje_y - margen:eje_y + margen) = 256;
    image(ImagenB);
end;   

rango_entradas=[];
for j=1:(tamanho_ventana*tamanho_ventana)
    rango_entradas=[rango_entradas;[0 255]];
end

red = newff(rango_entradas,[50,50,1],{'tansig','tansig', 'tansig'},'traingdx');
% patrones(:)=double(patrones(:)); %para adaptar el formato
patrones=double(patrones);
red.trainparam.epochs=5000;
[red registro_entrenamiento]=train(red,patrones,salida_deseada);

patrones2=[];
% for j=1:columnas-(tamanho_ventana-1)
%    for i=1:filas-(tamanho_ventana-1)
%        for jj=0:(tamanho_ventana-1)
%            for ii=0:(tamanho_ventana-1)
%                patrones2=[patrones2 Imagen(i+ii,j+jj)];
%            end;
%        end;
%    end;
% end;
% patrones2=double(patrones2);

for i=(margen+1):size(Imagen,1)-margen
    for j=(margen+1):size(Imagen,2)-margen
        aux=Imagen(i-margen:i+margen,j-margen:j+margen);
        patrones2=[patrones2 [aux(:)]];
    end
end;
patrones2=double(patrones2);

salida=sim(red,patrones2);

k=1;
Imagen2=[];
for i=(margen+1):size(Imagen,1)-margen
    for j=(margen+1):size(Imagen,2)-margen
        if salida(k)>=0.75
            Imagen2(i-margen:i+margen,j-margen:j+margen)=1;
            k=k+1;
        else
            Imagen2(i-margen:i+margen,j-margen:j+margen)=2;
            k=k+1;
        end
    end
end

mapacolor=[1 1 1;0 0 0];
figure;
image(Imagen2);
colormap(mapacolor);