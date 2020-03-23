function goal = GoalDirection()
% Function that returns an integer representing whether or not the target 
% is in view, and also an integer representing the approximate angle to 
% the centre of the goal, relative to a line perpindicular to the front of the robot.
%
% INPUTS:
% img : a 64x1 array of the encoded image
% dir : an integer representing the location of the target goal (see GoalLocation.m)
%
% RETURN VALUES:
% goal = [pres angle];
% pres = 2 : Target Goal is completely in view
% pres = 1 : Target Goal is partially in view
% pres = 0 : Target Goal is not in view

global dir
global encImg

% Parameters
camera_angle = 36;
num_pixels = 64;

% Initialise variables
pres = 0;
angle = 0;

% Determine if goal is in view or not
if (dir == 4)
	pres = 2;
elseif ((dir == 3) || (dir == 5))
	pres = 1;
elseif (dir == 6)
	angle = 120;
elseif (dir == 2)
	angle = -120;
elseif (dir == 7)
	angle = 180;
elseif (dir == 1)
	angle = -180;
elseif (dir == 9)
	angle = 180;
end

% Find pixel location of posts
posts = FindPosts(encImg);

% If goal is completely in view...
if (pres == 2)
	centre = mean(posts);
elseif (pres == 1)
	if (posts(1) == 0)
		centre = mean([0 posts(2)]);
	elseif (posts(2) == 0)
		centre = mean([posts(1) 64]);
	end
end

if (pres ~= 0)
	% determine angle to centre of visible goal
	angle = ((centre - ((num_pixels+1)/2))/64) * camera_angle;
end

goal = [pres angle];