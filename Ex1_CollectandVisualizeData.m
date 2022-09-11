% This is the code for Exercise 1, step counting,
% as part of the How can we make sense of the unseen world? workshop, 
% debuted at the WiDS 2022 Worldwide Conference.
% The goal is to execute this code in MATLAB Mobile.

% Run this file once you are ready to start collecting data.
disp('Initializing...')

% Clear all previously collected data and plots
clear m; clearvars -except teamID; close all;

% Add the helper files to your path so that
% you can use them in this file. 
addpath(fullfile(pwd,'helperFiles'));

% Check whether you have licenses for all 
% required products
checkProductLicenses();

% Collect new data for 20 seconds at a 
% frequency of 10Hz
secs = 20;
sampleRate = 10;   
m = CollectData(sampleRate, secs, 'magfield');

% Retrieve the XYZ acceleration data
% and timestamps from the device

mag = magfieldlog(m);


%This will have a variable named: mag which contains
%magnetic field strength measured in the x,y, and z directions.
% Now that you have collected the data, 
% you will visualize what you measured.

% Calculate the magnitude of the 
% <X, Y, Z> acceleration vectors

x = mag(:,1);
y = mag(:,2);
z = mag(:,3);
figure('name','Magnetic Field Strength')
tiledlayout(2,1)
nexttile
h = surf(mag);
title('magnetic field strength')
xlabel('x') 
ylabel('y') 
zlabel('z') 
hold on 
image(mag) 
colormap autumn 
h.EdgeColor = 'none'; 
view(-30,10) 
set(gca,'FontSize', 18)

nexttile
plot(mag(:,1))
title('magnetic field strength')
hold on
plot(mag(:,2))
plot(mag(:,3))
legend(["x", "y", "z"]);
pbaspect([3 1 1]);
xlabel('Frames');
ylabel('Magnetic field strength');
set(gca,'FontSize', 18)
shg

% Caclulating summary statistics of the collected values
maxmagvalues=max(mag);
minmagvalues=min(mag);
stdmagvalues=std(mag);
rangestdvalues=range(mag);

% Visualizing the statistics of this data
figure('name','Boxplots of Magnitude Data')
boxplot(mag) 
title('Boxplots of Magnitude Data')
xlabel('Magnitude direction') 
ylabel('Magnetic field strength') 
xticklabels(["x","y","z"])
set(gca,'FontSize', 18)

% Exploring the ideal number of clusters for cluster analysis
eva = evalclusters(mag,'kmeans','CalinskiHarabasz','KList',1:6);

% Determining how the values maybe clustered (or not)

[idx,cc]=kmeans(mag,eva.OptimalK);

h=figure('name','Clusters of Magnetic Field Strength');
gscatter(x,y,idx,[])
title(["Clusters of"; "Magnetic Field Strength"])
hold on
plot(cc(:,1),cc(:,2),'kx')
h.Children(1).String(end) = {'Centriods'};
set(gca,'FontSize', 18)

warning On  % Re-enable warnings
%% Clean up
% Turn off the magentic sensor and
% clear mobiledev.

m.MagneticSensorEnabled=0;

clear m;
