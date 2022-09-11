% This is the code for Exercise 1, step counting,
% as part of the How can we make sense of the unseen world? workshop, 
% debuted at the WiDS 2022 Worldwide Conference.
% The goal is to execute this code in MATLAB Mobile.

% Run this file once you are ready to start collecting data.

% Clear all previously collected data and plots
clear m; clearvars -except teamID; close all;

% Add the helper files to your path so that
% you can use them in this file. 
addpath(fullfile(pwd,'helperFiles'));

% Check whether you have licenses for all 
% required products
checkProductLicenses();

% Retrieve logged sensor data
load('magFieldData.mat');

%This will have a variable named: MagneticField which contains
%magnetic field strength measured in the x,y, and z directions.
% Now that you have collected the data, 
% you will visualize what you measured.

% Extract <X, Y, Z> magnetic field vectors
x = mag(:,1);
y = mag(:,2);
z = mag(:,3);
figure,surf(mag)
xlabel('x magnetic field strength')
ylabel('y magnetic field strength')
zlabel('z magnetic field strength')
hold on
image(mag)
colormap autumn
shg
view(-30,10)
shg
% Caclulating summary statistics of the collected values
maxmagvalues=max(mag);
minmagvalues=min(mag);
stdmagvalues=std(mag);
rangestdvalues=range(mag);

% Visualizing the statistics of this data
figure,boxplot(mag)

% Exploring the ideal number of clusters for cluster analysis
eva = evalclusters(mag,'kmeans','CalinskiHarabasz','KList',1:6);

% Determining how the values maybe clustered (or not)

[idx,cc]=kmeans(mag,eva.OptimalK);

figure
gscatter(x,y,idx,[])
hold on
plot(cc(:,1),cc(:,2),'kx')
title('Clusters of Magnetic Field Strength X and Y Values')


warning On  % Re-enable warnings
%% Clean up
% Turn off the magentic sensor and
% clear mobiledev.

m.MagneticSensorEnabled=0;

clear m;
