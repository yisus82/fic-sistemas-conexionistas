clear all;
clc;

disp('Dimensionalidad del espacio de salida');
disp('1. Unidimensional');
disp('2. Bidimensional');
dimensionalidad = input('Opcion: ');
eps1 = input('Numero de EPs de la primera dimension: ');
capa_de_salida = [eps1];
if (dimensionalidad == 2) 
    eps2 = input('Numero de EPs de la segunda dimension: ');
    capa_de_salida = [eps1 eps2];
end;
numero_de_patrones = input('Numero de patrones: ');
pasos_del_entrenamiento = input('Pasos del entrenamiento: ');
disp('Distribucion del conjunto de entrenamiento');
disp('1. Uniforme');
disp('2. No uniforme');
distribucion = input('Opcion: ');
disp('Metodo de clasificacion de la imagen');
disp('1. Nivel medio de gris en una ventana de 3x3');
disp('2. Coordenadas');
clasificacion = input('Opcion: ');
numero_de_clases = input('Numero de clases finales: ');

if (clasificacion == 1) gris;
    else coordenadas;
end