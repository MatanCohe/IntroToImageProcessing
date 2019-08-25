# Introduction to digital image processing.

## About
This project shows ideas that are in my opinion a must for anyone who wish to understand digital image processing.

Requirements:
*  knowledge Calculus linear algebra and probability.
* Matlab or Octave with image processing packages.

### Assignment 1 - Histogram shape.

In these assignment we wrote a function that receives a gray-scale image and returns a gray-scale image obtained by applying the histogram shape algorithm on this image where the histogram of the result image should match the histogram of the destimg.


#### The algorithm:

In order to implement the histShape algorithm we must first know more about:
1. [Histogram](https://en.wikipedia.org/wiki/Histogram "Histogram Wiki page")
1. [Cumulative histogram](https://en.wikipedia.org/wiki/Histogram#Cumulative_histogram "Cumulative histogram Wiki section")
1. [Histogram equalization](https://en.wikipedia.org/wiki/Histogram_equalization "Histogram equalization Wiki page")

#### Matlab code
```Matlab
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
```

[For the rest of the code click here.](Assignment1/histShape.m "histShape code")

<!-- ##### Histograms:

>A histogram is an accurate representation of the distribution of numerical data. It is an estimate of the probability distribution of a >continuous variable and was first introduced by Karl Pearson. It differs from a bar graph, in the sense that a bar graph relates two >variables, but a histogram relates only one. To construct a histogram, the first step is to "bin" (or "bucket") the range of values—that >is, divide the entire range of values into a series of intervals—and then count how many values fall into each interval. The bins are >usually specified as consecutive, non-overlapping intervals of a variable. The bins (intervals) must be adjacent, and are often (but are >not required to be) of equal size.

##### Cumulative histogram:

>A cumulative histogram is a mapping that counts the cumulative number of observations in all of the bins up to the specified bin.

##### Histogram equalization:


##### Histogram shape: -->

### Example:
#### Source image:  
![alt text](Assignment1/Demo/ImagesToDisplayOnWebBrowser/darkimg.jpg "srcImg")

#### Destination image: 
![alt text](Assignment1/Demo/ImagesToDisplayOnWebBrowser/flatHistShape.jpg "destImg")

```Matlab
% Let srcimg be the Source image
% Let destimg be the image we wish to match it's histogram.
srcimg = imread('darkimg.tiff');
destimg - imread('flatHist.tiff');
output = histShape(srcimg, destimg);
imshow(srcimg); figure; imshow(destimg); figure; imshow(output);
```

#### Output image: 
![alt text](Assignment1/Demo/ImagesToDisplayOnWebBrowser/output.jpg "outputImg")



### Assignment 2 - Enhancing images
This assignment was about image enhancement from different types of noise from an image.
More about the topic can be found [Here](http://www.cs.haifa.ac.il/~dkeren/ip/lecture3.pdf)

### Directional smoothing

Write a function which receive an image and add gaussian noise to the image with mean value 0, and var=0.004, and then try to enhance the image using the directional smoothing. It is up to you, to choose the right directional filters (size, orientation, and values). On the help of this function you should write which filters does this function use. The function should return 2 images. the first one is the enhanced image (eImg), and the second one is the noisy image (nImg).
Format of Matlab function :

```Matlab
function [eImg,nImg] = gaussEnhance(img)
```
#### The algorithm:

#### Matlab code

### Example:
#### Source image: