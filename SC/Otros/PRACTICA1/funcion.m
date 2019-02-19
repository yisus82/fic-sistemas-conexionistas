function y = funcion(x)
y=[];
for i=1:length(x)
%      if (x(i) <= -1) y=[y cos(x(i))];
% elseif (x(i) <= 1) y=[y 0.7];
% else y=[y ((sin(x(i)) * cos(x(i)))/5)];
% end;
% end;

% y= [y sin(x(i)) - 3*x(i)*x(i) + cos(2*x(i))]; %en la capa de salida purelin

% y= [y sin(x(i))  + cos(2*x(i))]; %en la capa de salida tansig

%y=sin(x);

y=[y 3*sin(x(i)*x(i))*exp(x(i))];

end;
