% This demo allows you to spatially calibrate your image and then make distance or area measurements.
function spatial_calibration_demo()

global originalImage;

clc;    
close all;  
workspace;  
format long g;
format compact;
fontSize = 20;




folder = fullfile(matlabroot, '\toolbox\images\imdemos');
button = menu('Use which demo image?', 'CameraMan', 'Moon', 'Eight', 'Coins', 'Peppers', 'My own...', 'Exit');
switch button
	case 1
		baseFileName = 'cameraman.tif';
	case 2
		baseFileName = 'moon.tif';
	case 3
		baseFileName = 'eight.tif';
	case 4
		baseFileName = 'coins.png';
	case 5
		baseFileName = 'peppers.png';
	case 6
		
		defaultFileName = fullfile(cd, '*.*');
        
		[baseFileName, folder] = uigetfile(defaultFileName, 'Select an image file');
		if baseFileName == 0
			
			return;
		end
	case 7
		return;
end


fullFileName = fullfile(folder, baseFileName);


originalImage = imread(fullFileName);

[rows, columns, numberOfColorBands] = size(originalImage);

figureHandle = figure;
subplot(1,2, 1);
imshow(originalImage, []);
axis on;
title('Original Image', 'FontSize', fontSize);

set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

set(gcf,'name','Demo by ImageAnalyst','numbertitle','off')

message = sprintf('First you will be doing spatial calibration.');
reply = questdlg(message, 'Calibrate spatially', 'OK', 'Cancel', 'OK');
if strcmpi(reply, 'Cancel')
	
	return;
end
button = 1; 

while button ~= 4
	if button > 1
		
		button = menu('Select a task', 'Calibrate', 'Measure Distance', 'Measure Area', 'Exit Demo');
	end
	switch button
		case 1
			success = Calibrate();
			
			while ~success
				success = Calibrate();
			end
			

			button = 99;
		case 2
			DrawLine();
		case 3
			DrawArea();
		otherwise
			close(figureHandle);
			break;
	end
end

end

%=====================================================================
function success = Calibrate()
global lastDrawnHandle;
global calibration;
try
	success = false;
	instructions = sprintf('Left click to anchor first endpoint of line.\nRight-click or double-left-click to anchor second endpoint of line.\n\nAfter that I will ask for the real-world distance of the line.');
	title(instructions);
	msgboxw(instructions);
	
	[cx, cy, rgbValues, xi,yi] = improfile(1000);
	
	rgbValues = squeeze(rgbValues);
	distanceInPixels = sqrt( (xi(2)-xi(1)).^2 + (yi(2)-yi(1)).^2);
	if length(xi) < 2
		return;
	end
	
	hold on;
	lastDrawnHandle = plot(xi, yi, 'y-', 'LineWidth', 2);
	
	
	userPrompt = {'Enter real world units (e.g. microns):','Enter distance in those units:'};
	dialogTitle = 'Specify calibration information';
	numberOfLines = 1;
	def = {'microns', '500'};
	answer = inputdlg(userPrompt, dialogTitle, numberOfLines, def);
	if isempty(answer)
		return;
	end
	calibration.units = answer{1};
	calibration.distanceInPixels = distanceInPixels;
	calibration.distanceInUnits = str2double(answer{2});
	calibration.distancePerPixel = calibration.distanceInUnits / distanceInPixels;
	success = true;
	
	message = sprintf('The distance you drew is %.2f pixels = %f %s.\nThe number of %s per pixel is %f.\nThe number of pixels per %s is %f',...
		distanceInPixels, calibration.distanceInUnits, calibration.units, ...
		calibration.units, calibration.distancePerPixel, ...
		calibration.units, 1/calibration.distancePerPixel);
	uiwait(msgbox(message));
catch ME
	errorMessage = sprintf('Error in function Calibrate().\nDid you first left click and then right click?\n\nError Message:\n%s', ME.message);
	fprintf(1, '%s\n', errorMessage);
	WarnUser(errorMessage);
end

return;	
end

%=====================================================================

