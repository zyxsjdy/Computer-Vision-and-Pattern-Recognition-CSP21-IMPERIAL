%Initialization
clc;
clear;
close all;

%%
I1_colour = imresize(imread('5.1.jpg'),0.15);
I2_colour = imresize(imread('5.2.jpg'),0.15);
I1 = rgb2gray(I1_colour);
I2 = rgb2gray(I2_colour);

points1=detectHarrisFeatures(I1);
points2=detectHarrisFeatures(I2);

[features1,valid_points1]=extractFeatures(I1,points1);
[features2,valid_points2]=extractFeatures(I2,points2);
indexPairs=matchFeatures(features1,features2);

matchedPoints1=valid_points1(indexPairs(:,1),:); 
matchedPoints2=valid_points2(indexPairs(:,2),:);
figure;showMatchedFeatures(I1_colour,I2_colour,matchedPoints1,matchedPoints2,'montage');




[fLMedS,inliers] = estimateFundamentalMatrix(matchedPoints1,matchedPoints2,...
   'Method','Norm8Point');
%[fLMedS,inliers]=estimateFundamentalMatrix(matchedPoints1,matchedPoints2,'NumTrials',20000);
%f
%fLMedS
figure;
subplot(121);
imshow(I1_colour);
title('Inliers and Epipolar Lines in the First Image');hold on;
plot(matchedPoints1.Location(inliers,1),matchedPoints1.Location(inliers,2),'go');
epiLines=epipolarLine(fLMedS',matchedPoints2.Location(inliers,:));
points=lineToBorderPoints(epiLines,size(I1_colour));
line(points(:,[1,3])',points(:,[2,4])');

subplot(122);
imshow(I2_colour);
title('Inliers and Epipolar Lines in the Second Image');hold on;
plot(matchedPoints2.Location(inliers,1),matchedPoints2.Location(inliers,2),'go');
epiLines=epipolarLine(fLMedS,matchedPoints1.Location(inliers,:));
points=lineToBorderPoints(epiLines,size(I2_colour));
line(points(:,[1,3])',points(:,[2,4])');
truesize;

[t1, t2] = estimateUncalibratedRectification(fLMedS,matchedPoints1,...
   matchedPoints2,size(I2_colour));


theta =-0;
R= [cosd(theta) -sind(theta) 0; ...
    sind(theta) cosd(theta) 0; ...
    0 0 1];
%R=projective2d(R);
%I1Rect = imwarp(I1Rect,R);
%I2Rect = imwarp(I2Rect,R);
t1=t1*R;
t2=t2*R;
[I1Rect,I2Rect] = rectifyStereoImages(I1_colour,I2_colour,t1,t2);
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
   'Method','Norm8Point');
figure;
imshowpair(I1Rect,I2Rect,'montage');
hold on;

a = 542;
plot(matchedPoints1.Location(inliers,1),matchedPoints1.Location(inliers,2),'go');
plot(matchedPoints2.Location(inliers,1)+a,matchedPoints2.Location(inliers,2),'go');

epiLines=epipolarLine(fLMedS',matchedPoints2.Location(inliers,:));
points=lineToBorderPoints(epiLines,size(I1Rect));

point_1(:,1) = [points(:,1); points(:,1)+a];
point_1(:,2) = [points(:,3); points(:,3)+a];
point_2(:,1) = [double(matchedPoints1.Location(:,2)); double(matchedPoints2.Location(:,2))];
point_2(:,2) = point_2(:,1);
line(point_1',point_2');
truesize;


























