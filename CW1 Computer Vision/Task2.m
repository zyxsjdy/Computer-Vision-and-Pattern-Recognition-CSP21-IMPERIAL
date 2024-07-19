%% Initialization
clc;
clear;
close all;

%%
% I1_colour = imresize(imread('3.jpg'),0.15);
% I2_colour = imresize(imread('4.jpg'),0.15);

I1_colour = imresize(imread('HG1_ORI.jpg'),0.15);
I2_colour = imresize(imread('HG1_X1.2+ROT RIGHT.jpg'),0.15);

I1 = rgb2gray(I1_colour);
I2 = rgb2gray(I2_colour);

points1=detectHarrisFeatures(I1);
points2=detectHarrisFeatures(I2);

[features1,valid_points1]=extractFeatures(I1,points1);
[features2,valid_points2]=extractFeatures(I2,points2);

%plot the selected keypoints
figure;imshow(I1);hold on
plot(valid_points1);
figure;imshow(I2);hold on
plot(valid_points2);

indexPairs=matchFeatures(features1,features2);

matchedPoints1=valid_points1(indexPairs(:,1),:);
matchedPoints2=valid_points2(indexPairs(:,2),:);

figure;showMatchedFeatures(I1_colour,I2_colour,matchedPoints1,matchedPoints2,'montage');



