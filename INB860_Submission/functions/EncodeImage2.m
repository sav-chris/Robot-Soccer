function enc = EncodeImage(img)
% Function that encodes image information in a 64 x 1 array
%
% INPUTS:
% img : a 64x1 array
%
% RETURN VALUES:
% enc : a 64 x 1 array
%
% Each 'pixel' is assigned one of the following values, depending on what category it is identified with
% 0 : Ambiguous
% 1 : Goal
% 2 : Robot
% 3 : Wall
% 4 : Ball

%Image Classification
AMBIGUOUS = 0; GOAL = 1; ROBOT = 2; WALL = 3; BALL = 4;

% Define Limits
goal_hi = 90;			% may need to change
robot_lo = 91;			% these should be changed once the robot has been analysed
robot_hi = 115;			% ditto
wall_lo = 116;			% may need to change
wall_hi = 150;
ball_lo = 151;

% Average values suggested by Tutor
% ball = 240
% wall = 120
% robot = 70
% goal < 40

% Initialise return array
enc = zeros(1,64);

% For all pixels that have 2 neighbours either side
for (ii = 3:62)
	if (mean(img(ii-2:ii+2)) < goal_hi)
		enc(ii) = GOAL;
	elseif ((mean(img(ii-2:ii+2)) < robot_hi) && (mean(img(ii-2:ii+2)) > robot_lo))
		enc(ii) = ROBOT;
	elseif ((mean(img(ii-2:ii+2)) < wall_hi) && (mean(img(ii-2:ii+2)) > wall_lo))
		enc(ii) = WALL;
	elseif (mean(img(ii-2:ii+2)) > ball_lo)
		enc(ii) = BALL;
	end
end

% For pixels that have 1 neighbour on one side
ii = 2;
if (mean(img(ii-1:ii+2)) < goal_hi)
	enc(ii) = GOAL;
elseif ((mean(img(ii-1:ii+2)) < robot_hi) && (mean(img(ii-1:ii+2)) > robot_lo))
	enc(ii) = ROBOT;
elseif ((mean(img(ii-1:ii+2)) < wall_hi) && (mean(img(ii-1:ii+2)) > wall_lo))
	enc(ii) = WALL;
elseif (mean(img(ii-1:ii+2)) > ball_lo)
	enc(ii) = BALL;
end

ii = 63;
if (mean(img(ii-2:ii+1)) < goal_hi)
	enc(ii) = GOAL;
elseif ((mean(img(ii-2:ii+1)) < robot_hi) && (mean(img(ii-2:ii+1)) > robot_lo))
	enc(ii) = ROBOT;
elseif ((mean(img(ii-2:ii+1)) < wall_hi) && (mean(img(ii-2:ii+1)) > wall_lo))
	enc(ii) = WALL;
elseif (mean(img(ii-2:ii+1)) > ball_lo)
	enc(ii) = BALL;
end

% For end pixels
ii = 1;
if (mean(img(ii:ii+2)) < goal_hi)
	enc(ii) = GOAL;
elseif ((mean(img(ii:ii+2)) < robot_hi) && (mean(img(ii:ii+2)) > robot_lo))
	enc(ii) = ROBOT;
elseif ((mean(img(ii:ii+2)) < wall_hi) && (mean(img(ii:ii+2)) > wall_lo))
	enc(ii) = WALL;
elseif (mean(img(ii:ii+2)) > ball_lo)
	enc(ii) = BALL;
end

ii = 64;
if (mean(img(ii-2:ii)) < goal_hi)
	enc(ii) = GOAL;
elseif ((mean(img(ii-2:ii)) < robot_hi) && (mean(img(ii-2:ii)) > robot_lo))
	enc(ii) = ROBOT;
elseif ((mean(img(ii-2:ii)) < wall_hi) && (mean(img(ii-2:ii)) > wall_lo))
	enc(ii) = WALL;
elseif (mean(img(ii-2:ii)) > ball_lo)
	enc(ii) = BALL;
end

% Now add white gaps
% Initialise return array
enc2 = zeros(1,64);

