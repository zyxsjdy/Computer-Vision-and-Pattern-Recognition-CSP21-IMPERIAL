%Initialization
clc;
clear;
close all;

%%
I1 = imresize(imread('5.1.jpg'),0.15);
I2 = imresize(imread('5.2.jpg'),0.15);

% Convert to grayscale.
I1gray = rgb2gray(I1);
I2gray = rgb2gray(I2);

% figure;
% imshowpair(I1, I2,'montage');
% title('I1 (left); I2 (right)');
% figure;
% imshow(stereoAnaglyph(I1,I2));
% title('Composite Image (Red - Left Image, Cyan - Right Image)');
%
blobs1 = detectSURFFeatures(I1gray);
blobs2 = detectSURFFeatures(I2gray);

% figure;
% imshow(I1);
% hold on;
% plot(selectStrongest(blobs1, 30));
% title('Thirty strongest SURF features in I1');
% 
% figure;
% imshow(I2);
% hold on;
% plot(selectStrongest(blobs2, 30));
% title('Thirty strongest SURF features in I2');

%%
[features1, validBlobs1] = extractFeatures(I1gray, blobs1);
[features2, validBlobs2] = extractFeatures(I2gray, blobs2);

indexPairs = matchFeatures(features1, features2, 'Metric', 'SAD', ...
  'MatchThreshold', 5);

matchedPoints1 = validBlobs1(indexPairs(:,1),:);
matchedPoints2 = validBlobs2(indexPairs(:,2),:);

% figure;
% showMatchedFeatures(I1, I2, matchedPoints1, matchedPoints2);
% legend('Putatively matched points in I1', 'Putatively matched points in I2');


%%
[fMatrix, epipolarInliers, status] = estimateFundamentalMatrix(...
  matchedPoints1, matchedPoints2, 'Method', 'RANSAC', ...
  'NumTrials', 10000, 'DistanceThreshold', 0.1, 'Confidence', 99.99);

if status ~= 0 || isEpipoleInImage(fMatrix, size(I1)) ...
  || isEpipoleInImage(fMatrix', size(I2))
  error(['Either not enough matching points were found or '...
         'the epipoles are inside the images. You may need to '...
         'inspect and improve the quality of detected features ',...
         'and/or improve the quality of your images.']);
end

inlierPoints1 = matchedPoints1(epipolarInliers, :);
inlierPoints2 = matchedPoints2(epipolarInliers, :);

% figure;
% showMatchedFeatures(I1, I2, inlierPoints1, inlierPoints2);
% legend('Inlier points in I1', 'Inlier points in I2');

%%
i1_loc = inlierPoints1.Location;
i2_loc = inlierPoints2.Location;

[t1, t2] = estimateUncalibratedRectification(fMatrix, ...
  i1_loc, i2_loc, size(I2));
tform1 = projective2d(t1);
tform2 = projective2d(t2);

[I1Rect, I2Rect] = rectifyStereoImages(I1, I2, tform1, tform2);
% figure;
% imshow(stereoAnaglyph(I1Rect, I2Rect));
% title('Rectified Stereo Images (Red - Left Image, Cyan - Right Image)');

%% Get Disparity Map1

J1 = im2gray(I1Rect);
J2 = im2gray(I2Rect);
disparityRange = [0 16];

disparityMap = disparity(J1,J2,'UniquenessThreshold',20,'DisparityRange',disparityRange);

figure;
imshow(disparityMap,disparityRange);
title('Original Disparity Map');
colormap jet;
colorbar;
%% Get Disparity Map2

J1 = im2gray(I1Rect);
J2 = im2gray(I2Rect);
disparityRange = [0 16];

disparityMap = disparitySGM(J1,J2);
% disparityMap  = disparitySGM(J1,J2,'DisparityRange',disparityRange,'UniquenessThreshold',30);

figure;
imshow(disparityMap,disparityRange);
title('Original Disparity Map');
colormap jet;
colorbar;

%% Get Disparity Map3

J1 = im2gray(I1Rect);
J2 = im2gray(I2Rect);
disparityRange = [0 64];

disparityMap  = disparitySGM(J1,J2,'DisparityRange',disparityRange,'UniquenessThreshold',20);

figure;
imshow(disparityMap,disparityRange);
title('Original Disparity Map');
colormap jet;
colorbar;


%% Get Depth Map
depth = 26*15./disparityMap;
figure;
imshow(depth,disparityRange);
colormap jet;
colorbar;