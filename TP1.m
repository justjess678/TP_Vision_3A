I=imread('TP01I01.jpg');
I = im2double(I);
%imshow(I)
% spectre de Fourier
F=fft2(I);
S=fftshift(F);
S=ifft2(S);
%L=log2(S);
A=abs(S);
imagesc(A); colormap(gray(256));
% calcul de l'erreur
mse = immse(I, A);

[xI,yI,zI] = size(I);
I2 = I;
n = 1;
valchang =[];
valMSE = [];
while n<(xI/2)-1
    nbchang = 0;% nombre de pixels mis a 0
   % mettre les n premieres/dernieres
   % lignes/colonnes a 0
   for y=1:yI
       for x=1:xI
           if y<n || y>(yI-n) || x<n || x>(xI-n)
               I2(x,y)=0;
               nbchang = nbchang + 1;
           end
       end
   end
   % Calculer la transformée inverse pour produire
   % l'image filtrée
   F=fft2(I2);
   S=fftshift(F);
   S=ifft2(S);
   A=abs(S);
   % Calculer l'Erreur Quadratique Moyenne entre
   % l'image de départ et la nouvelle image filtrée
   valMSE = [valMSE immse(I, A)];
   valchang = [valchang (nbchang / (xI*yI))*100];
   n = n+1;
end
[xMSE,yMSE] = size(valMSE);
valMSE= valMSE/max(valMSE)*100;
imagesc(I2);
figure();
x = linspace(1,254,254);
plot(x,valMSE)
title('MSE & number of 0s added')
legend({'y = MSE','y = nb_de_0'},'Location','east')
hold on
plot(x,valchang)
hold off