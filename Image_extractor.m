clc;clear;

im = imread("14885350686496464.jpg");
info = imfinfo('14885350686496464.jpg');

im=rgb2gray(im);
figure;
imshow(im);
figure;
imhist(im);