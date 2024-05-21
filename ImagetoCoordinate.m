clear
close all

% Load the image
originalImage = imread('image.png');

% Convert the image to grayscale
grayImage = rgb2gray(originalImage);

% Binarize the image
binaryImage = imbinarize(grayImage);

% Extract the contours
boundaries = bwboundaries(binaryImage);

% Number of contours
numBoundaries = length(boundaries);

% Draw each contour
figure;
imshow(binaryImage);
hold on;
for k = 1:length(boundaries)
    boundary = boundaries{k};
    plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
end

% Number of data points to extract
numSamples = 200;

% Generate indices for extracting data points
sampleIndices = round(linspace(1, size(boundary, 1), numSamples));

% Extracted data points
image_data = boundary(sampleIndices, :);

% Save the extracted data
save('image_coordinate.mat', "image_data")