% For all pixels that have 2 neighbours either side
for (ii = 3:62)
	if ((enc(ii - 2) == GOAL) && (enc(ii - 1) == GOAL) && (enc(ii) == GOAL) && (enc(ii + 1) == GOAL) && (enc(ii + 2) == GOAL))
		enc2(ii) = GOAL;
	elseif ((enc(ii - 2) == ROBOT) && (enc(ii - 1) == ROBOT) && (enc(ii) == ROBOT) && (enc(ii + 1) == ROBOT) && (enc(ii + 2) == ROBOT))
		enc2(ii) = ROBOT;
	elseif ((enc(ii - 2) == WALL) && (enc(ii - 1) == WALL) && (enc(ii) == WALL) && (enc(ii + 1) == WALL) && (enc(ii + 2) == WALL))
		enc2(ii) = WALL;
	elseif ((enc(ii - 2) == BALL) && (enc(ii - 1) == BALL) && (enc(ii) == BALL) && (enc(ii + 1) == BALL) && (enc(ii + 2) == BALL))
		enc2(ii) = BALL;
	end
end

% For pixels that have 1 neighbour on one side
ii = 2;
if ((enc(ii - 1) == GOAL) && (enc(ii) == GOAL) && (enc(ii + 1) == GOAL) && (enc(ii + 2) == GOAL))
	enc2(ii) = GOAL;
elseif ((enc(ii - 1) == ROBOT) && (enc(ii) == ROBOT) && (enc(ii + 1) == ROBOT) && (enc(ii + 2) == ROBOT))
	enc2(ii) = ROBOT;
elseif ((enc(ii - 1) == WALL) && (enc(ii) == WALL) && (enc(ii + 1) == WALL) && (enc(ii + 2) == WALL))
	enc2(ii) = WALL;
elseif ((enc(ii - 1) == BALL) && (enc(ii) == BALL) && (enc(ii + 1) == BALL) && (enc(ii + 2) == BALL))
	enc2(ii) = BALL;
end

ii = 63;
if ((enc(ii - 2) == GOAL) && (enc(ii - 1) == GOAL) && (enc(ii) == GOAL) && (enc(ii + 1) == GOAL))
	enc2(ii) = GOAL;
elseif ((enc(ii - 2) == ROBOT) && (enc(ii - 1) == ROBOT) && (enc(ii) == ROBOT) && (enc(ii + 1) == ROBOT))
	enc2(ii) = ROBOT;
elseif ((enc(ii - 2) == WALL) && (enc(ii - 1) == WALL) && (enc(ii) == WALL) && (enc(ii + 1) == WALL))
	enc2(ii) = WALL;
elseif ((enc(ii - 2) == BALL) && (enc(ii - 1) == BALL) && (enc(ii) == BALL) && (enc(ii + 1) == BALL))
	enc2(ii) = BALL;
end

% For end pixels
ii = 1;
if ((enc(ii) == GOAL) && (enc(ii + 1) == GOAL) && (enc(ii + 2) == GOAL))
	enc2(ii) = GOAL;
elseif ((enc(ii) == ROBOT) && (enc(ii + 1) == ROBOT) && (enc(ii + 2) == ROBOT))
	enc2(ii) = ROBOT;
elseif ((enc(ii) == WALL) && (enc(ii + 1) == WALL) && (enc(ii + 2) == WALL))
	enc2(ii) = WALL;
elseif ((enc(ii) == BALL) && (enc(ii + 1) == BALL) && (enc(ii + 2) == BALL))
	enc2(ii) = BALL;
end

ii = 64;
if ((enc(ii - 2) == GOAL) && (enc(ii - 1) == GOAL) && (enc(ii) == GOAL))
	enc2(ii) = GOAL;
elseif ((enc(ii - 2) == ROBOT) && (enc(ii - 1) == ROBOT) && (enc(ii) == ROBOT))
	enc2(ii) = ROBOT;
elseif ((enc(ii - 2) == WALL) && (enc(ii - 1) == WALL) && (enc(ii) == WALL))
	enc2(ii) = WALL;
elseif ((enc(ii - 2) == BALL) && (enc(ii - 1) == BALL) && (enc(ii) == BALL))
	enc2(ii) = BALL;
end

enc = enc2;