function DrawLine()
global lastDrawnHandle;
global calibration;
try
	fontSize = 14;
	
	instructions = sprintf('Draw a line.\nFirst, left-click to anchor first endpoint of line.\nRight-click or double-left-click to anchor second endpoint of line.\n\nAfter that I will ask for the real-world distance of the line.');
	title(instructions);
	msgboxw(instructions);
	subplot(1,2, 1); 
	[interpolatedXCoords,interpolatedYCoords, rgbValues, userClicked_xi,userClicked_yi] = improfile(1000);
	
	if length(userClicked_xi) < 2
		return;
	end
	
	
	theImage = getimage(gca); 
	
	lineLength = round(sqrt((userClicked_xi(1)-userClicked_xi(2))^2 + (userClicked_yi(1)-userClicked_yi(2))^2))
	[interpolatedXCoords,interpolatedYCoords, rgbValues] = improfile(theImage, userClicked_xi, userClicked_yi, lineLength);
	
	
	rgbValues = squeeze(rgbValues);
	
	distanceInPixels = sqrt( (userClicked_xi(2)-userClicked_xi(1)).^2 + (userClicked_yi(2)-userClicked_yi(1)).^2);
	
	distanceInRealUnits = distanceInPixels * calibration.distancePerPixel;
	
	
	hold on;
	lastDrawnHandle = plot(userClicked_xi, userClicked_yi, 'y-', 'LineWidth', 2);
	
	
	subplot(1,2,2);
	[rows, columns] = size(rgbValues);
	if columns == 3
		
		plot(rgbValues(:, 1), 'r-', 'LineWidth', 2);
		hold on;
		plot(rgbValues(:, 2), 'g-', 'LineWidth', 2);
		plot(rgbValues(:, 3), 'b-', 'LineWidth', 2);
		title('Red, Green, and Blue Profiles along the line you just drew.', 'FontSize', 14);
	else
		
		plot(rgbValues, 'k-', 'LineWidth', 2);
	end
	xlabel('X', 'FontSize', fontSize);
	ylabel('Gray Level', 'FontSize', fontSize);
	title('Intensity Profile', 'FontSize', fontSize);
	grid on;
	
	
	txtInfo = sprintf('Distance = %.1f %s, which = %.1f pixels.', ...
		distanceInRealUnits, calibration.units, distanceInPixels);
	msgboxw(txtInfo);
	
	fprintf(1, '%\n', txtInfo);
	
catch ME
	errorMessage = sprintf('Error in function DrawLine().\n\nError Message:\n%s', ME.message);
	fprintf(1, '%s\n', errorMessage);
	WarnUser(errorMessage);
end
end 

%=====================================================================
function DrawArea()
global originalImage;
global lastDrawnHandle;
global calibration;
try
	txtInfo = sprintf('Left click to anchor vertices.\nDouble left click to anchor final point of polygon.');
	title(txtInfo);
	msgboxw(txtInfo);
	
	
	[rows, columns, numberOfColorBands] = size(originalImage);
	
	
	if numberOfColorBands > 1
		grayImage = rgb2gray(originalImage);
	else
		grayImage = originalImage;
	end
	
	subplot(1,2, 1); 
	
	[maskImage, xi, yi] = roipolyold();
	
	
	hold on;
	lastDrawnHandle = plot(xi, yi, 'r-', 'LineWidth', 2);
	numberOfPixels = sum(maskImage(:));
	area = numberOfPixels * calibration.distancePerPixel^2;
	
	
	mean_GL = mean(grayImage(maskImage)); 
	
	
	txtInfo = sprintf('Area = %8.1f square %s.\nMean gray level = %.2f.', ...
		area, calibration.units, mean_GL);
	fprintf(1,'%s\n', txtInfo);
	title(txtInfo, 'FontSize', 14);
	
	
	if numberOfColorBands >= 3
		
		redPlane = double(originalImage(:, :, 1));
		greenPlane = double(originalImage(:, :, 2));
		bluePlane = double(originalImage(:, :, 3));
		mean_RGB_GL(1) = mean(redPlane(maskImage));
		mean_RGB_GL(2) = mean(greenPlane(maskImage));
		mean_RGB_GL(3) = mean(bluePlane(maskImage));
		fprintf('%s\nRed mean = %.2f\nGreen mean = %.2f\nBlue mean = %.2f', ...
			txtInfo, mean_RGB_GL(1), mean_RGB_GL(2), mean_RGB_GL(3));
	end
	
	
	[pixelCount, grayLevels] = imhist(grayImage(maskImage));
	subplot(1,2, 2); 
	cla;
	bar(grayLevels, pixelCount);
	grid on;
	caption = sprintf('Histogram within area.    Mean gray level = %.2f', mean_GL);
	title(caption, 'FontSize', 14);
	xlim([0 grayLevels(end)]);
	
	hold on;
	maxYValue = ylim;
	line([mean_GL, mean_GL], [0 maxYValue(2)], 'Color', 'r', 'linewidth', 2);
catch ME
	errorMessage = sprintf('Error in function DrawArea().\n\nError Message:\n%s', ME.message);
	fprintf(1, '%s\n', errorMessage);
	WarnUser(errorMessage);
end

end


function msgboxw(message)
uiwait(msgbox(message));
end

function WarnUser(message)
uiwait(msgbox(message));
end