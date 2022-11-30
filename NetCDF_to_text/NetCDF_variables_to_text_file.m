%
%   This matlab code writes a netcdf file's variables to seperate text
%   files.
%       vars.txt: number of variables (starts from zero)
%       varsizes.txt: dimensions of variables
%       varnames.txt: names of variables
%       var0,var1,....txt: variables (matrices/arrays)
%
%
%   Tahsin Gormus
%   April 2017, Istanbul
%
close all
clear
clc
delete varnames.txt
delete varsizes.txt
%% Directories
ReRun = 0; %If you want to convert the .nc file to a txt, make this equal to 1
NCdir = 'I:\My Drive\PropagationModeling\Bathymetry\GlobalCoverage\GEBCO\netCDF';
txtdir = 'I:\My Drive\PropagationModeling\Bathymetry\GlobalCoverage\GEBCO\txt';
NCfn = 'gebco_2022'; %.nc file name
%% NC to txt file
if ReRun == 1
ncid=netcdf.open([NCdir,'\',NCfn,'.nc'],'nowrite'); % 'xxx.nc': netcdf file name
vars=netcdf.inqVarIDs(ncid);
dlmwrite([txtdir,'\vars.txt'],vars);
for i=vars(1:end)
    [varname]=netcdf.inqVar(ncid,i);
    dlmwrite([txtdir,'\varnames.txt'],varname,'delimiter','','-append');
    var=netcdf.getVar(ncid,i);
    varsize=size(var);
    dlmwrite([txtdir,'\varsizes.txt'],varsize,'delimiter',';','-append');
    if numel(varsize)<3
        dlmwritetemp = sprintf('var%d.txt',i);
        dlmwrite([txtdir,'\',dlmwritetemp],var);
    elseif numel(varsize)==3
        for j=1:varsize(3)
            dlmwritetemp = sprintf('var%d.txt',i);
            dlmwrite([txtdir,'\',dlmwritetemp],var(:,:,j),'-append');
        end
    elseif numel(varsize)==4
        for j=1:(varsize(3)*varsize(4))
            dlmwritetemp = sprintf('var%d.txt',i);
            dlmwrite([txtdir,'\',dlmwritetemp],var(:,:,j),'-append');
        end
    end
end
else
%% Convert from grid to columns
%load txt files
latdir = [txtdir,'\var1.txt'];
lat = importdata(latdir);
londir = [txtdir,'\var0.txt'];
lon = importdata(londir);
depthdir = [txtdir,'\var3.txt'];
depth = importdata(depthdir);

[X,Y] = meshgrid (lat, lon);
end