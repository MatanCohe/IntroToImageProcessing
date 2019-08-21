function [newImg] = myMedian(img,rows,cols)
% This function performs median filtering, where output pixels contains the median value n around the  corresponding pixel in the input image. 
%
%   INPUT PARAMETERS
%       img     -   matrix of numbers with natural order
%       rows    -   number of rows of the filter
%       cols    -   number of columns of the filter
%
%   OUTPUT PARAMETERS
%       newImg     -   matrix of doubles the same dimension as img
  fun = @(x) medianPixel(x(:));
  newImg = nlfilter(img, [rows, cols], fun);
end

function [newPixel] = medianPixel(mask)
% returns the median value of a given vector.
    res = sort(mask);
    newPixel = res(floor(numel(mask)/2 + 1));
end

