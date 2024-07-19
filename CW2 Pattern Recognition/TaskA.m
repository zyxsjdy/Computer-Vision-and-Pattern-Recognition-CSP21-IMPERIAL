%% Initialization
clc;
clear;
close all;

%% Section A1
t = linspace(1,1000,1000);

%% acrylic
% Trial 1
load('PR_CW_DATA_2021/acrylic_211_01_HOLD')
figure;
subplot(2,2,1); plot(t,F0pdc);        title('Pressure');
subplot(2,2,2); plot(t,F0pac(2,:));   title('Vibrations');
subplot(2,2,3); plot(t,F0tdc);        title('Temperature');
subplot(2,2,4); plot(t,F0Electrodes); title('Electrodes');
sgtitle('PVT and Electrodes statistics for acrylic in trial 1');

% Trial 2
load('PR_CW_DATA_2021/acrylic_211_02_HOLD')
figure;
subplot(2,2,1); plot(t,F0pdc);        title('Pressure');
subplot(2,2,2); plot(t,F0pac(2,:));   title('Vibrations');
subplot(2,2,3); plot(t,F0tdc);        title('Temperature');
subplot(2,2,4); plot(t,F0Electrodes); title('Electrodes');
sgtitle('PVT and Electrodes statistics for acrylic in trial 2');

% Trial 6
load('PR_CW_DATA_2021/acrylic_211_06_HOLD')
figure;
subplot(2,2,1); plot(t,F0pdc);        title('Pressure');
subplot(2,2,2); plot(t,F0pac(2,:));   title('Vibrations');
subplot(2,2,3); plot(t,F0tdc);        title('Temperature');
subplot(2,2,4); plot(t,F0Electrodes); title('Electrodes');
sgtitle('PVT and Electrodes statistics for acrylic in trial 6');

%% black foam
% Trial 1
load('PR_CW_DATA_2021/black_foam_110_01_HOLD')
figure;
subplot(2,2,1); plot(t,F0pdc);        title('Pressure');
subplot(2,2,2); plot(t,F0pac(2,:));   title('Vibrations');
subplot(2,2,3); plot(t,F0tdc);        title('Temperature');
subplot(2,2,4); plot(t,F0Electrodes); title('Electrodes');
sgtitle('PVT and Electrodes statistics for black foam in trial 1');

% Trial 2
load('PR_CW_DATA_2021/black_foam_110_02_HOLD')
figure;
subplot(2,2,1); plot(t,F0pdc);        title('Pressure');
subplot(2,2,2); plot(t,F0pac(2,:));   title('Vibrations');
subplot(2,2,3); plot(t,F0tdc);        title('Temperature');
subplot(2,2,4); plot(t,F0Electrodes); title('Electrodes');
sgtitle('PVT and Electrodes statistics for black foam in trial 2');

% Trial 6
load('PR_CW_DATA_2021/black_foam_110_06_HOLD')
figure;
subplot(2,2,1); plot(t,F0pdc);        title('Pressure');
subplot(2,2,2); plot(t,F0pac(2,:));   title('Vibrations');
subplot(2,2,3); plot(t,F0tdc);        title('Temperature');
subplot(2,2,4); plot(t,F0Electrodes); title('Electrodes');
sgtitle('PVT and Electrodes statistics for black foam in trial 6');

%% car sponge
% Trial 1
load('PR_CW_DATA_2021/car_sponge_101_01_HOLD')
figure;
subplot(2,2,1); plot(t,F0pdc);        title('Pressure');
subplot(2,2,2); plot(t,F0pac(2,:));   title('Vibrations');
subplot(2,2,3); plot(t,F0tdc);        title('Temperature');
subplot(2,2,4); plot(t,F0Electrodes); title('Electrodes');
sgtitle('PVT and Electrodes statistics for car sponge in trial 1');

% Trial 2
load('PR_CW_DATA_2021/car_sponge_101_02_HOLD')
figure;
subplot(2,2,1); plot(t,F0pdc);        title('Pressure');
subplot(2,2,2); plot(t,F0pac(2,:));   title('Vibrations');
subplot(2,2,3); plot(t,F0tdc);        title('Temperature');
subplot(2,2,4); plot(t,F0Electrodes); title('Electrodes');
sgtitle('PVT and Electrodes statistics for car sponge in trial 2');

