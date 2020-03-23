function KickBall()

% Declare global variables
global ref
global dir
global goal_scored
global ball_in_view
global have_ball
global old_wheels
global new_wheels
global img
global encImg
global sensors
global wheel_speeds

% determine whether it should follow left or right (it should already be at the ball)
goal = GoalDirection();

goalAngle = goal(2);

if (goalAngle > 0)
	direction = false;
else
	direction = true
end

display('Dribble - about to enter FollowBall()');

EncircleBall(direction);	% keep encircling the ball, then turning and checking if inline with goal, before continuing with kick

fully_aligned = false;

% Then spin until it sees the ball/goal
while ((~fully_aligned) && (have_ball))      % potential infinite loop
	if (direction == true)
		SpinRobot(30);
	else
		SpinRobot(-30);
    end
	
    UpdateGlobals(1);
	findBall = BallDirection();
	
	% check to see if ball is in dead centre and update fully_aligned accordingly
	% if ((findBall(1)) && (abs(findBall(3)) < 2))
		% fully_aligned = true;
	% end
	
	if (~ball_in_view)
		if (direction == true)
			SpinRobot(-60);
		else
			SpinRobot(60);
	    end	
	end
	
    UpdateGlobals(1);
	findBall = BallDirection();
	
	% check to see if ball is in dead centre and update fully_aligned accordingly

	if (~ball_in_view)
		have_ball = false;
	else
		% Now kick the ball
		for (ii = 1:50)
			kSetSpeed(ref, 15, 15);
		end

		have_ball = false;
	end
	
	kSetSpeed(ref, 0, 0);
end


