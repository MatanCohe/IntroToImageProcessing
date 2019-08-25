function [newImg] = tagConnectedComponents(img)
% This function  finds the connected components in a binary image and returns a 
%matrix with the same size in which each connected componnent is tagged with a 
%different label in a sequential manner.
%
%   INPUT PARAMETERS
%       img     -   binary image
%       
%   OUTPUT PARAMETERS
%       newImg     -   matrix of doubles
%

  pImg = padarray (img, [1, 1], 'pre');
  [tagMatrix] = initTagMatrix(pImg);
  eqTable = makeEqTalbe(tagMatrix);
  cv = makeConvertionVector(eqTable);
  newImg = tagImage(tagMatrix, cv); 
  newImg = newImg(2:end, 2:end);
  
end


function [tagImg] = tagImage(tagMatrix, cv)
% Given a cv and tag matrix, convert the tag matix by the cv.
  tagImg = zeros(size(tagMatrix));
  [rows, cols, v] = find(tagMatrix);
  for i = 1:numel(v)
      tagImg(rows(i), cols(i)) = cv(v(i));
  end
end

function [cv] = makeConvertionVector(eqTable)
% Given a equivalence table returns the cv of the labels.
  nextTag = 2;
  cv = eqTable(1, :);
  for i = 1:numel(cv)
    if cv(i) == 0
      cv = cv + nextTag * eqTable(i, :);
      nextTag = nextTag + 1;
    end
  end
  
end

function [eqTable] = makeEqTalbe(tagMatrix)
% Computes the tag equivalence table.
  eqTable = initEqTable(tagMatrix);
  prevEqTable = eqTable;
  eqTable = min(1, eqTable * eqTable);
  while eqTable != prevEqTable
    prevEqTable = eqTable;
    eqTable = min(1, eqTable * eqTable);
  end
  
end


function [eqTable] = initEqTable(tagMatrix)
% Inital the equivalence table from a given tagMatrix.
  [rows, cols, v] = find(tagMatrix);
  [nUnique, _] = size(unique(v));
  eqTable = eye(nUnique);
  for k = 1:numel(v);
    i = rows(k);
    j = cols(k);
    label = v(k);
    leftNeighbor = tagMatrix(i-1, j);
    topNeighbor = tagMatrix(i, j-1);
    if leftNeighbor > 0
      eqTable(label, leftNeighbor) = eqTable(label, leftNeighbor) + 1;
      eqTable(leftNeighbor, label) = eqTable(leftNeighbor, label) + 1;
    end
    if topNeighbor > 0
      eqTable(label, topNeighbor) = eqTable(label, topNeighbor) + 1;
      eqTable(topNeighbor, label) = eqTable(topNeighbor, label) + 1;
    end
  end  
  eqTable = min(1, eqTable);
  
end

function [tagMatrix] = initTagMatrix(img)
% Given a binary image (img) make initial tag matrix of the pixles in the image.
% One should notice that the returned tag matrix is not necesserly the corrent 
% one as this function is just the first step toward the right tag matrix.   
  [N, M] = size(img);
  tag = 1;
  tagMatrix = zeros(size(img));
  
  for i = 2:N
    for j = 2:M
      if img(i, j) == 1
        if img(i-1, j) == 1 && img(i, j-1) == 1
          tagMatrix(i, j) = min(tagMatrix(i-1, j), tagMatrix(i, j-1));
        elseif img(i-1, j) == 1
          tagMatrix(i, j) = tagMatrix(i-1, j);
        elseif img(i, j-1) == 1
          tagMatrix(i, j)  = tagMatrix(i, j-1);
        else 
          tagMatrix(i, j) = tag;
          tag = tag + 1;
        end
      end
    end
  end  
  
end
