function SearchForBall()

% presumes global variables:
% BallFound
% ref
% dir - the state the robot is facing

% Declare global variables
global ref
global dir
global goal_scored
global ball_in_view
global have_ball
global img
global encImg
global ball_dir
global speed_factor
global saw_robot

left = 1;
right = -1;
fact = left;	% default

while (~ball_in_view)    

	if ((ball_dir == 1))
		fact = left;
	elseif (ball_dir == 5)
		fact = right;
	end
	
	% Spin(60*fact); %% spin 30 degrees left
	% if (ball_in_view)
		% break;
	% end
	
	% Spin(60*fact); %% spin back to original orientation
	% if (ball_in_view)
		% break;
	% end
	
	disp('==========================================');
	disp('Search: commence spin');
	disp('==========================================');	
	SpinRobot(360*fact); %% spin 360 degrees left (ending in original orientation)
	if (ball_in_view)
		break; 
    end
    
    if (~ball_in_view) && (saw_robot==1)
        % moveFromObstruction()
    end
	
	% ball_in_view
	
	% move random direction (not into wall), with speed X for time Y
	%kSetSpeed(ref,rand(1)*20,rand(1)*20);
end

disp('==========================================');
disp('Search: finished spin');
disp('==========================================');