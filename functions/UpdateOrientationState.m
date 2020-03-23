function UpdateOrientationState()
% Function that returns an integer representing the direction of the target goals, based on
% the previous value, and a current and previous image.
%
% INPUTS:
% curr_im64 : a 64x1 array
% prev_pos    : an integer
% old_wheels : previous wheel encoder values
% new_wheels: current wheel encoder values
%
% RETURN VALUES:
% 0 : FAIL
% 1: Goal is left and WAY off screen (own goal is partially visible)
% 2: Goal is left and off screen
% 3: Goal is left and partially on screen
% 4: Goal is in current view
% 5: Goal is right and partially on screen
% 6: Goal is right and off screen
% 7: Goal is right and WAY off screen (own goal is partially visible)
% 9: Goal is approximately 180 degrees (own goal is fully visible)

global encImg
global dir
global old_wheels
global new_wheels
global goal_details
global angle_est
global prev_angle
global ref

% Initialise variables
new_dir = 0;
angle_threshold = 60;

vis = 0;

% Find what part of which goal (if any) is visible
vis = PostVisibility(encImg);

% Default arguments (TEMPORARY ONLY)
if (nargin < 4) new_wheels = [0 0]; end
if (nargin < 3) old_wheels = [0 0]; end

% Calculate whether robot has rotated clockwise or anti clockwise (anti clockwise is positive)
% If the robot skips a state, the difference in wheel encoders should help figure out which state it's in

rotation = angle_est - prev_angle;

if (rotation > 180)
	rotation = rotation - 180;
elseif (rotation < -180)
	rotation = rotation + 180;
end

%Compass directions
SE = 1; E = 2; NE = 3; N = 4; NW = 5; W = 6; SW = 7; S = 9;
% Post visibility
FAIL = 0; NO_GOAL = 1; LEFT_SIDE = 2; ENTIRE_GOAL = 3; RIGHT_SIDE = 4;


% STATE CHANGER
if (dir == SE)
    if (vis == LEFT_SIDE)
        new_dir = SE;
    elseif (vis == NO_GOAL)
		new_dir = E;
	elseif (vis == ENTIRE_GOAL)
		new_dir = S;
	elseif (vis == RIGHT_SIDE)
		if (angle_est < 180)
			new_dir = NE;
		else
			new_dir = SW;
		end
	end
elseif (dir == E)
	if (vis == NO_GOAL)
		new_dir = E;
	elseif (vis == LEFT_SIDE)
		new_dir = SE;
	elseif (vis == RIGHT_SIDE)
		new_dir = NE;
	elseif (vis == ENTIRE_GOAL)
		if (angle_est < 180)
			new_dir = N;
		else
			new_dir = S;
		end
	end
elseif (dir == NE)
	if (vis == RIGHT_SIDE)
	    new_dir = NE;
	elseif (vis == NO_GOAL)
		new_dir = E;
	elseif (vis == ENTIRE_GOAL)
		new_dir = N;
	elseif (vis == LEFT_SIDE)
		if (angle_est < 180)
			new_dir = NW;
		else
			new_dir = SE;
		end
	end
elseif (dir == N)
	if (vis == ENTIRE_GOAL)
		new_dir = N;
	elseif (vis == RIGHT_SIDE)
		new_dir = NE;
	elseif (vis == LEFT_SIDE)
		new_dir = NW;
	elseif (vis == NO_GOAL)
		if ((angle_est < 90) || (angle_est > 270))
			new_dir = E;
		else
			new_dir = W;
		end
	end
elseif (dir == NW)
	if (vis == LEFT_SIDE)
		new_dir = NW;
	elseif (vis == ENTIRE_GOAL)
		new_dir = N;
	elseif (vis == NO_GOAL)
		new_dir = W;
	elseif (vis == RIGHT_SIDE)
		if (angle_est < 180)
			new_dir = NE;
		else
			new_dir = SW;
		end
	end
elseif (dir == W)
	if (vis == NO_GOAL)
		new_dir = W;
	elseif (vis == LEFT_SIDE)
		new_dir = NW;
	elseif (vis == RIGHT_SIDE)
		new_dir = SW;
	elseif (vis == ENTIRE_GOAL)
		if (angle_est < 180)
			new_dir = N;
		else
			new_dir = S;
		end
	end
elseif (dir == SW)
	if (vis == RIGHT_SIDE)
		new_dir = SW;
	elseif (vis == NO_GOAL)
		new_dir = W;
	elseif (vis == ENTIRE_GOAL)
		new_dir = S;
	elseif (vis == LEFT_SIDE)
		if (angle_est < 180)
			new_dir = NW;
		else
			new_dir = SE;
		end
	end
elseif (dir == S)
	if (vis == ENTIRE_GOAL)
		new_dir = S;
	elseif (vis == LEFT_SIDE)
		new_dir = SE;
	elseif (vis == RIGHT_SIDE)
		new_dir = SW;
	elseif (vis == NO_GOAL)
		if ((angle_est < 90) || (angle_est > 270))
			new_dir = E;
		else
			new_dir = W;
		end
	end
end

% Correct any errors
if (new_dir == N)
	if (angle_est > 240)
        new_dir = S;
    end
elseif (new_dir == S)
    if (angle_est < 120)
        new_dir = N;
    end
end

if (new_dir == NE)
	if (angle_est > 240)
        new_dir = SW;
    end
elseif (new_dir == SW)
    if (angle_est < 120)
        new_dir = NE;
    end
end

if (new_dir == NW)
	if (angle_est > 240)
        new_dir = SE;
    end
elseif (new_dir == SE)
    if (angle_est < 120)
        new_dir = NW;
    end
end

% Reset encoder if facing (approximately) due north
if (new_dir == N)
    kSetEncoders(ref, 0, 0);
elseif (new_dir == S)
	kSetEncoders(ref, 0, 2031);
end

% if (abs(angle_est - 90) < 1)
	% kSetEncoders(ref, 0, 0);
% end

dir = new_dir;