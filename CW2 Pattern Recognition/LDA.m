function [projectionPV,projectionPT,projectionTV,projectionVector_PV,projectionVector_PT, projectionVector_TV] = LDA(obj1PVT,obj2PVT,trials, name1, name2)
% get the P vs V, P vs T, T vs V data of object 1
PV1 = [obj1PVT(1,:);obj1PVT(2,:)]';
PT1 = [obj1PVT(1,:);obj1PVT(3,:)]';
TV1 = [obj1PVT(3,:);obj1PVT(2,:)]';


PV2 = [obj2PVT(1,:);obj2PVT(2,:)]';
PT2 = [obj2PVT(1,:);obj2PVT(3,:)]';
TV2 = [obj2PVT(3,:);obj2PVT(2,:)]';

% size: 2*20
PVm = [PV1; PV2]'; 
PTm = [PT1; PT2]';
TVm = [TV1; TV2]';

mean1PV = mean(PV1)'; % the mean of the first class in PV situation  2x1
mean2PV = mean(PV2)'; % the mean of the second class in PV situation  2x1
mean1PT = mean(PT1)'; % the mean of the first class in PT situation  2x1
mean2PT = mean(PT2)'; % the mean of the second class in PT situation  2x1
mean1TV = mean(TV1)'; % the mean of the first class in TV situation  2x1
mean2TV = mean(TV2)'; % the mean of the second class in TV situation  2x1

%calculate the covariance to get within class scatter matrix
COV1PV = cov(PV1);
COV2PV = cov(PV2);
COV1PT = cov(PT1);
COV2PT = cov(PT2);
COV1TV = cov(TV1);
COV2TV = cov(TV2);

% the within class scatter matrix
SW_PV = COV1PV + COV2PV;
SW_PT = COV1PT + COV2PT;
SW_TV = COV1TV + COV2TV;

% the between class scatter matrices
SB_PV = (mean1PV-mean2PV)*(mean1PV-mean2PV)';
SB_PT = (mean1PT-mean2PT)*(mean1PT-mean2PT)';
SB_TV = (mean1TV-mean2TV)*(mean1TV-mean2TV)';

% combine two types of matrix and calculate their eigenvectors
[eigenvectors_PV, ~] = eig(SW_PV\ SB_PV);
[eigenvectors_PT, ~] = eig(SW_PT\ SB_PT);
[eigenvectors_TV, ~] = eig(SW_TV\ SB_TV);

% select the eigencetor with largest eigenvalue
projectionVector_PV = eigenvectors_PV(:,2);
projectionVector_PT = eigenvectors_PT(:,2);
projectionVector_TV = eigenvectors_TV(:,2);


% project data on the selected axes
projectionPV = projectionVector_PV'*PVm;
projectionPT = projectionVector_PT'*PTm;
projectionTV = projectionVector_TV'*TVm;

% return the discrimination line -dis_line
projectionVector_PV=[-projectionVector_PV projectionVector_PV]*2;
slope = projectionVector_PV(2,2)/projectionVector_PV(1,2);
dis_line_PV = [-[1;-1/slope] [1;-1/slope]]*2;

projectionVector_PT=[-projectionVector_PT projectionVector_PT]*2;
slope = projectionVector_PT(2,2)/projectionVector_PT(1,2);
dis_line_PT = [-[1;-1/slope] [1;-1/slope]]*2;

projectionVector_TV=[-projectionVector_TV projectionVector_TV]*2;
slope = projectionVector_TV(2,2)/projectionVector_TV(1,2);
dis_line_TV = [-[1;-1/slope] [1;-1/slope]]*2;



y = zeros(1,20); 
name1 = sprintf(' %s', name1);
name2 = sprintf(' %s', name2);
name3 = sprintf(' mean %s', name1);
name4 = sprintf(' mean %s', name2);

