%% Initialization
clc;
clear;
close all;

%% Principle component analysis (PCA)
load('PR_CW_DATA_2021/F0_PVT.mat');
load('PR_CW_DATA_2021/F0_Electrodes.mat');
PVT=zeros(60,3);
Pressure = reshape(Pressure', [1, 60]);
Vibration = reshape(Vibration', [1, 60]);
Temperature = reshape(Temperature', [1, 60]);
PVT(:,1)=Pressure';
PVT(:,2)=Vibration';
PVT(:,3)=Temperature';

%% 1-a report covariance matrix and other parameters

% 1. Stardardise the Data
Data_standardised = zscore(PVT);

% 2. Compute the Covariance Matrix
Cov_Matrix = cov(Data_standardised)

% 3. Calculate Eigenvectors and Eigenvalues

[Eig_Vec, Eig_Val] = eig(Cov_Matrix)

% 4. The eigenvectors are sorted according to the order of the corresponding eigenvalues of the eigenvectors from large to small
Eig_vector = fliplr(Eig_Vec);  %sort


%% 1-b Replot standardised data with principal components

[coeff,score] = pca(Data_standardised);
colors = ['r', 'g', 'b', 'm', 'k', 'c'];
n=0;

figure;
grid on;

% Data Points
for i=1:10:60
    n=n+1;
    color = colors(n);
    scatter3(Data_standardised(i:(i+9),1),Data_standardised(i:(i+9),2),Data_standardised(i:(i+9),3),30,'filled',color);
    hold on;
end
pc_3 = coeff(:,1:3);
biplot(pc_3,'varlabels',{'PC1','PC2','PC3'});
legend('acrylic','black foam','car sponge', 'flour sack', 'kitchen sponge','steel vase');
xlabel('Pressure');
ylabel('Vibration');
zlabel('Temperature');

set(findall(gca, 'Type', 'Line'),'LineWidth',3);
set(gca,'Fontsize',18)

title('Standardised data with principle components')


%% 1-c  Reduce data to 2D and replot

%vbls = ["Pressure","Vibration","Temperature"];

% figure;
% h = biplot(coeff(:,1:2),'Scores',score(:,1:2));
% i=0;
% set(gca,'Fontsize',18)
%
% for k = 10:69
%     if rem(k,10) == 0
%         i=i+1;
%     end
%     color = colors(i);
%     h(k).MarkerEdgeColor = color;  % Specify color for the observations
%     h(k).MarkerSize=30;
% end
% xlabel('Principle component 1')
% ylabel('Principle component 2')
% title('PVT data reduced to 2D')

figure;
grid on
reduced_score = score(:,1:2);

i=0;
for k =1:10:60
    i=i+1;
    color=colors(i);
    scatter(reduced_score(k:(k+9),1),reduced_score(k:(k+9),2),color,'filled');
    hold on
end
legend('acrylic','black foam', 'car sponge','flour sack', 'kitchen sponge', 'steel vase', 'Fontsize',14);
xlim([-3 3])
ylim([-3 3])
axis square
title('Reduced 2-D Data');
xlabel('Principal Component 1')
ylabel('Principal Component 2')
axis square



%% 1-d  Show how data is distributed across all principal components

figure;
for i=1:3
    Y = Data_standardised*Eig_vector(:,i);
    subplot(3,1,i);
    n=0;
    for j=1:10:60
        n=n+1;
        color = colors(n);
        scatter(Y(j:(j+9)),zeros(10,1),30,'filled',color); grid on; hold on;
    end
    legend('acrylic','black foam','car sponge', 'flour sack', 'kitchen sponge','steel vase')
    title(strcat('Principal Component ',num2str(i)))
end


% %y-axis for 1D plot
% y1 = ones(1,size(score,1));
% y2 = 2*ones(1,size(score,1));
% y3 = 3*ones(1,size(score,1));
%
% %get each dimension seperatly  ( score =X*coeff)
% pc1 = score(:,1)';
% pc2 = score(:,2)';
% pc3 = score(:,3)';
%
% %plot 1d distribution of data for each PC
% figure;
% scatter(pc1,y1,'fill');
% hold on
% scatter(pc2,y2,'fill');
% hold on
% scatter(pc3,y3,'fill');
% title('1D data distribution for each PC');
% ylim([0 4]);
% legend('PC1', 'PC2', 'PC3');
% set(gca,'ytick',[]);

%% PCA of electrodes data- standarise data
Elec = [];

for i = 1:6
    Elec = [Elec squeeze(Electrodes(i,:,:))];
end
Elec=Elec';
EData_standardised = zscore(Elec);

%% 2 -a  PCA of the electrodes data

[Ecoeff,Escore,Elatent,~,explained] = pca(EData_standardised);
%cancle notes for the first time running it to produce .mat file
%save('Electrodes_PCA.mat', 'score');


figure;
g=plot(Elatent,'.-');
set(g,'LineWidth',2,'MarkerSize',25)
set(gca,'XTick',1:19)
title('Variance of principal components')
xlabel('Principal components')
ylabel('Variance')
set(gca,'Fontsize',18);

%% 2-b   Electrode Data on 3 Principal Components

figure;
grid on
reduced_Escore = Escore(:,1:3);

i=0;
for k =1:10:60
    i=i+1;
    color=colors(i);
    scatter3(reduced_Escore(k:(k+9),1),reduced_Escore(k:(k+9),2),reduced_Escore(k:(k+9),3),color,'filled');
    hold on
end
legend('acrylic','black foam', 'car sponge','flour sack', 'kitchen sponge', 'steel vase', 'Fontsize',14);

title('Reduced 3-D Electrodes Data');
xlabel('Principal Component 1')
ylabel('Principal Component 2')
zlabel('Principal Component 3')
