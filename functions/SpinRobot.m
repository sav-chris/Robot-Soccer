function SpinRobot(angle)
% spins the robot towards left according to the given angle
% if angle is negative, it spins towards the right

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
global ball_details
global speed_factor
global saw_robot

pulsePerCycle=2031; %how many pulses (the robots measure of angle) that are in one 360 degree turn
saw_robot=0; %updated in ballDirection()

% kSetEncoders(ref,0,0); % makes sure encoders are zero initially
refEnc = KGetEncoders(ref); % get initial encoders
% refEnc = [0 0];
Enc=refEnc; % set encoders to initial encoders
x=round(angle*pulsePerCycle/360); %find how many pulses each degree corresponds to
targetEnc=refEnc + x*[-1;1]; %set target encoders to number of pulses

speed = 3;
% sets the speed of the robot wheels, and keeps it running at that speed
if (angle > 0)
    while (Enc(1)>targetEnc(1)) && (Enc(2)<targetEnc(2))
	    kSetSpeed(ref,-speed*speed_factor,speed*speed_factor);
        Enc = kGetEncoders(ref);
        
		UpdateGlobals(1);
		
        % check the image to see if ball found
        % [ballInView,haveBall,ballAngle,ballDistance] = BallDirection(encImg); % ball_in_view = 1 if found, 0 if not found
		%disp('==========================================');
        findBall = BallDirection();
		% ball_in_view
		% disp('==========================================');
		
		% if (ball_in_view)
            % break;
        % end
		
		% disp('top loop')
		if (ball_in_view)
			% disp('ball now in view')
			if (findBall(3) < 0)
				speed = 0.5;
			else
				speed = -0.5;
			end
		end
				
		% check to see if ball is in dead centre and update fully_aligned accordingly
		if (findBall(1) && (abs(findBall(3)) < 2))
			break;
		end
	end
else
    while (Enc(1)<targetEnc(1)) && (Enc(2)>targetEnc(2)) 
	    kSetSpeed(ref,speed*speed_factor,-speed*speed_factor);
        Enc = KGetEncoders(ref);
        
		UpdateGlobals(1);

        % check the image to see if ball found
        % [ballInView,haveBall,ballAngle,ballDistance] = BallDirection(encImg); % ball_in_view = 1 if found, 0 if not found
		% disp('==========================================');
        findBall = BallDirection();
		%ball_in_view
		%disp('==========================================');
		% have_ball
		
        % if (ball_in_view)
           % break;
        % end    
        	
		% disp('lower loop')
		if (ball_in_view)
			if (findBall(3) < 0)
				speed = -0.5;
			else
				speed = 0.5;
			end
		end
		
		% check to see if ball is in dead centre and update fully_aligned accordingly
		if (findBall(1) && (abs(findBall(3)) < 2))
			break;
		end
    end
end
disp('==========================================');
disp('finished SpinRobot');
disp('==========================================');

% now the robot has reached the desired angle
kSetSpeed(ref,0,0); % sets the speed to zero