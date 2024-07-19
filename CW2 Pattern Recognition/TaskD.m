%% Initialization
clc;
clear;
close all;
rng(5)

%% load data
load('PR_CW_DATA_2021/F0_PVT.mat');
colors = ['r', 'g', 'b', 'm', 'k', 'c'];
colors_Mean = ['rx', 'gx', 'bx', 'mx', 'kx', 'cx'];
P=[];
V=[];
T=[];
for i = 1:6
    P= [P Pressure(i,:)];
    V =[V Vibration(i,:)];
    T =[T Temperature(i,:)];
end
PVT=[P;V;T]';  % 60*3

% calculate mean of each cluster
mean_acrylic=mean(PVT(1:10,:));   % 1*3
mean_black_foam=mean(PVT(11:20,:));
mean_car_sponge=mean(PVT(21:30,:));
mean_flour_sack=mean(PVT(31:40,:));
mean_kitchen_sponge=mean(PVT(41:50,:));
mean_steel_vase=mean(PVT(51:60,:));
Mean=[mean_acrylic;mean_black_foam;mean_car_sponge;mean_flour_sack;mean_kitchen_sponge;mean_steel_vase];


%% visualise the original classes

% figure;

% for i=1:6
%    scatter3(PVT(10*(i-1)+1:(10*i),1),PVT(10*(i-1)+1:(10*i),2),PVT(10*(i-1)+1:(10*i),3),colors(i),'filled');
%    hold on
% end
%
% for i=1:6
%    scatter3(Mean(i,1),Mean(i,2),Mean(i,3),150,colors_Mean(i));
%    hold on
% end
% hold off
% grid on
% xlabel('Pressure');
% ylabel('Vibration');
% zlabel('Temperature');
% legend('acrylic','black foam', 'car sponge','flour sack', 'kitchen sponge',...
%     'steel vase','Centroids')
% title('PVT data for 6 classes');

figure;
plot3(PVT(1:10,1),PVT(1:10,2),PVT(1:10,3),'r.','MarkerSize',12)
hold on
plot3(PVT(11:20,1),PVT(11:20,2),PVT(11:20,3),'g.','MarkerSize',12);
hold on
plot3(PVT(21:30,1),PVT(21:30,2),PVT(21:30,3),'b.','MarkerSize',12);
hold on
plot3(PVT(31:40,1),PVT(31:40,2),PVT(31:40,3),'m.','MarkerSize',12);
hold on
plot3(PVT(41:50,1),PVT(41:50,2),PVT(41:50,3),'k.','MarkerSize',12);
hold on
plot3(PVT(51:60,1),PVT(51:60,2),PVT(51:60,3),'c.','MarkerSize',12);
hold on
plot3(mean_acrylic(1),mean_acrylic(2),mean_acrylic(3),'rx', 'MarkerSize',15,'LineWidth',3);
hold on
plot3(mean_black_foam(1),mean_black_foam(2),mean_black_foam(3),'gx', 'MarkerSize',15,'LineWidth',3);
hold on
plot3(mean_car_sponge(1),mean_car_sponge(2),mean_car_sponge(3),'bx', 'MarkerSize',15,'LineWidth',3);
hold on
plot3(mean_flour_sack(1),mean_flour_sack(2),mean_flour_sack(3),'mx', 'MarkerSize',15,'LineWidth',3);
hold on
plot3(mean_kitchen_sponge(1),mean_kitchen_sponge(2),mean_kitchen_sponge(3),'kx', 'MarkerSize',15,'LineWidth',3);
hold on
plot3(mean_steel_vase(1),mean_steel_vase(2),mean_steel_vase(3),'cx', 'MarkerSize',15,'LineWidth',3);
hold on

grid on
xlabel('Pressure');
ylabel('Vibration');
zlabel('Temperature');
legend('acrylic','black foam', 'car sponge','flour sack', 'kitchen sponge',...
    'steel vase','Centroids 1','Centroids 2','Centroids 3','Centroids 4','Centroids 5','Centroids 6')
title('PVT data for 6 classes');


%% k-mean algorithm (Eucledean distance)
[idx,C]=kmeans(PVT,6);  % applying k-means algorithm to classify data to 6 classes
figure;

plot3(PVT(idx==1,1),PVT(idx==1,2),PVT(idx==1,3),'r.','MarkerSize',12)
hold on
plot3(PVT(idx==2,1),PVT(idx==2,2),PVT(idx==2,3),'g.','MarkerSize',12)
hold on
plot3(PVT(idx==3,1),PVT(idx==3,2),PVT(idx==3,3),'b.','MarkerSize',12)
hold on
plot3(PVT(idx==4,1),PVT(idx==4,2),PVT(idx==4,3),'m.','MarkerSize',12)
hold on
plot3(PVT(idx==5,1),PVT(idx==5,2),PVT(idx==5,3),'k.','MarkerSize',12)
hold on
plot3(PVT(idx==6,1),PVT(idx==6,2),PVT(idx==6,3),'c.','MarkerSize',12)
hold on
plot3(C(1,1),C(1,2),C(1,3),'rx','MarkerSize',15,'LineWidth',3)
hold on
plot3(C(2,1),C(2,2),C(2,3),'gx','MarkerSize',15,'LineWidth',3)
hold on
plot3(C(3,1),C(3,2),C(3,3),'bx','MarkerSize',15,'LineWidth',3)
hold on
plot3(C(4,1),C(4,2),C(4,3),'mx','MarkerSize',15,'LineWidth',3)
hold on
plot3(C(5,1),C(5,2),C(5,3),'kx','MarkerSize',15,'LineWidth',3)
hold on
plot3(C(6,1),C(6,2),C(6,3),'cx','MarkerSize',15,'LineWidth',3)

