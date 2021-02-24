%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: E:\LTTS\Matlab Intermediate\step_data.xlsx
%    Worksheet: in
%
% To extend the code for use with different selected data or a different
% spreadsheet, generate a function instead of a script.

%% Import the data
[raw0_0] = xlsread('C:\Users\Training\Desktop\99003563\MBD Training\Task2Matlab\Androsen.csv','A2:C1389');
[raw0_1] = xlsread("C:\Users\Training\Desktop\99003563\MBD Training\Task2Matlab\Androsen.csv", 'AF2:AF1389');
raw = [raw0_0,raw0_1];

%% Create output variable
data = raw;

%% Create table
stepdata = table;

%% Allocate imported array to column variable names
stepdata.ACCELEROMETERXms = data(:,1);
stepdata.ACCELEROMETERYms = data(:,2);
stepdata.ACCELEROMETERZms = data(:,3);
stepdata.Timesincestartinms = data(:,4);

%% Clear temporary variables
clearvars data raw raw0_0 raw0_1 R;
% Steps_acceleration
% Counts Number of Steps from Acceleration Data
ax=stepdata.ACCELEROMETERXms;
ay=stepdata.ACCELEROMETERYms;
az=stepdata.ACCELEROMETERZms;
t=stepdata.Timesincestartinms;
% Changes in Acceleration Sensors will indicate steps
disp('Walk Around')
mag = sqrt(sum(ax.^2 + ay.^2 + az.^2, 2));
disp(mag);
% Plot magnitude
subplot(3,1,1);
stem(t, mag);
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
title('Raw Magnitude')
% Remove effects of gravitity
magNoGrav = mag - mean(mag);
subplot(3,1,2);
stem(t, magNoGrav);
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
title('No Gravity')
% Absolute magnitude
amag = abs(magNoGrav);
subplot(3,1,3);
stem(t, amag);
title('Absolute Magnitude')
xlabel('Time (s)');
ylabel('Acceleration Magnitude, No Gravity (m/s^2)');
% steo counting
THR = 2;
n = 1;
peaks = [1000];
peaksi = [1000];
minMag = std(amag);
for k = 2:length(amag)-1
 if (amag(k) > minMag) && ... 
 (amag(k) > THR*amag(k-1)) && ... 
 (amag(k) > THR*amag(k+1))

 peaks(n) = amag(k);
 peaksi(n) = t(k);
 n = n + 1;
 end
end
if isempty(peaks)
 disp('No Steps')
 return
end
nSteps = length(peaks);
disp('Number of Steps:')
disp(nSteps)
% Plot markers at peaks
hold on;
plot(peaksi, peaks, 'r', 'Marker', 'v', 'LineStyle', 'none');
hold off;
