clear all;
close all;

% ENTRENAMIENTO:
% --------------

% Matriz de entradas I (in):
    I = [-4 1 0; 3 2 7];

% Vector de salidas deseadas T (target):
    T = [5 -2];
    
% Velocidad de aprendizaje:
    LP1.lr = 0.01;
    
% Numero de iteraciones:
    IT = 1000;
    
% Error minimo admitido:
    MINERROR = 0.0001;
    
if (length(I)==2)

	% Vector de pesos W (weigth):
        %W1 = rand(1,2).*5;
	
	% Vectores para guardar los pesos parciales:
        %Wx1 = [W1(1)];
        %Wy1 = [W1(2)];    
	
	% Vector para guardar las iteraciones:
        t1 = 0;
        vector_t1 = [t1];
        
    % Inicializacion del adaline
        adaline= newlin([-5 5 ; -5 5],1);
        adaline.biasConnect=0;

    %     
% %adaline.IW{1}(1)=randn(1)*5
% %adaline.IW{1}(2)=randn(1)*5
% 
% Y=sim (adaline,P);
% 
% Er=D-Y;
% minErr=( (D(1)-Y(1))^2 + (D(2)-Y(2))^2)/2;
	
	% Vector para guardar los errores y error:
        ECM1 = 1/2*((T(1)-W1*I(:,1)).^2 + (T(2)-W1*I(:,2)).^2);
        vector_ECM1 = [ECM1];
        
	% Entrenamiento de la red:        
        while (ECM1>MINERROR & t1<IT),
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
            plot3(Wx1, Wy1, vector_ECM1, 'r');
            
        % Representacion 2D:
            figure;
            contour(WX, WY, Error);
            title('Funcion de ERROR');
            xlabel('PesoX');
            ylabel('PesoY');
            zlabel('Error'); 
            
        % Superposicion de la variacion de pesos:    
            hold on;
            plot(Wx1, Wy1, 'r');
	
	% Representacion del error con respecto al tiempo:    
        figure;
        plot(vector_t1, vector_ECM1, 'r');
        title('Error con respecto al tiempo');
        xlabel('Tiempo');
        ylabel('Error');
    
else

    % Vector de pesos W (weigth):
    W1 = rand(1,3).*5;

	% Vectores para guardar los pesos parciales:
        Wx1 = [W1(1)];
        Wy1 = [W1(2)];
        Wz1 = [W1(3)];
	
	% Vector para guardar las iteraciones:
        t1 = 0;
        vector_t1 = [t1];
	
	% Vector para guardar los errores y error:
        ECM1 = 1/2*((T(1)-W1*I(:,1)).^2 + (T(2)-W1*I(:,2)).^2);
        vector_ECM1 = [ECM1];
%         
% 	% Entrenamiento de la red:        
%         while (ECM1>MINERROR & t1<IT),
%             t1 = t1+1;
%             vector_t1 = [vector_t1 t1];
%             E1 = [T(1)-W1*I(:,1) T(2)-W1*I(:,2) T(3)-W1*I(:,3)];
%             dW = learnwh(W1,I,[],[],[],[],E1,[],[],[],LP1,[]);
%             W1(1) = W1(1)+dW(1);
%             W1(2) = W1(2)+dW(2);
%             W1(3) = W1(3)+dw(3);
%             Wx1 = [Wx1 W1(1)];
%             Wy1 = [Wy1 W1(2)];
%             Wz1 = [Wz1 W1(3)];
%             ECM1 = 1/2*((T(1)-W1*I(:,1)).^2 + (T(2)-W1*I(:,2)).^2 + (T(3)-W1*I(:,3)).^2);
%             vector_ECM1= [vector_ECM1 ECM1];
%         end
% 	
% 	% Representacion de la funcion de error:
%         w = -5:0.1:5;
%         [WX, WY] = meshgrid(w, w);
%         Error = 1/2.*((T(1)-(I(1,1).*WX+I(2,1).*WY)).^2+(T(2)-(I(1,2).*WX+I(2,2).*WY)).^2);
%         % Representacion 3D:
%             figure;
%             mesh(WX, WY, Error);
%             title('Funcion de ERROR');
%             xlabel('PesoX');
%             ylabel('PesoY');
%             zlabel('Error');
%             
%         % Superposicion de la variacion de pesos:
%             hold on;        
%             plot3(Wx1, Wy1, Wz1, vector_ECM1, 'r');
%             
%         % Representacion 2D:
%             figure;
%             contour(WX, WY, Error);
%             title('Funcion de ERROR');
%             xlabel('PesoX');
%             ylabel('PesoY');
%             zlabel('Error'); 
%             
%         % Superposicion de la variacion de pesos:    
%             hold on;
%             plot(Wx1, Wy1, Wz1, 'r');
% 	
% 	% Representacion del error con respecto al tiempo:    
%         figure;
%         plot(vector_t1, vector_ECM1, 'r');
%         title('Error con respecto al tiempo');
%         xlabel('Tiempo');
%         ylabel('Error');
        
end