function ball_details = BallDirection()

% This function calculates the angle between the ball and the robot and
% also estimates the distance between the robot and the ball. The function
% also returns whether the ball is in the image or not and whether the
% robot has possesion of the ball

%Output
%------
%ball_details=[ballInView,haveBall,ballAngle,ballDistance]

%ballInView
% 0 : ball is in view
% 1 : the ball is not in view

%haveBall
% 0 : we do not have the ball
% 1 : we have the ball

% Declare global variables
global ref
global dir
global goal_scored
global ball_in_view
global have_ball
global sensors
global ball_dir
global encImg
global ball_details
global saw_robot

%Input parameter: encoded image

% 0 : Ambiguous
% 1 : Goal
% 2 : Robot
% 3 : Wall
% 4 : Ball

ballInView = 0;
haveBall=0;
ballAngle=0;
ballDistance=0;
ball_in_front = 0;

%constant
degreesOfView=36;

% to determine if robot was sighted
for i=1:64
    if encImg(i)==2
        saw_robot=1;
    end
end

% to find left ball edge
left_ball_edge = 0;
for i = 1:61
	if ((encImg(i) ~= 4) && (encImg(i+1) ~= 4) && (encImg(i+2) == 4) && (encImg(i+3) == 4))
		left_ball_edge = i + 1.5;
	end
end


% to find right ball edge

right_ball_edge = 0;
for i = 1:61
	if ((encImg(i) == 4) && (encImg(i+1) == 4) && (encImg(i+2) ~= 1) && (encImg(i+3) ~= 1))
		right_ball_edge = i + 1.5;
	end
end


% to find the angle of the ball

if (left_ball_edge ~=0) && (right_ball_edge ~=0)  %the ball is completely in view
    ballFound=1;
    ballCentre = (left_ball_edge + right_ball_edge)/2;
    ballAngle=((ballCentre-32)/64)*degreesOfView;
end


% to find the number of pixels the ball occupies in image

number_of_ball_pixels=0;
for j=1:64
    if (encImg(j) == 4)
        number_of_ball_pixels=number_of_ball_pixels+1;
    end
end

% to find estimate ball distance

ballDistance=55+1251*exp(-.07*number_of_ball_pixels);

% Determine if ball is in view
if ((right_ball_edge ~= 0) && (left_ball_edge ~= 0))
	ballInView = 1;
end

% Check if proximity sensors are consistent with ball possession
if ((mean(sensors(3:4)) > 20) && ~have_ball) 
	ball_in_front = true;
end

if ((ballDistance < 400) && (ball_in_front))	% This test isn't great - if the ball isn't fully in view than the distance estimate isn't accurate
	haveBall = 1;
end

% DEBUG (should supress output)
ball_details=[ballInView,haveBall,ballAngle,ballDistance];


% Change global variables
ball_in_view = ballInView;
have_ball = haveBall;

% if it can't see the ball, it looks at the previous ball_dir state to determine what the new state probably is
if (ball_in_view)
	if (ballAngle > 0)
		ball_dir = 4;
	elseif (ballAngle < 0)
		ball_dir = 2;
	elseif (ballAngle == 0)
		ball_dir = 3;
	end
elseif (~ball_in_view)
	if (ball_dir == 2)
		ball_dir = 1;
	elseif (ball_dir == 4)
		ball_dir = 5;
	end
end