hold off

grid on
title ('Cluster Assignments and Centroids (Eucledean distance)');
legend('Cluster 1','Cluster 2', 'Cluster 3','Cluster 4', 'Cluster 5',...
    'Cluster 6','Centroid 1','Centroid 2','Centroid 3','Centroid 4','Centroid 5','Centroid 6')
xlabel('Pressure');
ylabel('Vibration');
zlabel('Temperature');


%% k-mean algorithm (Cityblock distance)
[idx2,C2] = kmeans(PVT,6,'Distance','cityblock'); % applying k-means algorithm to classify data to 6 classes
figure;


plot3(PVT(idx2==1,1),PVT(idx2==1,2),PVT(idx2==1,3),'r.','MarkerSize',12)
hold on
plot3(PVT(idx2==2,1),PVT(idx2==2,2),PVT(idx2==2,3),'g.','MarkerSize',12)
hold on
plot3(PVT(idx2==3,1),PVT(idx2==3,2),PVT(idx2==3,3),'b.','MarkerSize',12)
hold on
plot3(PVT(idx2==4,1),PVT(idx2==4,2),PVT(idx2==4,3),'m.','MarkerSize',12)
hold on
plot3(PVT(idx2==5,1),PVT(idx2==5,2),PVT(idx2==5,3),'k.','MarkerSize',12)
hold on
plot3(PVT(idx2==6,1),PVT(idx2==6,2),PVT(idx2==6,3),'c.','MarkerSize',12)
hold on
plot3(C2(1,1),C2(1,2),C2(1,3),'rx','MarkerSize',15,'LineWidth',3)
hold on
plot3(C2(2,1),C2(2,2),C2(2,3),'gx','MarkerSize',15,'LineWidth',3)
hold on
plot3(C2(3,1),C2(3,2),C2(3,3),'bx','MarkerSize',15,'LineWidth',3)
hold on
plot3(C2(4,1),C2(4,2),C2(4,3),'mx','MarkerSize',15,'LineWidth',3)
hold on
plot3(C2(5,1),C2(5,2),C2(5,3),'kx','MarkerSize',15,'LineWidth',3)
hold on
plot3(C2(6,1),C2(6,2),C2(6,3),'cx','MarkerSize',15,'LineWidth',3)

hold off

grid on
title ('Cluster Assignments and Centroids (Cityblock distance)');
legend('Cluster 1','Cluster 2', 'Cluster 3','Cluster 4', 'Cluster 5',...
    'Cluster 6','Centroid 1','Centroid 2','Centroid 3','Centroid 4','Centroid 5','Centroid 6')
xlabel('Pressure');
ylabel('Vibration');
zlabel('Temperature');



%% bagging
load('Electrodes_PCA.mat');
% split 60% of the data as training data, 40% as test data
training_data = zeros(36, 3);
training_label = zeros(36, 1);
test_data = zeros(24, 3);
test_label = zeros(24, 1);

idx=randperm(10);
idx_train=idx(1:6);
idx_test=idx(7:10);

% split the training and testing sets
for i =1:6
    for j=1:3
        training_data((6*i)-5:6*i,j)=score(idx_train+(i-1)*10, j); % set the first 6 samples of each object as the training set
        test_data((4*i)-3:4*i, j) = score(idx_test+(i-1)*10, j);
    end
    training_label((6*i)-5:6*i) = i;
    test_label((4*i)-3:4*i) = i;
end

%% bagging operation

Mdl = TreeBagger(100, training_data, training_label, 'OOBPrediction', 'On');

%% 2-a   plot the OOB (out of bag error) to decide the number of trees
figure;

oobErrorBaggedEnsemble = oobError(Mdl);
plot(oobErrorBaggedEnsemble)
grid on
xlabel 'Number of grown trees';
ylabel 'Out-of-bag classification error';
title("OOB over the number of trees")

%% 2-b    visualise two of decision trees

Mdl1 = TreeBagger(17, training_data, training_label, 'OOBPrediction', 'On');

view(Mdl1.Trees{1}, 'Mode', 'graph')
view(Mdl1.Trees{2}, 'Mode', 'graph')

%% 2-c    run the trained model with the testing set
Fit = predict(Mdl1, test_data);  % test the trained model using testing set
Fit = cell2mat(Fit);
Predict_label=zeros(24,1);
for i = 1:24
    Predict_label(i,1) = str2double(Fit(i));  %  get the predicted label for tesing set
end
% generate the confusion matrix
Con_Mat = confusionmat(test_label, Predict_label);
figure;
confusionchart(Con_Mat)
title("Confusion Matrix Chart")
xlabel('Predicted class')
ylabel('True class')

