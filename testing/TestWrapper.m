% TESTING SCRIPT
% If currently in 'functions' folder, use the following command to execute this script:
% run '../scripts/TestWrapper.m'
kiks_kclose([]);
temp_ref = kiks_kopen([-1,9600,1]);
temp_dir = 4; 	% make sure robot is facing directly towards the target goal to begin with

InitializeGlobalVariables(temp_ref, temp_dir);
x = DisplayGlobalVariables();

