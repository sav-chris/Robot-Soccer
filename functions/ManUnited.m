% -------------------------------------------------
%  2009 QUT Robot Soccer Project
%  Justin Eyles		justin.eyles@gmail.com
%  Magne Gasland	magnemg@gmail.com
%  Chris Savini		sav_chris13@hotmail.com
%  Stephen Vidas	stephen.vidas@gmail.com
% -------------------------------------------------
function ManUnited(port,baud,time)
% manager(port,baud,time)
% port = serial port to communicate with robot
% baud = baud rate
% time = time to run behaviour before terminatation

% Sets default input argument values
if (nargin < 3)	time = 240; end
if (nargin < 2) baud = 9600; end
if (nargin < 1) port = -1; end

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
global ball_dir		% 0 for unknown, 1 out of view but to the left, 2 in view to the left, 3 centre of view, 4 in view to the right, 5 out of view to the right
global angle_est
global speed_factor

speed_factor = 1;

% global n

% n = 1;

% Initialise Variables
goal_scored = false;
ball_in_view = false;
have_ball = false;
ball_dir = 0;
angle_est = 90;

% Establish communication with robot
kiks_kclose([]);
ref = kiks_kopen([port,baud,1]);
old_wheels = kGetEncoders(ref);
new_wheels = old_wheels;

% Initialise values
kSetEncoders(ref, 0, 0);
reflex = 0;
speed = [10 10];	% Will initial speed be required?
t0 = clock;
loops = 0;

% MASTER LOOP
% This loop will check if the match or new point has started before enterring the play loop
% This loop will only exit if the specified time before termination has been exceeded

% The robot's initial orientation state is facing forward towards its target goal
% However, it may be in state 3 or 5 rather than state 4, so this is checked
forward = 4;
dir = forward
UpdateGlobals(1);
% *** depending on whether it is golden goal or not, and if not if the robot is manually
% *** repositioned after each goal, this may need to be copied into the play loop.
% *** However, if it is golden goal, the play loop will still be required as it may repeat
% *** if control of the ball or knowledge of its location is lost during a play.
	
% PLAY LOOP
% This loop corresponds to a single play, commencing when the whistle is blown
% and terminating when a goal is scored by either player
while ((kiks_ktime(port) < time) && (~goal_scored))
    
	% DEBUG
	
		% FixedSpin(90);
		% while(1)
			
			% kSetSpeed(ref, 6, 4);
			% UpdateGlobals(1);
			% ball_details = BallDirection()
		% end
		
		if ((~ball_in_view) && (~goal_scored))
			SearchForBall();
		end
		
		display('manager - completed ActiveScan()');
		
		if (~have_ball && ~goal_scored && ball_in_view)
			ChaseBall();
		end
		
		display('manager - completed Chase()');
		
		if (have_ball && ~goal_scored && ball_in_view)
			KickBall();
		end
		
end