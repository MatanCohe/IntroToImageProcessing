
function [ newImg ] = histShape( srcimg, destimg )
%histShape   This function creates new image from srcimg with destimg histogram.
%
%   INPUT PARAMETERS
%       srcimg     -   uint8 matrix
%       destimg    -   uint8 matrix
%
%   OUTPUT PARAMETERS
%       newImg     -   uint8 matrix (same size as  srcimg)
%

  OFFSET = 1;
  [N, M] = size(srcimg);
  cv = computeConversionVector(srcimg, destimg);
  newImg = zeros(size(srcimg), 'uint8');
  for i = 1:N
      for j = 1:M
          newImg(i, j) = cv(srcimg(i, j) + OFFSET); 
      end
  end
end



function [ conversionVector ] = computeConversionVector(srcimg, dstimg)
%computeConversionVector   This function calculates vector of conversion 
%                          values from srcimg to dstimg.
%
%   INPUT PARAMETERS
%       srcimg     -   uint8 matrix
%       destimg    -   uint8 matrix
%
%   OUTPUT PARAMETERS
%       conversionVector - vector of uint8
%

  GRAY_LEVEL_NO = 256;
  OFFSET = 1;
  conversionVector = zeros(numel(srcimg), 1, 'uint8');
  
  srcimgCumulHist = computeCumulativeHistogram(srcimg);
  dstimgCumulHist = computeCumulativeHistogram(dstimg);
  
  s = 0;
  d = 0;
  
  while s < GRAY_LEVEL_NO
    if srcimgCumulHist(s + OFFSET) > dstimgCumulHist(d + OFFSET)
      d = d + 1;
    else
      conversionVector(s + OFFSET) = d;
      s = s + 1;
    end
  end
end


function [ cumulativeHist ] = computeCumulativeHistogram( image )
%computeCumulativeHistogram   This function creates cumulative histogram
%
%   INPUT PARAMETERS
%       image     -   matrix NxM of uint8
%
%   OUTPUT PARAMETERS
%       cumulativeHist     -   vector (256, 1) of doubles.
%
%   
%

  GRAY_LEVEL_NO = 256;
  [N, M] = size(image);
  cumulativeHist = pixelCounter(image);
  
  for i = 2:GRAY_LEVEL_NO
    cumulativeHist(i) = cumulativeHist(i - 1) + cumulativeHist(i);
  end
  
  cumulativeHist = double(cumulativeHist)/(N * M);

end



function [ counter ] = pixelCounter( image )
%This function counts the number of repititions of each gray level 
%in the image and returns a vector of occurrence for each gray level.
%
%   INPUT PARAMETERS
%       image     -   NxM matrix of uint8
%
%   OUTPUT PARAMETERS
%       counter  -   vector (256, 1) of uint64.

  [N, M] = size(image);
  GRAY_LEVEL_NO = 256;
  OFFSET = 1;
  counter = zeros(GRAY_LEVEL_NO, 1, 'uint64');
  for i = 1:N
    for j = 1:M
      pos = uint16(image(i, j) + OFFSET);
      counter(pos) = counter(pos) + 1;
    end
  end
end
