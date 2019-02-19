function y = funcion(x)
y=[];
for i=1:length(x)
    y = [y (3*sin(x(i)*x(i)))];
end;
