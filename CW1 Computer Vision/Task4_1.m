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

%indexPairs = indexPairs(1:6,:);

matchedPoints1=valid_points1(indexPairs(:,1),:);
matchedPoints2=valid_points2(indexPairs(:,2),:);

figure;showMatchedFeatures(I1_colour,I2_colour,matchedPoints1,matchedPoints2,'montage');

[tform,inliers]=estimateGeometricTransform2D(matchedPoints1,matchedPoints2,'projective');


figure;showMatchedFeatures(I1_colour,I2_colour,matchedPoints1.Location(inliers,:),matchedPoints2.Location(inliers,:),'montage');

H=tform.T;
H

pointsimg1 = matchedPoints1.Location(inliers,:);
pointsimg2 = matchedPoints2.Location(inliers,:);

z_axis=ones(length(pointsimg2(:,1)),1);
pn2=[pointsimg2 z_axis];
pn1=[pointsimg1 z_axis];

pn1_tr=pn1.';
H2=H.';

%好笨的代码
projectI1toI2=zeros(length(z_axis),3);
for c=1:length(z_axis)
    projectI1toI2(c,1)=H2(1,:)*pn1_tr(:,c);
    projectI1toI2(c,2)=H2(2,:)*pn1_tr(:,c);
    projectI1toI2(c,3)=H2(3,:)*pn1_tr(:,c);
end

%这里的误差值是什么呢
MSE=immse(double(pn2),projectI1toI2);
total_number_of_pixels=65.535*65.535;
MSE_normalised=MSE./total_number_of_pixels;
fprintf('MSE: %.10f\n',MSE)
fprintf('MSE per pixel: %.10f\n',MSE_normalised)