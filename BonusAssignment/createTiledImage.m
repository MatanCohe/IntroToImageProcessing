function [nImg] = createTiledImage(bigImage, smallImage)
%createTiledImage   This function create tiled image of bigImage from smallImage.
%                   Assume that size(bigImage) / size(smallImage) is a natural number.
%                   if not the output(nImg) is not guaranteed.
%
%
%   INPUT PARAMETERS
%       bigImage     -   matrix of uint8.
%       smallImage   -   matix of uint8.
%       
%   OUTPUT PARAMETERS
%       nImg     -   matrix of uint8.
  nImg = zeros(size(bigImage), 'uint8');
  [bigRows, bigCols] = size(bigImage);
  [smallRows, smallCols] = size(smallImage);
  
  for i = 1:smallRows:bigRows - smallRows + 1
    for j = 1:smallCols:bigCols - smallCols + 1

      dest = bigImage(i: i + smallRows - 1, j:j + smallCols - 1);
      newImg = histShape(smallImage, dest);
      nImg(i: i + smallRows - 1, j:j + smallCols - 1) = newImg;
      
    end
  end
end
