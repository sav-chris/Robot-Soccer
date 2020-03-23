function FixedSpin(angle)
% spins the robot towards left according to the given angle
% if angle is negative, it spins towards the right

global ref
global speed_factor

pulsePerCycle=2031; %how many pulses (the robots measure of angle) that are in one 360 degree turn

% kSetEncoders(ref,0,0); % makes sure encoders are zero initially
refEnc = KGetEncoders(ref); % get initial encoders
% refEnc = [0 0];
Enc=refEnc; % set encoders to initial encoders
x=round(angle*pulsePerCycle/360); %find how many pulses each degree corresponds to
targetEnc=refEnc + x*[-1;1]; %set target encoders to number of pulses

% sets the speed of the robot wheels, and keeps it running at that speed
if (angle > 0)
    kSetSpeed(ref,-5*speed_factor,5*speed_factor);
    while (Enc(1)>targetEnc(1)) && (Enc(2)<targetEnc(2))
        Enc = kGetEncoders(ref);
        
		UpdateGlobals(1);
		
        % check the image to see if ball found
        % [ballInView,haveBall,ballAngle,ballDistance] = BallDirection(encImg); % ball_in_view = 1 if found, 0 if not found
        BallDirection(); 
		
    end
else
    kSetSpeed(ref,5*speed_factor,-5*speed_factor);
    while (Enc(1)<targetEnc(1)) && (Enc(2)>targetEnc(2)) 
        Enc = KGetEncoders(ref);
        
		UpdateGlobals(1);

        % check the image to see if ball found
        % [ballInView,haveBall,ballAngle,ballDistance] = BallDirection(encImg); % ball_in_view = 1 if found, 0 if not found
		BallDirection();

    end
end
% now the robot has reached the desired angle
