j=1;
x=0;
y=0;
Entrada=0;

for x=0:0.25:1
   for y=4:0.25:6
      Entrada(1,j)=x;
      Entrada(2,j)=y;
      j=j+1;
   end;
end;
j=j+1;
Entrada(1,j)=2;
Entrada(2,j)=9;
j=j+1;
Entrada(1,j)=3;
Entrada(2,j)=6.5;
j=j+1;
Entrada(1,j)=3.5;
Entrada(2,j)=5;
j=j+1;
Entrada(1,j)=4;
Entrada(2,j)=8.8;
j=j+1;
Entrada(1,j)=4.5;
Entrada(2,j)=6;
j=j+1;
Entrada(1,j)=4.6;
Entrada(2,j)=5;
j=j+1;
Entrada(1,j)=5;
Entrada(2,j)=8;
j=j+1;
Entrada(1,j)=5.25;
Entrada(2,j)=5;
j=j+1;
Entrada(1,j)=6;
Entrada(2,j)=7;
j=j+1;
Entrada(1,j)=7;
Entrada(2,j)=6;

R=minmax(Entrada);
plotsom(Entrada);

net=newsom(R);
net.trainParam.epochs=500;
net=train(net,Entrada);
figure(2);
plotsom(net.iw{1,1},net.layers{1}.distances);
figure(3);
plot(Entrada(1,:),Entrada(2,:),'.g','markersize',20);
hold on;
plotsom(net.iw{1,1},net.layers{1}.distances);
hold off;