function [cImg1,cImg2,cImg3,cImg4] = fftClean(img1,img2,img3,img4)
%fftClean   Cleans img1,img2,img3,img4 in the frequency domain using fft.
%
%   INPUT PARAMETERS
%       img1     -   matrix of doubles.
%       img2     -   matrix of doubles.
%       img3     -   matrix of doubles.
%       img4     -   matrix of doubles.
%   
%
%   OUTPUT PARAMETERS
%       cImg1     -   matrix of doubles.
%       cImg2     -   matrix of doubles.
%       cImg3     -   matrix of doubles.
%       cImg4     -   matrix of doubles.
  cImg1 = cleanImg1(img1);
  cImg2 = cleanImg2(img2);
  cImg3 = cleanImg3(img3);
  cImg4 = cleanImg4(img4);
end

function [cImg] = cleanImg1(img)
%cleanImg1   This function claen first image.
%
%   INPUT PARAMETERS
%       img     -   matrix of doubles.
%   
%
%   OUTPUT PARAMETERS
%       cImg     -   matrix of doubles.
  ni = fftshift(fft2(img));
  
  ni(281, 229) = 0;
  ni(253, 213) = 0;
  
  cImg = ifft2(ifftshift(ni));
end

function [cImg2] = cleanImg2(img)
%cleanImg2   This function claen second image.
%
%   INPUT PARAMETERS
%       img     -   matrix of doubles.  
%   
%   OUTPUT PARAMETERS
%       cImg2     -   matrix of doubles.
  ni = fftshift(fft2(img));
  
  ni(241 - 10, 166 + 9) = 0;
  ni(241 + 10, 166 - 9) = 0;
  
  cImg2 = ifft2(ifftshift(ni));
end


function [cImg3] = cleanImg3(img)
%cleanImg3   This function claen third image.
%
%   INPUT PARAMETERS
%       img     -   matrix of doubles. 
%   
%   OUTPUT PARAMETERS
%       cImg3     -   matrix of doubles.
  ni = fftshift(fft2(img));
  
  ni(190, 125 + 13) = 0;
  ni(190, 125 - 13) = 0;
  ni(190 + 16, 125) = 0;
  ni(190 - 16, 125) = 0;
  ni(190 - 16, 125 + 13) = 0;
  ni(190 + 16, 125 + 13) = 0;
  ni(190 + 16, 125 - 13) = 0;
  ni(190 - 16, 125 - 13) = 0;
 
  cImg3 = ifft2(ifftshift(ni));
end


function [cImg4] = cleanImg4(img)
%cleanImg4   This function claen fourth image.
%
%   INPUT PARAMETERS
%       img     -   matrix of doubles.  
%
%   OUTPUT PARAMETERS
%       cImg4   -   matrix of doubles.
  ni = fftshift(fft2(img));
  
  ni(300, 252 + 18) = 0;
  ni(300, 252 - 18) = 0;
  ni(300 - 11, 252) = 0;
  ni(300 + 11, 252) = 0;
  
  cImg4 = ifft2(ifftshift(ni));
end


