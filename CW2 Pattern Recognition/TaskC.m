%% Initialization
clc;
clear;
close all;



% Linear discriminate analysis (LDA)
%% load data

load('PR_CW_DATA_2021/F0_PVT.mat');
%% object index

acrylic = 1;
black_foam = 2;
car_sponge = 3;
flour_sack = 4;
kitchen_sponge = 5;
steel_vase = 6;

trials =10;

%%%%%% 1-a  compare black foam and car sponge  %%%%%%%%%%%

%% standarise data

% parameters of black foam
P1 = Pressure(black_foam,:)'; % 10*1
V1 = Temperature(black_foam,:)';
T1 = Vibration(black_foam,:)';
temp1=[P1 V1 T1]; %  10*3

P2 = Pressure(car_sponge,:)';
V2 = Temperature(car_sponge,:)';
T2 = Vibration(car_sponge,:)';
temp2=[P2 V2 T2]; %  10*3


PVT=[temp1;temp2];
PVT=zscore(PVT);
obj1PVT=PVT(1:10,:)';  % 3*10
obj2PVT=PVT(11:20,:)'; % 3*10



%%  1-a   LDA for the black foam and car sponge objects
name1 = 'Black Foam';
name2 = 'Car Sponge';

[~,~,~, ~,~, ~]= LDA(obj1PVT,obj2PVT,trials, name1, name2);

%%  1-b   Applying 3D LDA

[mean_PVT,LDA_PVT, LDAlines, LDmeans] = ThreeD_LDA(obj1PVT, obj2PVT);


%ploting 3D LDA

y = ones(1,20);
plot_3D_LDA(obj1PVT,obj2PVT,mean_PVT,LDA_PVT, LDAlines, LDmeans,y, name1,name2);




%%%%%%%%%%%%%%%% 1-d  Comparing acrylic and steel vase %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 1-d   Apply 2D and 3D LDA for acrylic and car sponge

%% standarise data

% parameters of black foam
P1 = Pressure(acrylic,:)'; % 10*1
V1 = Temperature(acrylic,:)';
T1 = Vibration(acrylic,:)';
temp1=[P1 V1 T1]; %  10*3

P2 = Pressure(car_sponge,:)';
V2 = Temperature(car_sponge,:)';
T2 = Vibration(car_sponge,:)';
temp2=[P2 V2 T2]; %  10*3


PVT=[temp1;temp2];
PVT=zscore(PVT);
obj1PVT=PVT(1:10,:)';  % 3*10
obj2PVT=PVT(11:20,:)'; % 3*10



%%  2D LDA for the acrylic and car sponge
name1 = 'Acrylic';
name2 = 'Car sponge';

[~,~,~, ~,~, ~]= LDA(obj1PVT,obj2PVT,trials, name1, name2);

%%   Applying 3D LDA for the acrylic and car sponge

[mean_PVT,LDA_PVT, LDAlines, LDmeans] = ThreeD_LDA(obj1PVT, obj2PVT);


%ploting 3D LDA

y = ones(1,20);
plot_3D_LDA(obj1PVT,obj2PVT,mean_PVT,LDA_PVT, LDAlines, LDmeans,y, name1,name2);