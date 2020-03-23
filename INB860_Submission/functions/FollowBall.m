% -----------------------------------------------------
%  (c) 2000-2004 Theodor Storm <theodor@tstorm.se>
%  http://www.tstorm.se
% -----------------------------------------------------
function FollowBall(left)
% left is true when turning left,  false for right

global ref
global inline_with_goal
global dir

inline_with_goal = false;

reflex = 0;
speed = [1 1];
loops=0; % for calculating loops/second, not needed for the simulation
t0=clock; % for calculating loops/second, not needed for the simulation

% kSetEncoders(ref,0,0);

   if left
      weightsL = [1 1 2 3 3 0 0 0 0];
      weightsR = [2 0 0 -3 -3 0 0 0 0];
   else
      weightsR = [1 1 2 3 3 0 0 0 0];
      weightsL = [2 0 0 -3 -3 0 0 0 0];
   end;
   
while (~inline_with_goal)

	reflex = kProximity(ref);
	speed = calcspd(weightsL,weightsR,reflex);
	kSetSpeed(ref,speed(1),speed(2));

	UpdateGlobals(1);
	
	inline_with_goal = CheckAlignment(left);
	
end;

display('FollowBall() - exited while loop');

kSetSpeed(ref,0,0);

% spin until facing ball and goal

function out = calcspd(weightsL, weightsR, reflex)
mL = weightsL(1);
mR = weightsR(1);
  for i=2:9
    mL = weightsL(i)*(1/1023)*reflex(i-1)+mL;
    mR = weightsR(i)*(1/1023)*reflex(i-1)+mR;
 end
out = [round(mL) round(mR)];
