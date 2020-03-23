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
goal_hi = 89;			% may need to change
robot_lo = 90;			% these should be changed once the robot has been analysed
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
	if ((img(ii - 2) < goal_hi) && (img(ii - 1) < goal_hi) && (img(ii) < goal_hi) && (img(ii + 1) < goal_hi) && (img(ii + 2) < goal_hi))
		enc(ii) = GOAL;
	elseif ((img(ii - 2) < robot_hi) && (img(ii - 1) < robot_hi) && (img(ii) < robot_hi) && (img(ii + 1) < robot_hi) && (img(ii + 2) < robot_hi))
		if ((img(ii - 2) > robot_lo) && (img(ii - 1) > robot_lo) && (img(ii) > robot_lo) && (img(ii + 1) > robot_lo) && (img(ii + 2) > robot_lo))
			enc(ii) = ROBOT;
		end
	elseif ((img(ii - 2) < wall_hi) && (img(ii - 1) < wall_hi) && (img(ii) < wall_hi) && (img(ii + 1) < wall_hi) && (img(ii + 2) < wall_hi))
		if ((img(ii - 2) > wall_lo) && (img(ii - 1) > wall_lo) && (img(ii) > wall_lo) && (img(ii + 1) > wall_lo) && (img(ii + 2) > wall_lo))
			enc(ii) = WALL;
		end
	elseif ((img(ii - 2) > ball_lo) && (img(ii - 1) > ball_lo) && (img(ii) > ball_lo) && (img(ii + 1) > ball_lo) && (img(ii + 2) > ball_lo))
		enc(ii) = BALL;
	end
end

% For pixels that have 1 neighbour on one side
ii = 2;
if ((img(ii - 1) < goal_hi) && (img(ii) < goal_hi) && (img(ii + 1) < goal_hi) && (img(ii + 2) < goal_hi))
		enc(ii) = GOAL;
elseif ((img(ii - 1) < robot_hi) && (img(ii) < robot_hi) && (img(ii + 1) < robot_hi) && (img(ii + 2) < robot_hi))
	if ((img(ii - 1) > robot_lo) && (img(ii) > robot_lo) && (img(ii + 1) > robot_lo) && (img(ii + 2) > robot_lo))
		enc(ii) = ROBOT;
	end
elseif ((img(ii - 1) < wall_hi) && (img(ii) < wall_hi) && (img(ii + 1) < wall_hi) && (img(ii + 2) < wall_hi))
	if ((img(ii - 1) > wall_lo) && (img(ii) > wall_lo) && (img(ii + 1) > wall_lo) && (img(ii + 2) > wall_lo))
		enc(ii) = WALL;
	end
elseif ((img(ii - 1) > ball_lo) && (img(ii) > ball_lo) && (img(ii + 1) > ball_lo) && (img(ii + 2) > ball_lo))
		enc(ii) = BALL;
end

ii = 63;
if ((img(ii - 2) < goal_hi) && (img(ii - 1) < goal_hi) && (img(ii) < goal_hi) && (img(ii + 1) < goal_hi))
	enc(ii) = GOAL;
elseif ((img(ii - 2) < robot_hi) && (img(ii - 1) < robot_hi) && (img(ii) < robot_hi) && (img(ii + 1) < robot_hi))
	if ((img(ii - 2) > robot_lo) && (img(ii - 1) > robot_lo) && (img(ii) > robot_lo) && (img(ii + 1) > robot_lo))
		enc(ii) = ROBOT;
	end
elseif ((img(ii - 2) < wall_hi) && (img(ii - 1) < wall_hi) && (img(ii) < wall_hi) && (img(ii + 1) < wall_hi))
	if ((img(ii - 2) > wall_lo) && (img(ii - 1) > wall_lo) && (img(ii) > wall_lo) && (img(ii + 1) > wall_lo))
		enc(ii) = WALL;
	end
elseif ((img(ii - 2) > ball_lo) && (img(ii - 1) > ball_lo) && (img(ii) > ball_lo) && (img(ii + 1) > ball_lo))
	enc(ii) = BALL;
end

% For end pixels
ii = 1;
if ((img(ii) < goal_hi) && (img(ii + 1) < goal_hi) && (img(ii + 2) < goal_hi))
	enc(ii) = GOAL;
elseif ((img(ii) < robot_hi) && (img(ii + 1) < robot_hi) && (img(ii + 2) < robot_hi))
	if ((img(ii) > robot_lo) && (img(ii + 1) > robot_lo) && (img(ii + 2) > robot_lo))
		enc(ii) = ROBOT;
	end
elseif ((img(ii) < wall_hi) && (img(ii + 1) < wall_hi) && (img(ii + 2) < wall_hi))
	if ((img(ii) > wall_lo) && (img(ii + 1) > wall_lo) && (img(ii + 2) > wall_lo))
		enc(ii) = WALL;
	end
elseif ((img(ii) > ball_lo) && (img(ii + 1) > ball_lo) && (img(ii + 2) > ball_lo))
	enc(ii) = BALL;
end

ii = 64;
if ((img(ii - 2) < goal_hi) && (img(ii - 1) < goal_hi) && (img(ii) < goal_hi))
	enc(ii) = GOAL;
elseif ((img(ii - 2) < robot_hi) && (img(ii - 1) < robot_hi) && (img(ii) < robot_hi))
	if ((img(ii - 2) > robot_lo) && (img(ii - 1) > robot_lo) && (img(ii) > robot_lo))
		enc(ii) = ROBOT;
	end
elseif ((img(ii - 2) < wall_hi) && (img(ii - 1) < wall_hi) && (img(ii) < wall_hi))
	if ((img(ii - 2) > wall_lo) && (img(ii - 1) > wall_lo) && (img(ii) > wall_lo))
		enc(ii) = WALL;
	end
elseif ((img(ii - 2) > ball_lo) && (img(ii - 1) > ball_lo) && (img(ii) > ball_lo))
	enc(ii) = BALL;
end	
