function UpdateGlobals(mode)

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
global angle_est
global prev_angle
global speed_factor
global at_wall

% global n

% modes
normal = 1; dribbling = 2;

% temporary fix
% if (mode == dribbling)
	% mode = normal;
% end

prev_angle = angle_est;
angle_est = EstimateOrientation();


sensors = kProximity(ref);

	
% Determine if at wall
if ((mean(sensors(3:4)) > 20) && ~ball_in_view)
	if ((dir == 2) || (dir == 6))
		at_wall = true;
	end
end


if (mode == normal)

	% check the image to update goal location
	img = kLinVis(ref); % assumption: ref is a global variable to the connection to kiks
	encImg = EncodeImage2(img); % interprets image from camera
	% figure(6)
	% bar(encImg)
	% axis([0.5 64.5 0 5])

	vis = PostVisibility(encImg);
	UpdateOrientationState(); % searches for goal location in interpreted image. assumption: dir updates goal location

	% img_array{n} = encImg;
	% img_array = [img_array encImg];
	% n = n + 1;

	old_wheels = new_wheels;
	new_wheels = kGetEncoders(ref);

	wheel_speeds = kGetSpeed(ref);



	% DEBUG
	if (have_ball == true)
		have_ball;
	end
	
elseif (mode == dribbling)

	% check the image to update goal location
	img = kLinVis(ref); % assumption: ref is a global variable to the connection to kiks
	encImg = EncodeImage(img); % interprets image from camera

	vis = PostVisibility(encImg);
	UpdateOrientationState(); % searches for goal location in interpreted image. assumption: dir updates goal location
	if (dir == 9)
		dir = 4;
	elseif ((dir == 1) || (dir == 6))
		dir = 5;
	elseif ((dir == 7) || (dir == 2))
		dir = 3;
	end

	% img_array{n} = encImg;
	% img_array = [img_array encImg];
	% n = n + 1;

	old_wheels = new_wheels;
	new_wheels = kGetEncoders(ref);

	wheel_speeds = kGetSpeed(ref);

	% DEBUG
	if (have_ball == true)
		have_ball;
	end
	
	
end