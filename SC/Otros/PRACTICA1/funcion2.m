function y = funcion2(x)
y=[];
for i=1:length(x)
    if (x(i) <= -1) y=[y cos(x(i))];
    elseif (x(i) <= 2) y=[y 1];
    else y=[y (sin(x(i))*cos(x(i)))/5];
    end;
end;
% y = sin(x);