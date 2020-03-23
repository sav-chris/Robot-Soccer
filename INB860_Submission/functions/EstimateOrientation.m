function angle = EstimateOrientation()
% Function that returns an integer representing an estimate of the angle of the robot in the playing field
%
% INPUTS:
% ref: reference to the robot
%
% RETURN VALUES:
% 0 - 360, with 0 degrees corresponding to facing due east, and angles measured anti-clockwise

global ref
global new_wheels
global angle_est

angle = 90;

% 20000 for each wheel corresponds to 10 rotations (therefore a difference of 40000) 4000 for 1 rotation

% This part of the code doesn't necessarily work at the moment
angle = ((new_wheels(2) - new_wheels(1))*360 / 4062) + 90; % present scaling factor is just an estimate
angle = mod(angle, 360);

angle_est = angle;