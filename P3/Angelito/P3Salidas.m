%Practica 3:Sistemas conexionistas. Hallamos las salidas(0 negro 255
%blanco)
clear all;
close all;
 caso=input('¿Que caso desea tratar?(1/2)');
 if caso==1
   a=imread('imagenP3.JPG','jpg');  %la imagen en escala de grises
   load somcaso1;
   load NPEcaso1;
   length(a(:,1))
   length(a(1,:))
   pause;
   m=input('¿El mapa era unidimensional o bidimensional?(u/b)');   
   for i=1:length(a(:,1))-2
     for j=1:length(a(1,:))-2
       p1=1;  
       for x=i:i+2
         for y=j:j+2
           patron(p1,1)=a(x,y); 
           p1=p1+1;
         end
        end
      patron=double(patron);
      resultado=sim(somcaso1,patron);
      salida=find(resultado==1);  
      if m=='u'
       if salida<floor(0.15*NPEcaso1) 
        z1(i,j)=0;
       elseif salida<floor(0.30*NPEcaso1)
        z1(i,j)=40;
       elseif salida<floor(0.45*NPEcaso1)   %Se asigna un 15% a cada clase si quereis podeis cambiarlo y hacer vuestras asignaciones 
        z1(i,j)=80;
       elseif salida<floor(0.60*NPEcaso1)
        z1(i,j)=120;
       elseif salida<floor(0.75*NPEcaso1)
        z1(i,j)=160;
       elseif salida<floor(0.90*NPEcaso1)
        z1(i,j)=200;
       else z1(i,j)=255;
       end;     
      end;
      if m=='b'
       if salida<floor(0.15*NPEcaso1^2) 
        z1(i,j)=0;
       elseif salida<floor(0.30*NPEcaso1^2)
        z1(i,j)=40;
       elseif salida<floor(0.45*NPEcaso1^2)
        z1(i,j)=80;
       elseif salida<floor(0.60*NPEcaso1^2)
        z1(i,j)=120;
       elseif salida<floor(0.75*NPEcaso1^2)
        z1(i,j)=160;
       elseif salida<floor(0.90*NPEcaso1^2)
        z1(i,j)=200;
       else z1(i,j)=255;
       end;  
      end;
    end
   end      
   figure;
   colormap(gray);
   image(z1);
   title('Imagen de salida.Caso1');
 end
 
if caso==2
   load somcaso2;
   load NPEcaso2;
   a=imread('imagenP3.JPG','jpg'); 
   length(a(:,1))
   length(a(1,:))
   pause;
   m=input('¿El mapa era unidimensional o bidimensional?(u/b)');   
   for i=1:length(a(:,1))
       i
    for j=1:length(a(1,:))
       patron(1,1)=i;
       patron(2,1)=j;
       resultado=sim(somcaso2,patron);
       salida=find(resultado==1);
      if m=='u'
       if salida<floor(0.15*NPEcaso2) 
        z2(i,j)=0;
       elseif salida<floor(0.30*NPEcaso2)
        z2(i,j)=40;
       elseif salida<floor(0.45*NPEcaso2)   %Se asigna un 15% a cada clase si quereis podeis cambiarlo y hacer vuestras asignaciones 
        z2(i,j)=80;
       elseif salida<floor(0.60*NPEcaso2)
        z2(i,j)=120;
       elseif salida<floor(0.75*NPEcaso2)
        z2(i,j)=160;
       elseif salida<floor(0.90*NPEcaso2)
        z2(i,j)=200;
       else z2(i,j)=255;
       end;     
      end;
      if m=='b'
       if salida<floor(0.15*NPEcaso2^2) 
         z2(i,j)=0;
       elseif salida<floor(0.30*NPEcaso2^2)
         z2(i,j)=40;
       elseif salida<floor(0.45*NPEcaso2^2)
         z2(i,j)=80;
       elseif salida<floor(0.60*NPEcaso2^2)
         z2(i,j)=120;
       elseif salida<floor(0.75*NPEcaso2^2)
         z2(i,j)=160;
       elseif salida<floor(0.90*NPEcaso2^2)
         z2(i,j)=200;
       else z2(i,j)=255;
       end; 
     end; 
   end;
 end;      
 figure;
 colormap(gray); %podeis cambiarle el mapa de colores
 imagesc(z2);   
 title('Imagen de salida.Caso2');
end
