clc;clear;

im = imread("b1.jpg");
info = imfinfo('b1.jpg');


%figure
Im=rgb2gray(im);
%imshow(Im)

%figure
Im=imadjust(Im,[0.7 0.8]);
%imshow(Im)

BW = imbinarize(Im);
%figure
%mshow(BW)

%{ 
bwboundaries
[B,L] = bwboundaries(BW,4,'noholes');
figure
imshow(label2rgb(L, @gray, [.5 0 0]))
hold on

%{
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end
%}

boundary = B{1};

%
plot(boundary(:,2), boundary(:,1), 'b', 'LineWidth', 2)

%}

BW1 = edge(Im,'Canny');
imshow(BW1)

[row,column]=find(BW1);
val=[row column];

height=1780-min(val(:,1))

width=max(val(:,2))-min(val(:,2))