% Trial 6
load('PR_CW_DATA_2021/car_sponge_101_06_HOLD')
figure;
subplot(2,2,1); plot(t,F0pdc);        title('Pressure');
subplot(2,2,2); plot(t,F0pac(2,:));   title('Vibrations');
subplot(2,2,3); plot(t,F0tdc);        title('Temperature');
subplot(2,2,4); plot(t,F0Electrodes); title('Electrodes');
sgtitle('PVT and Electrodes statistics for car sponge in trial 6');

%% Quantitative Analysis
% average across trials for all the objects

% acrylic
sum_press = zeros(10,1000); 
sum_vib = zeros(10,1000); 
sum_temp = zeros(10,1000);
for i=1:9
    name_file = sprintf('PR_CW_DATA_2021/acrylic_211_0%d_HOLD',i);
    load(name_file);
    sum_press(i,:) = F0pdc;
    sum_vib(i,:) = F0pac(2,:);
    sum_temp(i,:)= F0tdc;
end
load('PR_CW_DATA_2021/acrylic_211_10_HOLD');
sum_press(10,:) = F0pdc;
sum_vib(10,:) = F0pac(2,:);
sum_temp(10,:)= F0tdc;
avg_press = mean(sum_press);
avg_vib = mean(sum_vib);
avg_temp = mean(sum_temp);
acrylic_avg = [avg_press; avg_vib; avg_temp];

% black foam
sum_press = zeros(10,1000); 
sum_vib = zeros(10,1000); 
sum_temp = zeros(10,1000);
for i=1:9
    name_file = sprintf('PR_CW_DATA_2021/black_foam_110_0%d_HOLD',i);
    load(name_file);
    sum_press(i,:)=F0pdc(1:1000);
    sum_vib(i,:) = F0pac(2,1:1000);
    sum_temp(i,:)= F0tdc(1:1000);
end
load('PR_CW_DATA_2021/black_foam_110_10_HOLD');
sum_press(10,:) = F0pdc;
sum_vib(10,:) = F0pac(2,:);
sum_temp(10,:)= F0tdc;
avg_press = mean(sum_press);
avg_vib = mean(sum_vib);
avg_temp = mean(sum_temp);
black_avg = [avg_press; avg_vib; avg_temp];

% car sponge
sum_press = zeros(10,1000); 
sum_vib = zeros(10,1000); 
sum_temp = zeros(10,1000);
for i=1:9
    name_file = sprintf('PR_CW_DATA_2021/car_sponge_101_0%d_HOLD',i);
    load(name_file);
    sum_press(i,:) = F0pdc;
    sum_vib(i,:) = F0pac(2,:);
    sum_temp(i,:)= F0tdc;
end
load('PR_CW_DATA_2021/car_sponge_101_10_HOLD');
sum_press(10,:) = F0pdc;
sum_vib(10,:) = F0pac(2,:);
sum_temp(10,:)= F0tdc;
avg_press = mean(sum_press);
avg_vib = mean(sum_vib);
avg_temp = mean(sum_temp);
car_avg = [avg_press; avg_vib; avg_temp];

% flour sack
sum_press = zeros(10,1000); 
sum_vib = zeros(10,1000); 
sum_temp = zeros(10,1000);
for i=1:9
    name_file = sprintf('PR_CW_DATA_2021/flour_sack_410_0%d_HOLD',i);
    load(name_file);
    sum_press(i,:) = F0pdc;
    sum_vib(i,:) = F0pac(2,:);
    sum_temp(i,:)= F0tdc;
end
load('PR_CW_DATA_2021/flour_sack_410_10_HOLD');
sum_press(10,:) = F0pdc;
sum_vib(10,:) = F0pac(2,:);
sum_temp(10,:)= F0tdc;
avg_press = mean(sum_press);
avg_vib = mean(sum_vib);
avg_temp = mean(sum_temp);
flour_avg = [avg_press; avg_vib; avg_temp];

% kitchen sponge
sum_press = zeros(10,1000); 
sum_vib = zeros(10,1000); 
sum_temp = zeros(10,1000);
for i=1:9
    name_file = sprintf('PR_CW_DATA_2021/kitchen_sponge_114_0%d_HOLD',i);
    load(name_file);
    sum_press(i,:) = F0pdc;
    sum_vib(i,:) = F0pac(2,:);
    sum_temp(i,:)= F0tdc;
