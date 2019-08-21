function [newImg] = skeletonizeImage(img)
%skeletonizeImage   This function keletonize objects in a given binary image and returns the new binary image.
%
%   INPUT PARAMETERS
%       img     -   binary image
%           
%   OUTPUT PARAMETERS
%       newImg     -   binary image
 
  pImg = padarray (img, [1, 1], 'both');
  [N, M] = size(pImg);
  tag = 1;
  interImg = pImg;
  tagImg = interImg;
  while sum(sum(interImg == 1)) > 0
    interImg = updateImage(tagImg, tag);
    tagImg = tagImg + interImg;
    tag = tag + 1;
  end
  newImg = zeros(size(pImg));
  for i = 2:N-1
    for j = 2:M-1
      [pixel, v] = get4Neighborhood(tagImg, i, j);
      if (0 < pixel) && (0 < prod(v <= pixel))
        newImg(i, j) = 1;
      end
    end
  end
  
  newImg = newImg(2:end-1, 2:end-1);
end

function [interImg] = updateImage(img, tag)
% Updates the image with the pixels that they and they 4 neighborhood
% value are greter then tag value.
  [N, M] = size(img);
  interImg = zeros(size(img));
  for i = 2:N - 1
    for j = 2:M - 1
      [pixel, v] = get4Neighborhood(img, i, j);
      v = [v, pixel];
      if (prod(v == tag) > 0)
          interImg(i, j) = 1;
      end
    end
  end
end

function [pixel, neighborhood] = get4Neighborhood(img, i, j)
% returns the pixle at i, j position and it's 4 neighborhood.
  pixel = img(i, j);
  neighborhood = [img(i - 1, j), img(i, j - 1), img(i + 1, j), img(i, j + 1)];
end
