function [eImg,nImg] = shapesEnhance(img)
% This function adds shaped noise which is given by the following matrix:
% [1,0,0,0,1;
% 1,0,0,0,1;
% 0,1,0,1,0;
% 0,1,0,1,0;
% 0,0,1,0,0]. 
%
% with density of 0.003.
% then removes the noise with 5 x 1 median filter.
%
%
%   INPUT PARAMETERS
%       img     -   matrix of doubles
%         
%
%   OUTPUT PARAMETERS
%       eImg     -   enhansed image, matrix of doubles
%       nImg     -   noisy image, matrix of doubles
  mask = zeros(size(img));
  mask = imnoise(mask, 'salt & pepper', 0.003);
  noiseMat = [1,0,0,0,1;
              1,0,0,0,1;
              0,1,0,1,0;
              0,1,0,1,0;
              0,0,1,0,0];
  mask = conv2(mask, noiseMat, 'same');
  mask = min(mask, 1);
  nImg = max(mask, img);
  
  eImg = myMedian(nImg, 5, 1);
  
end

