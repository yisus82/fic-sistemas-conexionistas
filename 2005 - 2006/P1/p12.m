clear all;
close all;

% Señal continua
x = -10:0.01:10;
f = sin(x);

% Introduccion de ruido en la señal
% ruido = wgn(length(x), 1, 5);
% f = f + ruido';

%Inicio aleatorio de los pesos
W = rand(1, 3);

% Velocidad de aprendizaje (lp = learning parameters, lr = learning rate)
lp.lr = 0.055;

% Entrenamiento del adaline
i = 1;
salida_obtenida(1:2) = zeros(1,2);
salida_deseada(1) = f(1);
salida_deseada(2) = f(1) + f(2);
errores(1:2) = abs(salida_deseada(1:2));
while (i < (length(f) - 1))
    patrones_entrenamiento = [f(i); f(i + 1); f(i + 2)];
    salida_deseada(i + 2) = f(i) + f(i + 1) +  f(i + 2);
    error_relativo = salida_deseada(i + 2) - (W * patrones_entrenamiento);
    % Funcion de aprendizaje de Widrow-Hoff, tambien conocida como delta o LMS (Least Mean Squared)
    % Necesita solo estos tres parametros para calcular el cambio de pesos
    dW = learnwh([], patrones_entrenamiento, [], [], [], [], error_relativo, [], [], [], lp, []);
    W = W + dW;
    salida_obtenida(i + 2) = W * patrones_entrenamiento;
    if (salida_deseada(i + 2) == 0) errores(i + 2) = abs(salida_obtenida(i + 2));
    else errores(i + 2) = abs((salida_deseada(i + 2) - salida_obtenida(i + 2)) / salida_deseada(i + 2));
    end
    i = i + 1;
end

figure
subplot(2, 1, 1)
plot(x, f)
title('Señal de entrada')
subplot(2, 1, 2)
plot(x, salida_deseada)
title('Salida deseada')

figure
hold on
plot(x, salida_deseada, 'b')
plot(x, salida_obtenida, 'g')
plot(x, errores, 'r')
hold off
title('En azul la salida deseada, en verde la señal obtenida y en rojo el error relativo cometido')
