function [eImg,nImg] = gaussEnhance(img)
%This function adds gaussian noise to the given image with mean value 0, 
%and var=0.004, and then trys to enhance the image using directional smoothing, 
%with the following 7x7 filters:
%1) Vertical line. 
%2) Horizontal line.
%3) Diagnal from top left to buttom right.
%4) Diagnal from top right to buttom left.
%5) Pluse.
%6) X. 
% In addition there is a 3x3 low-pass filter.
%
%   INPUT PARAMETERS
%       img     -   matrix of doubles 
%         
%   OUTPUT PARAMETERS
%       nImg     -   noisy image, matrix of doubles
%       eImg     -   enhansed image, matrix of doubles

  nImg = imnoise(img, 'gaussian', 0, 0.004);
  eImg = directionalSmoothing(nImg); 
end

function [eImg] = directionalSmoothing(img)
% Given an image trys to smooth it
% with the following 7x7 filters:
% - Vertical line.
% - Horizontal line.
% - Diagnal from top left to buttom right.
% - Diagnal from top right to buttom left.
% - Pluse
% - X
% In addition there is a 3x3 low-pass filter.
   c1 = ones(3);
   c2 = [0, 0, 1, 1, 0, 0, 0;
         0, 0, 1, 1, 0, 0, 0;
         0, 0, 1, 1, 0, 0, 0;
         0, 0, 1, 1, 0, 0, 0;
         0, 0, 1, 1, 0, 0, 0;
         0, 0, 1, 1, 0, 0, 0;
         0, 0, 1, 1, 0, 0, 0];
   c3 = transpose(c2);
   c4 = eye(7);
   c5 =  fliplr(c4);
   c6 = c4 | c5;
   c7 = c2 | c3;
   e1 = filterNoise(img, c1);
   e2 = filterNoise(img, c2);
   e3 = filterNoise(img, c3);
   e4 = filterNoise(img, c4);
   e5 = filterNoise(img, c5);
   e6 = filterNoise(img, c6);
   e7 = filterNoise(img, c7);
   
   eImg = computeSmoothenImage(img, e1, e2, e3, e4, e5, e6, e7);
end

function [newImg] = computeSmoothenImage(img, c1, c2, c3, c4, c5, c6, c7)
% Computes the smootehn image form the img and the image after filters
% by choosing the closest value from filtered image to the original image at
% position i, j.
  [N, M] = size(img);
  newImg = zeros(size(img));
   
  for i = 1:N
    for j = 1:M
      val = img(i, j);
      filtered = [c1(i, j), c2(i, j), c3(i, j), c4(i, j), c5(i, j), c6(i, j), c7(i, j)];
      [_, I] = min(abs(val - filtered));
      newImg(i, j) = filtered(I);
    end
  end
end

function [newImg] = filterNoise(img, mask)
% Normilize and apply the mask on img.
   normMask = mask/sum(sum(mask));
   newImg = min(conv2(img, normMask, 'same'), 1);
end
