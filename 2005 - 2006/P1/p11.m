close all;
clear all;

%patrones_entrenamiento = [-4 3; 1 2];
patrones_entrenamiento = [-5 2; 1.5 -6];
salida_deseada = [5 -2];

% Patrones de entrenamiento linealmente independientes
% patrones_entrenamiento = [1 2; 2 4];
% salida_deseada = [2 4];

% Inicio aleatorio de los pesos
W = rand(1, 2);

% Velocidad de aprendizaje (lp = learning parameters, lr = learning rate)
lp.lr = 0.00001;

% Error relativo
error_relativo = [salida_deseada(1) - (W * patrones_entrenamiento(:, 1)), salida_deseada(2) - (W * patrones_entrenamiento(:, 2))];

% Error Cuadratico Medio
ECM = ((salida_deseada(1) - (W * patrones_entrenamiento(:, 1))) ^ 2 + (salida_deseada(2) - (W * patrones_entrenamiento(:, 2))) ^ 2) * 0.5;

errores(1) = ECM;
iteraciones = 0;

% Entrenamiento del adaline
while ((ECM > 0.0001) & (iteraciones < 10000))
    % Funcion de aprendizaje de Widrow-Hoff, tambien conocida como delta o LMS (Least Mean Squared)
    % Necesita solo estos tres parametros para calcular el cambio de pesos
    dW = learnwh([], patrones_entrenamiento, [], [], [], [], error_relativo, [], [], [], lp, []);
    pesos(iteraciones + 1, :) = W;
    variaciones(iteraciones + 1, :) = dW;
    W = W + dW;
    error_relativo = [salida_deseada(1) - (W * patrones_entrenamiento(:, 1)), salida_deseada(2) - (W * patrones_entrenamiento(:, 2))];
    ECM = ((salida_deseada(1) - (W * patrones_entrenamiento(:,1))) ^ 2 + (salida_deseada(2) - (W * patrones_entrenamiento(:,2))) ^ 2) * 0.5;
    errores(iteraciones + 2) = ECM;
    iteraciones = iteraciones + 1;
end

% Pesos finales
pesos(iteraciones + 1, :) = W;
variaciones(iteraciones + 1, :) = dW;

x = -10:0.2:10;
y = -10:0.2:10;

% Creamos una malla
[X,Y] = meshgrid(x,y);

% Definimos la funcion que queremos evaluar en la malla (ECM)
Z = ((salida_deseada(1) - X * patrones_entrenamiento(1,1) - Y * patrones_entrenamiento(2, 1)) .^ 2 + (salida_deseada(2) - X * patrones_entrenamiento(1, 2) - Y * patrones_entrenamiento(2, 2)) .^ 2) * 0.5;

% Grafica de la funcion del error en 3D
figure
mesh(X, Y, Z)
hold on
plot3(pesos(1:iteraciones + 1, 1)', pesos(1:iteraciones + 1, 2)', errores, 'r')
hold off
title('Representacion del error en 3D con respecto a los pesos')

% Curvas de nivel
figure
contour(X, Y, Z)
hold on
plot3(pesos(1:iteraciones + 1, 1)', pesos(1:iteraciones + 1, 2)', errores, 'r')
hold off
title('Representacion del error en 2D (Curvas de nivel)')

% Error con respecto al tiempo
figure
plot(0:iteraciones, errores);
xlabel('Iteraciones')
ylabel('ECM')
title('Evolucion del ECM en el tiempo')

% Grafica de la funcion del error en 3D
figure
mesh(X, Y, Z)
hold on
plot3(variaciones(1:iteraciones + 1, 1)', variaciones(1:iteraciones + 1, 2)', errores, 'r')
hold off
title('Representacion del error en 3D con respecto a las variaciones de pesos')