end
load('PR_CW_DATA_2021/kitchen_sponge_114_10_HOLD');
sum_press(10,:) = F0pdc;
sum_vib(10,:) = F0pac(2,:);
sum_temp(10,:)= F0tdc;
avg_press = mean(sum_press);
avg_vib = mean(sum_vib);
avg_temp = mean(sum_temp);
kitchen_avg = [avg_press; avg_vib; avg_temp];

% steel vase
sum_press = zeros(10,1000);
sum_vib = zeros(10,1000); 
sum_temp = zeros(10,1000);
for i=1:9
    name_file = sprintf('PR_CW_DATA_2021/steel_vase_702_0%d_HOLD',i);
    load(name_file);
    sum_press(i,:) = F0pdc;
    sum_vib(i,:) = F0pac(2,:);
    sum_temp(i,:)= F0tdc;
end
load('PR_CW_DATA_2021/steel_vase_702_10_HOLD');
sum_press(10,:) = F0pdc;
sum_vib(10,:) = F0pac(2,:);
sum_temp(10,:)= F0tdc;
avg_press = mean(sum_press);
avg_vib = mean(sum_vib);
avg_temp = mean(sum_temp);
steel_avg = [avg_press; avg_vib; avg_temp];

%% Finding variance across objects for different parameters

all_press = [acrylic_avg(1,:); black_avg(1,:); car_avg(1,:); flour_avg(1,:); kitchen_avg(1,:); steel_avg(1,:)];

var_press = var(all_press,0,1);

all_vib = [acrylic_avg(2,:); black_avg(2,:); car_avg(2,:); flour_avg(2,:); kitchen_avg(2,:); steel_avg(2,:)];

var_vib = var(all_vib,0,1);

all_temp = [acrylic_avg(3,:); black_avg(3,:); car_avg(3,:); flour_avg(3,:); kitchen_avg(3,:); steel_avg(3,:)];

var_temp = var(all_temp,0,1);

% find time instance with highest variance
% [~, t_press] = max(var_press);
% [~, t_vib] = max(var_vib);
% [~, t_temp] = max(var_temp);
figure;
subplot(3,1,1);
plot(var_press,'LineWidth',1.5);
legend('Pressure')
xlabel('Time')
ylabel('Variance')
subplot(3,1,2);
plot(var_vib,'LineWidth',1.5);
legend('Vibration')
xlabel('Time')
ylabel('Variance')
subplot(3,1,3);
plot(var_temp,'LineWidth',1.5);
legend('Temperature')
xlabel('Time')
ylabel('Variance')
sgtitle('Variance for 3 dimensions against time')


%% Section A - 2

t = 50; % selected time step

% this contains the starting of the names of the different objects
Name = ["acrylic_211_" "black_foam_110_" "car_sponge_101_" "flour_sack_410_" "kitchen_sponge_114_" "steel_vase_702_"];

Pressure = zeros(6, 10);
Vibration = zeros(6, 10);
Temperature = zeros(6, 10);
Electrodes = zeros(6, 19, 10);

for i = 1:6
    for j = 1:10
        if j<10
            num = strcat(num2str(0), num2str(j));
        else
            num = num2str(j);
        end
        Name_temp = strcat('PR_CW_DATA_2021/',Name(1,i), num, "_HOLD.mat");
        load(Name_temp)

        Pressure(i, j) = F0pdc(1, t);
        Vibration(i, j) = F0pac(2, t);
        Temperature(i, j) = F0tdc(1, t);
        Electrodes(i, :, j) = F0Electrodes(:, t);
    end
end

% save the sampled data
%uisave({'Pressure','Vibration','Temperature'},'F0_PVT')
%uisave('Electrodes','F0_Electrodes')

%% Section A - 3
load("PR_CW_DATA_2021/F0_PVT.mat")

%X axis is pressure, y axis is vibration and z axis is temperature

p = reshape(Pressure', [1, 60]);
v = reshape(Vibration', [1, 60]);
t = reshape(Temperature', [1, 60]);

colors = ['r', 'g', 'b', 'm', 'k', 'c'];
n=0;

figure;
for i=1:10:60
    n=n+1;
    color = colors(n);
    scatter3(p(1, i:(i+9)),v(1,i:(i+9)),t(1, i:(i+9)),15,'filled',color); grid on; hold on;
end

xlabel('Pressure'); ylabel('Vibration'); zlabel('Temperature');
title('3D PVT scatter plot')
legend('acrylic','black foam','car sponge', 'flour sack', 'kitchen sponge','steel vase')