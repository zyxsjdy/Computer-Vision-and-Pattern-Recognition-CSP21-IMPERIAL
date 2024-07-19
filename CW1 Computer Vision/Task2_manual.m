%% Initialization
clc;
clear;
close all;

%%
I1_colour = imresize(imread('HG1_ORI.jpg'),0.15);
I2_colour = imresize(imread('HG1_X1.2+ROT RIGHT.jpg'),0.15);

nums = 10;

figure
% subplot(1,2,1);
imshow(I1_colour); 
hold on;

img1 = zeros(nums,2);
img2 = zeros(nums,2);

for i = 1:nums
    enableDefaultInteractivity(gca); 
    [img1(i,1),img1(i,2)] = ginput(1);
    plot(img1(i,1),img1(i,2),'rx','LineWidth',1);
    text(img1(i,1),img1(i,2),num2str(i),'FontSize',14);
end

figure
% subplot(1,2,2);
imshow(I2_colour); 
hold on;
for i = 1:nums
    enableDefaultInteractivity(gca); 
    [img2(i,1),img2(i,2)] = ginput(1);
    plot(img2(i,1),img2(i,2),'g+','LineWidth',1);
    text(img2(i,1),img2(i,2),num2str(i),'FontSize',14);
end


figure;showMatchedFeatures(I1_colour,I2_colour,img1,img2,'montage');


[tform,inlierpoints1,inlierpoints2]=estimateGeometricTransform(img1,img2,'projective');

figure;showMatchedFeatures(I1_colour,I2_colour,inlierpoints1,inlierpoints2,'montage');

H=tform.T;
H


pointsimg1 = img1;
pointsimg2 = img2;

z_axis = ones(length(pointsimg2(:,1)),1);
pn2 = [pointsimg2 z_axis];
pn1 = [pointsimg1 z_axis];

pn1_tr = pn1.';
H2 = H.';

%project I1 to I2 - x2_1 = H*x1
projectI1toI2 = zeros(length(z_axis),3);
for c = 1:length(z_axis)
 projectI1toI2(c,1) = H2(1,:)*pn1_tr(:,c);
 projectI1toI2(c,2) = H2(2,:)*pn1_tr(:,c);
 projectI1toI2(c,3) = H2(3,:)*pn1_tr(:,c);
end


MSE = immse(double(pn2),projectI1toI2); %error from poj of 2 to 1
% total_number_of_pixels = 65.535*65.535; %jpg image pixels
% MSE_normalised = MSE ./ total_number_of_pixels;
fprintf('\n The mean-squared error is %0.4f\n', MSE);

