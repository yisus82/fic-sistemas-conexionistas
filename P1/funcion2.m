function y = funcion2(x)
y=[];
for i=1:length(x)
    if (x(i) <= -3) y=[y sin(x(i))];
    elseif (x(i) <= 5) y=[y 1];
    else y=[y ((cos(x(i)) * cos(x(i)))/5)];
    end;
end;
