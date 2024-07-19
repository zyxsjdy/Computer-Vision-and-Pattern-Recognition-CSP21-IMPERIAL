close all;
%%%%%%%%[0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1]
innnn = [0 0 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1]';
innnn = logical(innnn);

Points1 = matchedPoints1(innnn,:);
Points2 = matchedPoints2(innnn,:);

figure;showMatchedFeatures(I1_colour,I2_colour,Points1,Points2,'montage');


[fLMedS, inliers2, status] = estimateFundamentalMatrix(Points1, Points2, 'Method', 'RANSAC', 'NumTrials', 1, 'DistanceThreshold', 200000, 'Confidence', 99.99);
fLMedS
figure;showMatchedFeatures(I1_colour,I2_colour,Points1(inliers2,:),Points2(inliers2,:),'montage');
sum(inliers2)

L = sum(innnn)
p1 = ones(3,L);
p2 = ones(3,L);

p1(1:2,:) = Points1';
p2(1:2,:) = Points2';

add = 0;
for i = 1:L
    add = p2(:,i)'*fLMedS*p1(:,i) + add;
end
a = add/L


















