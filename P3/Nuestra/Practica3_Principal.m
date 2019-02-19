clear all;
close all;
clc;

dimensionalidad = menu('DIMENSIONALIDAD DEL ESPACIO DE SALIDA', 'Unidimensional', 'Bidimensional');
eps1 = input('NUMERO DE EPs DE LA PRIMERA DIMENSION: ');
capa_de_salida = [eps1];
if (dimensionalidad == 2) 
    eps2 = input('NUMERO DE EPs DE LA SEGUNDA DIMENSION: ');
    capa_de_salida = [eps1 eps2];
end;
numero_de_patrones = input('NUMERO DE PATRONES: ');
pasos_del_entrenamiento = input('PASOS DEL ENTRENAMIENTO: ');
distribucion = menu('SELECCION DEL CONJUNTO DE ENTRENAMIENTO', 'Distribucion uniforme', 'Distribucion normal');
clasificacion = menu('TRATAMIENTO Y CLASIFICACION DE LOS PATRONES', 'Nivel medio de gris de una ventana 3x3', 'Coordenadas');
clases_finales = input('NUMERO DE CLASES FINALES: ');

switch clasificacion
    case {1}
        Practica3_gris;
    case (2)
        Practica3_xy;
end
