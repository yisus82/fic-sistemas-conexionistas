close all;
clear all;

ventana = 7;
lado = (ventana-1)/2;

imagen = imread('image01','bmp');
imagen = double(imagen);

%   1.- Caminos en llanuras (rojo)
%   2.- Caminos con bordes de bosques (verde)
%   3.- Caminos entre bosques (azul)
%   4.- Cruces (magenta)
%   5.- Finales de caminos (amarillo)

%   6.- Llanuras (marron)
%   7.- Bosques (cyan)
%   8.- Cantera (violeta)

x = [87  96  32 39 , 53 71 114 129 , 19 151 81 156 83 , 91 69 62 115 ,  70 40 75 139 , ...
        37 57  98 83 , 41 81  60 159,  28  34  28  34];
y = [37 103 112 41 , 82 63 123  11 , 85  47 86  37 89 , 67 51 90  86 , 142 13 80 102 , ...
       135 36 140 55 , 65 14 143  52, 141 141 147 147];
S = [ 1   1   1  1 ,  1  1   1   1 ,  1   1  1   1  1 ,  1  1  1   1 ,   1  1  1   1 , ...
         0  0   0  0 ,  0  0   0   0,   0   0   0   0];

[f,c] = size(x);

E = [];
for i = 1:c,
    v = [];
    for j = -lado:lado,
        v = [v; imagen((x(i)-lado):(x(i)+lado),y(i)+j)];        
    end;
    E = [E v];
end;

Rangos = [];

for k = 1:ventana^2,
    Rangos(k,:) = [0 255];
end;

net = newff(Rangos,[60 40 20 1],{'logsig','purelin','purelin','logsig'},'traingdx');
      
net.trainParam.epochs = 100000;     
net.trainParam.min_grad =1.e-25;
net.trainParam.goal = 1.e-25;

net = train(net,E,S);

save red net;