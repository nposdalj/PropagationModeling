% plotSSP
% Plot Sound Speed Profile for region of choice.

% AD - in development

clearvars
close all

%% Parameters defined by user
filePrefix = 'OS_CCE1'; % File name to match.
siteabrev = 'WAT';
FilePath = 'C:\Users\HARP\Documents\MATLAB\Propagation Modelling';
NCfilePath = [FilePath,'\',siteabrev]; %directory of TPWS files
salfile   = 'rarchv.2018_331_00_3zs.nc'; % Enter salinity file here
tempfile  = 'rarchv.2018_331_00_3zs.nc'; % Enter temperature file here
depthfile = 'rarchv.2018_331_00_3zs.nc'; % Enter depth file here

latlims = [25 45];      % Enter desired lat limits here.  Rec for WAT: 25 45
longlims = [265 280];   % Enter desired long limits here. Rec for WAT: 265 280

%% load .NC files
ncdisp([NCfilePath,'\','rarchv.2018_331_00_3zs.nc']);
saldat = ncread([NCfilePath,'\','rarchv.2018_331_00_3zs.nc'], "salinity"); %Load salinity data
ncdisp([NCfilePath,'\','rarchv.2018_331_00_3zs.nc']);
tempdat = ncread([NCfilePath,'\','rarchv.2018_331_00_3zs.nc'], "salinity"); %Load salinity data
ncdisp([NCfilePath,'\','rarchv.2018_331_00_3zs.nc']);
depthdat = ncread([NCfilePath,'\','rarchv.2018_331_00_3zs.nc'], "salinity"); %Load salinity data

saldat = flip(permute(saldat, [2 1 3 4]),1); % To make map work, swaps lat/long and flips lat

lattwelfths = 12*latlims;   % Multiply lat, long values to work w/ HYCOM data (data every 1/12 degree)
longtwelfths = 12*longlims; 



layer1 = saldat(longtwelfths(1):longtwelfths(2),lattwelfths(1):lattwelfths(2),1);

figure(1) %map salinity @ 1m
layer1 = saldat(1:400,2550:3000,1);
heatmap(layer1, 'Colormap', turbo)
grid off
axis off

figure(2)
layer1 = saldat(1:400,2550:3000,10);
heatmap(layer1, 'Colormap', turbo)
grid off