%% P vs V
figure;
subplot(1,2,1);
scatter(projectionPV(1:trials),y(1:trials),'filled','b') 
hold on
scatter(projectionPV(trials+1:trials*2),y(trials+1:trials*2),'filled','r') 
hold on
scatter(0.5*projectionVector_PV(:,2)'*mean1PV,0,150,'b','filled','d') 
hold on
scatter(0.5*projectionVector_PV(:,2)'*mean2PV,0,150,'r','filled','d')
hold on 
xline(0,'--','color','#7E2F8E','LineWidth',2)
set(gca,'xtick',[])
grid on
ylabel('LD1')
axis square
title('1D projection')



subplot(1,2,2);
scatter(obj1PVT(1,:),obj1PVT(2,:),'filled','b')
hold on
scatter(obj2PVT(1,:),obj2PVT(2,:),'filled','r')
hold on 
scatter(mean1PV(1),mean1PV(2),100,'b','filled','d')
hold on 
scatter(mean2PV(1),mean2PV(2), 100,'r','filled','d')
hold on
% plot the projection axes based on the coordinates of two points
plot(projectionVector_PV(1,:),projectionVector_PV(2,:),'g')
hold on
% plot the discrimination line based on the coordinates of two points
plot(dis_line_PV(1,:),dis_line_PV(2,:),'--','color','#7E2F8E')
ylim([-2.5 2.5])
xlim([-2.5 2.5])
grid on
xlabel('Pressure')
ylabel('Vibration')
legend(name1,name2,name3,name4,'Projection line','Discriminant line','Fontsize',14)
title('2D LDA')
axis square
sgtitle('Pressure vs Vibration');


%% P vs T
figure;
subplot(1,2,1);
scatter(projectionPT(1:trials),y(1:trials),'filled','b') 
hold on
scatter(projectionPT(trials+1:trials*2),y(trials+1:trials*2),'filled','r') 
hold on
scatter(0.5*projectionVector_PT(:,2)'*mean1PT,0,150,'b','filled','d') 
hold on
scatter(0.5*projectionVector_PT(:,2)'*mean2PT,0,150,'r','filled','d')
hold on 
xline(0,'--','color','#7E2F8E','LineWidth',2)
set(gca,'ytick',[])
grid on
ylabel('LD1')
axis square
title('1D projection')


subplot(1,2,2);
scatter(obj1PVT(1,:),obj1PVT(3,:),'filled','b')
hold on
scatter(obj2PVT(1,:),obj2PVT(3,:),'filled','r')
hold on 
scatter(mean1PT(1),mean1PT(2),100,'b','filled','d')
hold on 
scatter(mean2PT(1),mean2PT(2), 100,'r','filled','d')
hold on
% plot the projection axes based on the coordinates of two points
plot(projectionVector_PT(1,:),projectionVector_PT(2,:),'g')
hold on
% plot the discrimination line based on the coordinates of two points
plot(dis_line_PT(1,:),dis_line_PT(2,:),'--','color','#7E2F8E')
ylim([-2.5 2.5])
xlim([-2.5 2.5])
grid on
xlabel('Pressure')
ylabel('Temperature')
legend(name1,name2,name3,name4,'Projection line','Discriminant line','Fontsize',14)
axis square
title('2D LDA')
sgtitle('Pressure vs Temperature');


%% T vs V
figure;
subplot(1,2,1);
scatter(projectionTV(1:trials),y(1:trials),'filled','b') 
hold on
scatter(projectionTV(trials+1:trials*2),y(trials+1:trials*2),'filled','r') 
hold on
scatter(0.5*projectionVector_TV(:,2)'*mean1TV,0,150,'b','filled','d') 
hold on
scatter(0.5*projectionVector_TV(:,2)'*mean2TV,0,150,'r','filled','d')
hold on 
xline(0,'--','color','#7E2F8E','LineWidth',2)
set(gca,'ytick',[])
grid on
ylabel('LD1')
axis square
title('1D projection')

subplot(1,2,2);
scatter(obj1PVT(3,:),obj1PVT(2,:),'filled','b')
hold on
scatter(obj2PVT(3,:),obj2PVT(2,:),'filled','r')
hold on 
scatter(mean1TV(1),mean1TV(2),100,'b','filled','d')
hold on 
scatter(mean2TV(1),mean2TV(2), 100,'r','filled','d')
hold on
% plot the projection axes based on the coordinates of two points
plot(projectionVector_TV(1,:),projectionVector_TV(2,:),'g')
hold on
% plot the discrimination line based on the coordinates of two points
plot(dis_line_TV(1,:),dis_line_TV(2,:),'--','color','#7E2F8E')
ylim([-2.5 2.5])
xlim([-2.5 2.5])
grid on
xlabel('Temperature')
ylabel('Vibration')
legend(name1,name2,name3,name4,'Projection line','Discriminant line','Fontsize',14)
axis square
title('2D LDA')
sgtitle('Temperature vs Vibration');


end

