close all;

%% Get Disparity Map1
A = stereoAnaglyph(I1Rect,I2Rect);
figure
imshow(A)

% hold on;
% nums = 4;
% img1 = zeros(nums,2);
% for i = 1:nums
%     enableDefaultInteractivity(gca); 
%     [img1(i,1),img1(i,2)] = ginput(1);
%     plot(img1(i,1),img1(i,2),'rx','LineWidth',1);
%     text(img1(i,1),img1(i,2),num2str(i),'FontSize',14);
% end

J1 = im2gray(I1Rect);
J2 = im2gray(I2Rect);
% figure
% imshowpair(J1,J2,'montage');

disparityRange = [0 24];

disparityMap = disparitySGM(J1,J2,'DisparityRange',disparityRange,'UniquenessThreshold',15);

figure;
imshow(disparityMap,disparityRange);
colormap jet;
colorbar;


%% Get Depth Map
depth = 10*15./disparityMap;
figure;
imshow(depth,disparityRange);
colormap jet;
colorbar;



