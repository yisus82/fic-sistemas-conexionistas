close all;
clear all;

%en A se guarda la imagen asociada al fichero y en B el mapa de colores
[A,B]=imread('image01','bmp');
colormap(B);
image(A);
[m,n]=size(A);
X=[];
Y=[];
Z=[];%boton izquierdo (1) ---> carreteras //// boton derecho (3) ---> campos
[X,Y,Z]=ginput(10);
salida_deseada=[];
for i=1:10
    num_elem=0;
    for jj=0:6
            for ii=0:6
                num_elem=num_elem+1;
                patrones(num_elem,i)=A(round(X(i))+ii,round(Y(i))+jj);
            end;
    end;
    if (Z(i)==1) salida_deseada=[salida_deseada 1];
        else salida_deseada=[salida_deseada 0];
    end;    
end;   
    
red = newff([0 255],[40,40,1],{'tansig','tansig', 'tansig'},'traingdx');
% 
% patrones2=[];
% for j=1:n-6
%    for i=1:m-6
%        for jj=0:6
%            for ii=0:6
%                patrones2=[patrones2 A(i+ii,j+jj)];
%            end;
%        end;
%    end;
% end;
