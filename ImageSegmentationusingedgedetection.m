clc

close all

x=imread('14885350686496464.jpg');

figure;

imshow(x);

title('Original Image');

mask_image=bwareaopen(imopen(imfill(imclose(edge(rgb2gray(x),'canny'),strel('line',3,0)),'holes'),strel(ones(3,3))),1500);
figure;

imshow(mask_image); title('Mask Image');

red_channel=x(:,:,1).*uint8(mask_image);
green_channel=x(:,:,2).*uint8 (mask_image);

blue_channel=x(:,:,3).*uint8(mask_image); 
op=cat(3,red_channel,green_channel,blue_channel);

figure;

imshow(op); title('Output Image')