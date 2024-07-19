%Initialization
clc;
clear;
close all;

%%
I1_colour = imresize(imread('5.1.jpg'),0.15);
I2_colour = imresize(imread('5.2.jpg'),0.15);

% I1_colour = imresize(imread('FD1.jpg'),1);
% I2_colour = imresize(imread('FD2.jpg'),1);

imshowpair(I1_colour,I2_colour,'montage');

I1 = rgb2gray(I1_colour);
I2 = rgb2gray(I2_colour);

points1=detectHarrisFeatures(I1);
points2=detectHarrisFeatures(I2);

[features1,valid_points1]=extractFeatures(I1,points1);
[features2,valid_points2]=extractFeatures(I2,points2);
indexPairs=matchFeatures(features1,features2);

matchedPoints1=valid_points1(indexPairs(:,1),:); 
matchedPoints2=valid_points2(indexPairs(:,2),:);

%[fLMedS,inliers]=estimateFundamentalMatrix(matchedPoints1,matchedPoints2,'NumTrials',4000);
%[fLMedS, inliers] = estimateFundamentalMatrix(matchedPoints1,matchedPoints2, 'Method' , 'RANSAC');
[fLMedS, inliers] = estimateFundamentalMatrix(matchedPoints1,matchedPoints2, 'Method' , 'Norm8Point');

figure;showMatchedFeatures(I1_colour,I2_colour,matchedPoints1.Location(inliers,:),matchedPoints2.Location(inliers,:),'montage');

fLMedS
figure;
subplot(121);
imshow(I1_colour);
hold on;
plot(matchedPoints1.Location(inliers,1),matchedPoints1.Location(inliers,2),'go');
epiLines=epipolarLine(fLMedS',matchedPoints2.Location(inliers,:));
points=lineToBorderPoints(epiLines,size(I1_colour));
line(points(:,[1,3])',points(:,[2,4])');

subplot(122);
imshow(I2_colour);
hold on;
plot(matchedPoints2.Location(inliers,1),matchedPoints2.Location(inliers,2),'go');
epiLines=epipolarLine(fLMedS,matchedPoints1.Location(inliers,:));
points=lineToBorderPoints(epiLines,size(I2_colour));
line(points(:,[1,3])',points(:,[2,4])');
truesize;

[t1, t2] = estimateUncalibratedRectification(fLMedS,matchedPoints1.Location(inliers,:),matchedPoints2.Location(inliers,:),size(I2_colour));

[I1Rect,I2Rect] = rectifyStereoImages(I1_colour,I2_colour,t1,t2,'OutputView','full');
figure
imshowpair(I1Rect,I2Rect,'montage');

I1=rgb2gray(I1Rect);
I2=rgb2gray(I2Rect);
points1=detectHarrisFeatures(I1);
points2=detectHarrisFeatures(I2);

[features1,valid_points1]=extractFeatures(I1,points1);
[features2,valid_points2]=extractFeatures(I2,points2);
indexPairs=matchFeatures(features1,features2);

matchedPoints1=valid_points1(indexPairs(:,1),:); 
matchedPoints2=valid_points2(indexPairs(:,2),:);
figure;showMatchedFeatures(I1Rect,I2Rect,matchedPoints1,matchedPoints2,'montage');


[fLMedS,inliers] = estimateFundamentalMatrix(matchedPoints1,matchedPoints2,...
   'Method','RANSAC');
figure;
imshowpair(I1Rect,I2Rect,'montage');
hold on;

a = 754;
plot(matchedPoints1.Location(inliers,1),matchedPoints1.Location(inliers,2),'go');
plot(matchedPoints2.Location(inliers,1)+a,matchedPoints2.Location(inliers,2),'go');

epiLines=epipolarLine(fLMedS',matchedPoints2.Location(inliers,:));
points=lineToBorderPoints(epiLines,size(I1Rect));

point_1(:,1) = [points(:,1); points(:,1)+a];
point_1(:,2) = [points(:,3); points(:,3)+a];
point_2(:,1) = [double(matchedPoints1.Location(inliers,2)); double(matchedPoints2.Location(inliers,2))];
point_2(:,2) = point_2(:,1);
line(point_1',point_2');
truesize;


%% Get Disparity Map1

J1 = im2gray(I1Rect);
J2 = im2gray(I2Rect);
disparityRange = [0 16];

%disparityMap = disparity(J1,J2,'UniquenessThreshold',20,'DisparityRange',disparityRange);
%disparityMap = disparitySGM(J1,J2);
disparityMap = disparitySGM(J1,J2,'DisparityRange',disparityRange,'UniquenessThreshold',20);

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



















