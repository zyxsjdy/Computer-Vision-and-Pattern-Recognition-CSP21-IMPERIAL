function [mean_PVT,LDA_PVT, LDAlines, LDmeans] = ThreeD_LDA(obj1PVT,obj2PVT)

% the PVT data of two objects
PVT1 = [obj1PVT(1,:);obj1PVT(2,:);obj1PVT(3,:)]'; % 10*3
PVT2 = [obj2PVT(1,:);obj2PVT(2,:);obj2PVT(3,:)]';


PVT = [PVT1;PVT2]'; % 3*20

meanPVT1 = mean(PVT1)';  %3*1
meanPVT2 = mean(PVT2)';
cov1 = cov(PVT1);
cov2 = cov(PVT2);
Sw_PVT = cov1 + cov2; % within class scatter matrix 
Sb_PVT = (meanPVT1-meanPVT2)*(meanPVT2-meanPVT2)'; % between class scatter matrix 

mean_PVT = [meanPVT1, meanPVT2];  % 3*2



[eigenvectors_PVT, eigenvalue] = eig(Sw_PVT\ Sb_PVT);

[~,ind]=sort(diag(eigenvalue),'descend');
eigenvectors_PVT=eigenvectors_PVT(:,ind);

projectionVector_PVT1 = eigenvectors_PVT(:,1);
projectionVector_PVT2 = eigenvectors_PVT(:,2);
projectionVector_PVT3 = eigenvectors_PVT(:,3);

% project data to 3 axes
LDA_PVT1 = projectionVector_PVT1'*PVT;  % 1*20
LDA_PVT2 = projectionVector_PVT2'*PVT;
LDA_PVT3 = projectionVector_PVT3'*PVT;

LDA_PVT = [LDA_PVT1;LDA_PVT2;LDA_PVT3];  % 3*20

% LDA lines 
LDA_PVT1_line = [-projectionVector_PVT1 projectionVector_PVT1]*2;  % 3*2
LDA_PVT2_line = [-projectionVector_PVT2 projectionVector_PVT2]*2;

LDAlines = [ LDA_PVT1_line, LDA_PVT2_line];  % 3*4

% LDA means projection
meanobj1_LD1 = projectionVector_PVT1'*meanPVT1;
meanobj1_LD2 = projectionVector_PVT2'*meanPVT1;

meanobj2_LD1 = projectionVector_PVT1'*meanPVT2;
meanobj2_LD2 = projectionVector_PVT2'*meanPVT2;

LDmeanobj2 = [meanobj2_LD1; meanobj2_LD2];
LDmeanobj1 = [meanobj1_LD1; meanobj1_LD2];

LDmeans = [ LDmeanobj1 ,LDmeanobj2];

end