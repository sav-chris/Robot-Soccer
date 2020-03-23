function alignment = CheckAlignment(left);

global encImg;
global dir;
global angle_est;

alignment = false;

% determine if these angles are similar enough using an error function
% tolerance = % some function of ball angle 

% disp('entered alignment func')

if ((left == true) && (dir == 2))
	if (abs(angle_est) > 60)
		alignment = true;
	end
elseif ((left == false) && (dir == 6))
	if (abs(angle_est - 180) > 60)
		alignment = true;
	end
end

% alignment

function tolerance = AngTol(angle)
g = @(x) (1/(180*sqrt(pi)))*exp(-x*x/(90*90*2));

tolerance = 240*(0.3 - g(angle));