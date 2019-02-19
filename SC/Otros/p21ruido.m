clg;
ruido=randn(1,length(tiempo));
SenalModific=X1 + 0.05*ruido;   %Se\al de entrada con ruido
%temp=delaysig(X1,1,10); 
%SenalModific=temp(10,:);  %Se\al de entrada desplazada ligeramente


figure(1);
subplot(2,1,1);
plot(tiempo,SenalModific);
title('Se\al de entrada con ruido');
%title('Se\al de entrada desplazada');
pause

IN=zeros(L,N);

for i=1:N,
  for j=1:L,
     IN(j,i)=SenalModific(1, L*(i-1)+j);
  end
end


t1=0;
t2=0;
k=0;

for i=1:N,
  [A1,A2]=simuff(IN(:,i),W1,b1,'tansig',W2,b2,'tansig');
  for j=1:L,
    O(1,(L*k)+j)=A2(j);   %Salida que obtiene la red
  end
  k=k+1;
  t1=sumsqr(IN(:,i)-A2);
  t2=sumsqr(IN(:,i));
  E(1,i)=sqrt((t1/t2)*100);
end  

error=sum(E)/N;    %Media aritmetica de los errores para cada tramo

figure(1);
subplot(2,1,2);
plot(tiempo, O);
title('Salida de la red ante una entrada con ruido');
%title('Salida de la red ante una entrada desplazda');

fprintf('\nError de reconstruccion ante entrada modificada\n');
fprintf('\n   N     r     Iteraciones     Factor_Compresion     Error\n');
fprintf('   %d   %d       %d', N,r,iteracciones);
fprintf('              %f        %f\n', (N*L)/(N*r),error);

