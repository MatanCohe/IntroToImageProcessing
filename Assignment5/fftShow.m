function [ sImg ] = fftShow(img)
%   This function displays the given fft image

    sImg = log(abs(img)+1);
    sImg = sImg/max(max(sImg));
    imshow(sImg)

end

