clear all;
close all;

% ENTRENAMIENTO:
% --------------

% Velocidad de aprendizaje pequena : 1
% Velocidad de aprendizaje alta : 2

% Matriz de entradas I (in):
    I = [1 2; 2 4];
% Vector de salidas deseadas T (target):
    T = [1 2];
% Vector de pesos W (weigth):
    W1 = rand(1,2).*5;
    W2 = W1;

% Vectores para guardar los pesos parciales:        
    Wx1 = [W1(1)];
    Wy1 = [W1(2)];    
    
    Wx2 = [W1(1)];
    Wy2 = [W1(2)];

% Vector para guardar los tiempos y tiempo:
    t1 = 0;
    vector_t1 = [t1];
    
    t2 = 0;
    vector_t2 = [t2];

% Vector para guardar los errores y error:
    ECM1 = 1/2*((T(1)-W1*I(:,1)).^2 + (T(2)-W1*I(:,2)).^2);
    vector_ECM1 = [ECM1];
    
    ECM2 = 1/2*((T(1)-W2*I(:,1)).^2 + (T(2)-W2*I(:,2)).^2);
    vector_ECM2 = [ECM2];
    
% Velocidad de aprendizaje:
    LP1.lr = 0.01;
    
    LP2.lr = 0.03;
    
% Entrenamiento de la red:        
    while (ECM1>0.0001 & t1<1000),
        t1 = t1+1;
        vector_t1 = [vector_t1 t1];
        E1 = [T(1)-W1*I(:,1) T(2)-W1*I(:,2)];
        dW = learnwh(W1,I,[],[],[],[],E1,[],[],[],LP1,[]);
        W1(1) = W1(1)+dW(1);
        W1(2) = W1(2)+dW(2);
        Wx1 = [Wx1 W1(1)];
        Wy1 = [Wy1 W1(2)];
        ECM1 = 1/2*((T(1)-W1*I(:,1)).^2 + (T(2)-W1*I(:,2)).^2);
        vector_ECM1= [vector_ECM1 ECM1];
    end

    while (ECM2>0.0001 & t2<1000),
        t2 = t2+1;
        vector_t2 = [vector_t2 t2];
        E2 = [T(1)-W2*I(:,1) T(2)-W2*I(:,2)];
        dW = learnwh(W2,I,[],[],[],[],E2,[],[],[],LP2,[]);
        W2(1) = W2(1)+dW(1);
        W2(2) = W2(2)+dW(2);
        Wx2 = [Wx2 W2(1)];
        Wy2 = [Wy2 W2(2)];
        ECM2 = 1/2*((T(1)-W2*I(:,1)).^2 + (T(2)-W2*I(:,2)).^2);
        vector_ECM2 = [vector_ECM2 ECM2];
    end
    
%   Los pesos finales son la solucion al sistema lineal:
%   I(1,1)*Wx(t)+I(2,1)*Wy(t)=O(1)
%   I(2,1)*Wx(t)+I(2,2)*Wy(t)=O(2)

% Representacion de la funcion de error:
    w = -5:0.1:5;
    [WX, WY] = meshgrid(w, w);
    Error = 1/2.*((T(1)-(I(1,1).*WX+I(2,1).*WY)).^2+(T(2)-(I(1,2).*WX+I(2,2).*WY)).^2);
    % Representacion 3D:
        figure;
        mesh(WX, WY, Error);
        title('Funcion de ERROR');
        xlabel('PesoX');
        ylabel('PesoY');
        zlabel('Error');
        
    % Superposicion de la variacion de pesos:
        hold on;        
        plot3(Wx1, Wy1, vector_ECM1, 'y-*', Wx2, Wy2, vector_ECM2, 'r-*');
        legend({'Velocidad de aprendizaje pequeña','Velocidad de aprendizaje alta'});
        
    % Representacion 2D:
        figure;
        contour(WX, WY, Error);
        title('Funcion de ERROR');
        xlabel('PesoX');
        ylabel('PesoY');
        zlabel('Error'); 
        
    % Superposicion de la variacion de pesos:    
        hold on;
        plot(Wx1, Wy1, 'b.-', Wx2, Wy2, 'r.-');
        legend({'Velocidad de aprendizaje pequeña','Velocidad de aprendizaje alta'});

% Representacion del error con respecto al tiempo:    
    figure;
    plot(vector_t1, vector_ECM1, 'b.-', vector_t2, vector_ECM2, 'r.-');
    title('Error con respecto al tiempo');
    xlabel('Tiempo');
    ylabel('Error');
    legend({'Velocidad de aprendizaje pequeña','Velocidad de aprendizaje alta'});            

    
% PREDICCION:
% -----------

clear all;

% La entrada I (in) a la red es la misma que la salida deseada T (target):
    time = 1:0.01:2.5;
    I = con2seq([sin(sin(time).*time*10)]);
    T = I;

% Vamos a usar un nivel de aprendizaje lr.La red va a usar los "n" ultimos valores 
% de la salida deseada para predecir el siguiente valor.
    lr1 = 0.03;
    n1 = 5;
    delay1 = 1:1:n1;
    net1 = newlin(minmax(cat(2,I{:})),1,delay1,lr1);
    
    lr2 = 0.1;
    n2 = 5;
    delay2 = 1:1:n2;
    net2 = newlin(minmax(cat(2,I{:})),1,delay2,lr2);

% ADAPT simula una red adaptativa. Coge una red, una entrada, una salida
% deseada y filtra la entrada adaptativamente. Salida deseada T (target),
% la salida 0 (out) y el error que comete la red E.
    [net1,O1,E1]=adapt(net1,I,T);
    
    [net2,O2,E2]=adapt(net2,I,T);
    
    figure;
    title('Prediccion de una señal');
    plot(time,cat(2,T{:}),'k', time,cat(2,O1{:}), 'b', time,cat(2,O2{:}), 'r', ...
         time,cat(2,E1{:}), 'm--', time,cat(2,E2{:}),'g--');
    grid on;
    legend({'Salida deseada','Salida con velocidad de aprendizaje pequeño', ...
    'Salida con velocidad de aprendizaje alto','Error con vel de ap pequeño', 'Error con vel de ap alto'});