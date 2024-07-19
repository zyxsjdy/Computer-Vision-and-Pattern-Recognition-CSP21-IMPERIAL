%% Initialization
clc;
clear;
close all;

%%
% I1_colour = imresize(imread('3.jpg'),0.15);
% I2_colour = imresize(imread('4.jpg'),0.15);

I1_colour = imresize(imread('FD1.jpg'),1);
I2_colour = imresize(imread('FD2.jpg'),1);

I1 = rgb2gray(I1_colour);
I2 = rgb2gray(I2_colour);

points1 = detectHarrisFeatures(I1);
points2 = detectHarrisFeatures(I2);

[features1,valid_points1] = extractFeatures(I1,points1);
[features2,valid_points2] = extractFeatures(I2,points2);

%plot the selected keypoints
figure;imshow(I1);hold on
plot(valid_points1);
figure;imshow(I2);hold on
plot(valid_points2);

indexPairs = matchFeatures(features1,features2);

matchedPoints1 = valid_points1(indexPairs(:,1),:); 
matchedPoints2 = valid_points2(indexPairs(:,2),:);

%[fLMedS,inliers]=estimateFundamentalMatrix(matchedPoints1,matchedPoints2,'NumTrials',2000);

[fLMedS, inliers] = estimateFundamentalMatrix(matchedPoints1,matchedPoints2, 'Method' , 'RANSAC');
%[fLMedS, inliers] = estimateFundamentalMatrix(matchedPoints1,matchedPoints2, 'Method' , 'Norm8Point');

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

%figure;
%showMatchedFeatures(I1_colour,I2_colour,matchedPoints1,matchedPoints2,'montage','PlotOptions',{'ro','go','y--'});
%title('Putative point matches');
%figure;
%showMatchedFeatures(I1_colour, I2_colour, matchedPoints1(inliers,:),matchedPoints2(inliers,:),'montage','PlotOptions',{'ro','go','y--'});
%title('Point matches after outliers were removed');