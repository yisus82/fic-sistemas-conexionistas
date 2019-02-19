clear all;
close all;

x1 = 0.5:0.05:2;
x2 = 2.05:0.05:5;
x3 = 5.05:0.05:8;
x = [x1 x2 x3];

i = 1;
j = 1;
while (i <= length(x1))
    f(j) = x1(i) + 3*x(i)^2;
    i = i + 1;
    j = j + 1;
end
i = 1;
while (i <= length(x2))
    f(j) = sin(x2(i))  / 5;
    i = i + 1;
    j = j + 1;
end
i = 1;
while (i <= length(x3))
    f(j) = 2 + cos((x3(i) ^ 2) / 8);
    i = i + 1;
    j = j + 1;
end

%Inicio aleatorio de los pesos
W = rand(1, 6);

% Velocidad de aprendizaje (lp = learning parameters, lr = learning rate)
lp.lr = 0.00001;

% Entrenamiento del adaline
i = 1;
salida_obtenida(1:6) = zeros(1,6);
while (i < 7)
    salida_deseada(i) = f(i);
    i = i + 1;
end
errores(1:6) = abs(salida_deseada(1:6));
i = 1;
iteraciones = 100;
while (iteraciones <= 100)
i = 1;
while (i < (length(f) - 5))
    patrones_entrenamiento = [f(i); f(i + 1); f(i + 2); f(i + 3); f(i + 4); f(i + 5)];
    salida_deseada(i + 6) = f(i + 6);
    error_relativo = salida_deseada(i + 6) - (W * patrones_entrenamiento);
    % Funcion de aprendizaje de Widrow-Hoff, tambien conocida como delta o LMS (Least Mean Squared)
    % Necesita solo estos tres parametros para calcular el cambio de pesos
    dW = learnwh([], patrones_entrenamiento, [], [], [], [], error_relativo, [], [], [], lp, []);
    W = W + dW;
    salida_obtenida(i + 6) = W * patrones_entrenamiento;
    if (salida_deseada(i + 6) == 0) errores(i + 6) = abs(salida_obtenida(i + 6));
    else errores(i + 6) = abs((salida_deseada(i + 6) - salida_obtenida(i + 6)) / salida_deseada(i + 6));
    end
    i = i + 1;
end
iteraciones = iteraciones + 1;
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
