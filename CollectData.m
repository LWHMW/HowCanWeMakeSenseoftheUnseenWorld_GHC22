% This is code for Exercises 1 and 2 as part of the workshop  titled 
% 'How can we make sense of the unseen world: Using AI, Sensors, and IoT for Scene Exploration'. 
% Presented at the Women in Data Science (WiDS) conference in March 2022. 

function m = CollectData(sampleRate, secs, type)
if nargin < 3
    % Collect acceleration data if 'type' is not passed to the function.
    type = 'accel';
end

% Use the mobiledev command to create an 
% object that links your mobile device.
m = mobiledev;

% Set the sample rate
m.SampleRate = sampleRate;

% Enable acceleration or magnetic field sensor on the device.
if strcmp(type, 'accel')
    m.AccelerationSensorEnabled = 1;
elseif strcmp(type, 'magfield')
    m.MagneticSensorEnabled = 1;
else
    m.AccelerationSensorEnabled = 1;    
    warning("Third input to CollectData.m (type) must be either 'accel' to collect acceleration data, or 'magfield' to collect magnetic field data. Defaulting to 'accel'. ")    
end

% Display the mobiledev connection
% input(sprintf('Type 1 and press Return to start logging, then move for %d seconds.', secs));

% Start acquiring data 
m.Logging = true;

% Now that you have enabled logging, you are 
% acquiring sensor data. Please walk around the room 
% for the amount of time shown. You'll count the number of steps 
% that you took in the next part of this exercise.
disp(['Data will be collected for ' num2str(secs) ' seconds']) % or sprintf instead of disp
disp('Start Moving!') % zero seconds
for ii = 1:secs 
pause(1) 
disp(num2str(ii)) 
end 

% Stop acquiring data 
m.Logging = false; 

disp('Data collection complete.');
