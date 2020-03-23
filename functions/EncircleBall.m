% -----------------------------------------------------
%  (c) 2000-2004 Theodor Storm <theodor@tstorm.se>
%  http://www.tstorm.se
% -----------------------------------------------------
function EncircleBall(left)
% left is true when turning left,  false for right

global ref
global inline_with_goal
global dir
global angle_est
global speed_factor
global at_wall

% must spin 90 degrees before circling

inline_with_goal = 0;
deg = 0;
init_ang = 0;

display('---------------------------------');
disp('ENTERED EncircleBall()')
display('---------------------------------');


if (left)

	% depending on what the initial orientation was
	
	if ((dir == 2) || (dir == 1) || (dir == 3))
		deg = mod(angle_est, 360);
	end
	
	FixedSpin(-90);
	kSetSpeed(ref, 12*speed_factor, 21*speed_factor);
	
	init_ang = angle_est;
	
	 % disp('in left');
	
	% while (1)
	while ((angle_est < 350) && (angle_est > 10))		% goes in while loop when angle is between 10 and 350
		UpdateGlobals(1);
		disp('in left');
		deg;
		angle_est
		init_ang;
		
		% if (at_wall)
			% executes wall following behaviour for a few seconds (towards the goal)
			% if (dir == 2)
				% FollowWall(false,100);
			% else
				% FollowWall(true,100);
			% end
		% end
	end
	
	% debug
	% figure(5)
	% bar(encImg)
	
	kSetSpeed(ref, 0, 0);
	SpinRobot(90);
		
	% Continue moving around and checking whether ball is inline with goal
else

	if ((dir == 6) || (dir == 7) || (dir == 5))
		deg = mod(180 - angle_est, 360);
	end
	
	if (dir == 6)
		deg = 30;
	elseif (dir == 7)
		deg = 120;
	elseif (dir == 5)
		deg = 15;
	end
	
	FixedSpin(90);
	kSetSpeed(ref, 21*speed_factor, 12*speed_factor);
	
	init_ang = angle_est;
	
	% disp('in right')
	
	% while (1)
	while ((angle_est < 170) || (angle_est > 190))
		disp('in right')
		UpdateGlobals(1);
		deg;
		angle_est
		init_ang;
		
		% if (at_wall)
			% executes wall following behaviour for a few seconds (towards the goal)
			% if (dir == 2)
				% FollowWall(false,100);
			% else
				% FollowWall(true,100);
			% end
		% end
	end
	
	
	% debug
	% figure(5)
	% bar(encImg)
	
	kSetSpeed(ref, 0, 0);
	SpinRobot(-90);
end

display('---------------------------------');
disp('EXITING EncircleBall()')
display('---------------------------------');
return;
