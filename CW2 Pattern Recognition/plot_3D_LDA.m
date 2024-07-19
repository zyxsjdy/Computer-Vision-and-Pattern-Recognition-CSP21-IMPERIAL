function plot_3D_LDA(obj1PVT,obj2PVT,mean_PVT,LDA_PVT, LDAlines, LDmeans, y, name1, name2)
name1 = sprintf(' %s', name1);
name2 = sprintf(' %s', name2);
name3 = sprintf(' mean %s', name1);
name4 = sprintf(' mean %s', name2);
tempx=[LDAlines(1,1),LDAlines(1,3),LDAlines(1,2),LDAlines(1,4)];
tempy=[LDAlines(2,1),LDAlines(2,3),LDAlines(2,2),LDAlines(2,4)];
tempz=[LDAlines(3,1),LDAlines(3,3),LDAlines(3,2),LDAlines(3,4)];


%ploting the 3D data 
figure;
scatter3(obj1PVT(1,:),obj1PVT(2,:),obj1PVT(3,:),'b','filled')
hold on 
scatter3(obj2PVT(1,:),obj2PVT(2,:),obj2PVT(3,:),'r','filled')
hold on
scatter3(mean_PVT(1,1),mean_PVT(2,1),mean_PVT(3,1),150,'b','filled','d')
hold on
scatter3(mean_PVT(1,2),mean_PVT(2,2),mean_PVT(3,2),150,'r','filled','d')
hold on
plot3(LDAlines(1,1:2),LDAlines(2,1:2),LDAlines(3,1:2),'g');  % plot the first line
hold on
plot3(LDAlines(1,3:4),LDAlines(2,3:4),LDAlines(3,3:4),'color','#EDB120');  % plot the second line
hold on
patch(tempx,tempy,tempz,'c','FaceAlpha',.4); % plot the projection plane
xlim([-2 2])
ylim([-2 2])
zlim([-2 2])
xlabel('Pressure')
ylabel('Vibration')
zlabel('Temperature')
grid on
axis equal
T = sprintf(' Three dimensional LDA for %s and %s', name1,name2);
legend(name1,name2,name3,name4,'LD1 projection vector','LD2 projection vector');
sgtitle(T);

%ploting the 2D data 
figure;
scatter(LDA_PVT(1,1:10),LDA_PVT(2,1:10),'b','filled')
hold on
scatter(LDA_PVT(1,11:20),LDA_PVT(2,11:20),'r','filled')
hold on
scatter(LDmeans(1,1),LDmeans(2,1),150,'b','filled','d')
hold on
scatter(LDmeans(1,2) ,LDmeans(2,2),150,'r','filled','d')
hold on
xline(0,'--','color','#7E2F8E','LineWidth',2)
xlabel('LD1')
ylabel('LD2')
ylim([-2.5 2.5])
xlim([-2.5 2.5])
grid on
legend(name1, name2, name3,name4,'Discriminant line','Fontsize',14);
title('2D LDA');

%ploting the 1D data 
figure;
grid on
scatter(LDA_PVT(1,1:10),y(1:10),'b','filled')
hold on 
scatter(LDA_PVT(1,11:20),y(11:20),'r','filled')
hold on
scatter(LDmeans(1,1),1,150,'b','filled','d')
hold on
scatter(LDmeans(1,2),1,150,'r','filled','d')
hold on
xline(0,'--','color','#7E2F8E','LineWidth',2)
xlabel('LD1')
xlim([-2.5 2.5])
set(gca,'ytick',[])
grid on
legend(name1, name2, name3,name4,'Discriminant line','Fontsize',14);
title('1D LDA');
end