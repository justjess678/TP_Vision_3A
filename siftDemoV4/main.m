% SIFT
% [image, descrips, locs] = sift('image_test_3.jpg');
% showkeys(image, locs);

% Moravec
%I = imread('morav.bmp');
 I = imread('shapes2.png');
 I = double(rgb2gray(I));
Iout = zeros(size(I));
imshow(I);
[xI,yI,zI] = size(I);
sum = 0;
vals = [];
for x=1:xI
   for y=1:yI
       for a=-5:2:5
            for b=-5:2:5
               for u=1:11
                  for v=1:11
                      if x+a+u<1
                          imgX1 = 1;
                      elseif x+a+u>xI
                          imgX1 = xI;
                      else
                          imgX1 = x+a+u;
                      end
                      if y+b+v<1
                          imgY1 = 1;
                      elseif y+b+v>yI
                          imgY1 = yI;
                      else
                          imgY1 = y+b+v;
                      end
                      if x+u<1
                          imgX2 = 1;
                      elseif x+u>xI
                          imgX2 = xI;
                      else
                          imgX2 = x+u;
                      end
                      if y+v<1
                          imgY2 = 1;
                      elseif y+v>yI
                          imgY2 = yI;
                      else
                          imgY2 = y+v;
                      end
                     sum = sum + abs(I(imgX1,imgY1)-I(imgX2,imgY2));
                   end
               end
               vals = [vals sum];
               sum = 0;
           end
       end
       Iout(x,y) = min(vals);
       vals = [];
   end
end
imshow(Iout);