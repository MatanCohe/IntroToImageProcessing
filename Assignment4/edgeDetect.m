function [newImg, tgTeta] = edgeDetect(img)
  [dx, dy] = gaussian(img,1);
  tgTeta = dy ./ dx;
  [labels] = computeLabels(tgTeta);
  G = hypot(dx, dy);
  interImg = nonMaxSupress(G, labels);
  newImg = hysteresis(interImg);
endfunction


function [Dx,Dy] = gaussian(img,s)
  M = zeros(5);
  Mx = zeros(5);
  My = zeros(5);
  for i=1:5
    for j=1:5
      M = 1/sqrt(2*pi)/s^2 * exp(-((i-3)^2+(j-3)^2)/(2*s^2));
      Mx(i,j) = 1/sqrt(2*pi)/s^3 * exp(-((i-3)^2+(j-3)^2)/(2*s^2))*(j-3);
      My(i,j) = 1/sqrt(2*pi)/s^3 * exp(-((i-3)^2+(j-3)^2)/(2*s^2))*(i-3);
    endfor
  endfor
  Mx = Mx / sum(sum(M));
  My = My / sum(sum(M));
  Dx = conv2(img, Mx, 'same');
  Dy = conv2(img, My, 'same');
endfunction

function [newImg] = hysteresis(G)
  high = mean(G(:)) * 4;
  low = high * 0.8;
  [R, C] = size(G);
  newImg = zeros(R, C);
  for i = 2:R - 1
    for j = 2:C - 1
      newImg(i, j) = newImg(i, j) || G(i, j) > high;
      newImg(i, j) = newImg(i,j) || (G(i, j) > low && any(getNeighbors(newImg, i, j)) == 1); 
    endfor
  endfor
  
  for i = R-1:-1:2
    for j = C-1:-1:2
      newImg(i, j) = newImg(i, j) || G(i, j) > high;
      newImg(i, j) = newImg(i,j) || (G(i, j) > low && any(getNeighbors(newImg, i, j)) == 1); 
    endfor
  endfor
endfunction

function [neighbors] = getNeighbors(img, i, j)
  neighbors = [img(i - 1, j - 1)
               img(i - 1, j)
               img(i - 1, j + 1)
               img(i, j - 1)
               img(i, j + 1)
               img(i + 1, j - 1)
               img(i + 1, j)
               img(i + 1, j + 1)];
endfunction


function [edges] = nonMaxSupress(G, labels)
  [R, C] = size(G);
  edges = zeros(size(G));
  for i = 2:R - 1
    for j = 2:C - 1
      label = labels(i, j);
      if (label == 0 && G(i, j) > G(i, j - 1) && G(i, j) > G(i, j + 1))
        edges(i, j) = G(i, j);
      endif
      
      if (label == 1 && G(i, j) > G(i + 1, j - 1) && G(i, j) > G(i - 1, j + 1))
        edges(i, j) = G(i, j);
      endif
      
      if (label == 2 && G(i, j) > G(i + 1, j) && G(i, j) > G(i - 1, j))
        edges(i, j) = G(i, j);
      endif
      
      if (label == 3 && G(i, j) > G(i - 1, j - 1) && G(i, j) > G(i + 1, j + 1))
        edges(i, j) = G(i, j); 
      endif
    endfor
  endfor
endfunction

function [smoothImg] = smoothImage(img)
  smoothImg = conv2(img, ones(5)/25, 'same');
endfunction


function [dx, dy] = computeGradient(img)
  derivativeVector = [-1, 1];
  dx = conv2(img, derivativeVector, 'same');
  dy = conv2(img, transpose(derivativeVector), 'same');
endfunction


function [labels] = computeLabels(tgTeta)
  [R, C] = size(tgTeta);
  labels = zeros(size(tgTeta));
  for i = 1:R
    for j = 1:C
      labels(i, j) = getLabel(tgTeta(i, j));
    endfor
  endfor
endfunction

function [label] = getLabel(tgTeta)
    
  label = 0;
    
  if (0.4142 < tgTeta && tgTeta < 2.4142)
    %label = 1;
    label = 3;
    
  elseif (2.4142 <= abs(tgTeta) || isinf(tgTeta))
    label = 2;
    
  elseif (-2.4142 < tgTeta && tgTeta <= -0.4142)
    %label = 3;
    label = 1;
    
  endif
  
endfunction
