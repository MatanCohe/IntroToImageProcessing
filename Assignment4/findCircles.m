 function [circles,cImg] = findCircles(img)
  [edges, tgTeta] = edgeDetect(img);
  tgTeta(isnan(tgTeta)) = 0;
  [R, C] = size(img);
  maxR = max(R, C);
  count = zeros(C, R, maxR);
  for y = 1:R
    for x = 1:C
      if edges(y, x) == 1
        count = countCircles(x, y, maxR, R, C, tgTeta, count);
      end
    end
  end
  CONV_DIM = 5;
  count = convn(count, ones(CONV_DIM, CONV_DIM, CONV_DIM)/(CONV_DIM^3), 'same');
  circles = zeros(size(img));
  cImg = img;
  counter = 0;
  circles = [];
  minR = 5;
  for r = minR:maxR
    for cx = 1:C
      for cy = 1:R
        if count(cx, cy, r) >   r/20 && isMaxCircle(cx, cy, r, count, minR)
          fprintf('Circle %d: %d, %d, %d\n',[counter],[cx],[cy],[r]);
          counter = counter + 1;
          circles = [circles; [cx, cy, r]];
          
          cImg = drawCircle(cx, cy, r, cImg);
          
        end
      end
    end
   end
end


function [count] = countCircles(x, y, maxR, R, C, tgTeta, count)
  m = abs(tgTeta(y, x)); 
  if  m <= 1
    for cx = x:min(x + maxR, C)
      cy = tgTeta(y, x) * (cx - x) + y;
      r = round(hypot(cx - x, cy - y));
      cy = round(cy);
      if 0 < cy && cy < R && 0 < r && r <= maxR
        count(cx, cy, r) = count(cx, cy, r) + 1;
      end
    end
    
    for cx = x:-1:max(x - maxR, 1)
      cy = tgTeta(y, x) * (cx - x) + y;
      r = round(hypot(cx - x, cy - y));
      cy = round(cy);
      if 0 < cy && cy < R && 0 < r && r <= maxR
        count(cx, cy, r) = count(cx, cy, r) + 1;
      end
    end
  
  else
    for cy = y:min(y + maxR, R)
      cx = (cy-y)/tgTeta(y, x) + x;
      r = round(hypot(cx - x, cy - y));
      cx = round(cx);
      if 0 < cx && cx < R && 0 < r && r <= maxR
        count(cx, cy, r) = count(cx, cy, r) + 1;
      end
    end
  
    for cy = y:-1:max(y - maxR, 1)
      cx = (cy-y)/tgTeta(y, x) + x;
      r = round(hypot(cx - x, cy - y));
      cx = round(cx);
      if 0 < cx && cx < R && 0 < r && r <= maxR
        count(cx, cy, r) = count(cx, cy, r) + 1;
      end
    end
  end
end


function [res] = isMaxCircle(cx, cy, r, count, minR)
  NEIBOURHOOD_SIZE = 20;
  [maxCX, maxCY, maxR] = size(count);
  cxLow = max(cx - NEIBOURHOOD_SIZE, 1);
  cxHigh = min(cx + NEIBOURHOOD_SIZE, maxCX);
  cyLow = max(cy - NEIBOURHOOD_SIZE, 1);
  cyHigh = min(cy + NEIBOURHOOD_SIZE, maxCY);
  rLow = max(r - NEIBOURHOOD_SIZE, minR);
  rHigh = min(r + NEIBOURHOOD_SIZE, maxR);
  
  neibourhood = count(cxLow:cxHigh, cyLow:cyHigh, rLow:rHigh);
  isExsistBigger = count(cx, cy, r)  < max(neibourhood(:));
  res = ~isExsistBigger;
end

function [cImg] = drawCircle(cx,cy,r, img)
  cImg = img;
  [R, C] = size(img);
  for theta = 0:1/r:2*pi
    point = round([cx,cy] + [r*cos(theta),r*sin(theta)]);
    i = point(2);
    j = point(1);
    if 0 < i && i <= R && 0 < j && j < C
      cImg(i, j) = 1;
    end
  end
end
