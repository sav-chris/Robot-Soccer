function DribbleBall()

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Create Fuzzy Descision Classifier 
delta = 0.5; lower = -30;  upper = 30;  %constants used for numerical integration

%create distance/angle matrix  DA
LN = 1;         %Large Negative     
 N = 2;         %Negative 
 Z = 3;         %Zero
 P = 4;         %Positive
LP = 5;         %Large Positive

%Distance Angle Matricies
   largeDist = [ [LP Z	N  N  LN]; 
                 [LP Z  N  LN LN];
                 [LP P  Z  N  LN];
                 [LP LP P  Z  LN];
                 [LP P  P  Z  LN]]';
          
positiveDist = [ [LP Z	N  N  LN]; 
                 [LP Z  N  LN LN];
                 [LP P  Z  N  LN];
                 [LP LP P  Z  LN];
                 [LP P  P  Z  LN]];
             
    zeroDist = [ [P  P  P  LP LP ]; 
                 [Z  P  P  LP LP ];
                 [N  N  Z  P  P  ];
                 [LN LN N  N  Z  ];
                 [LN LN N  N  N  ]];

% membership function constructors
   % h: height
   % w: width
   % d: centre
%                    Right End
% y ^
%   |
%   |
%   |
%   |                 
%   |                 0-------------------------->
%   |               / |                          
%   |              /  |                          
%   |             /   | h                        
%   |            /    |                          
%   |-----------0-----X--------------------------------->
%               |- w -|                                 x
%                     |
%                     |
%                     d
rightEnd = @(h, w, d) (@(x) ((((   h/w)*x + h*(1 - (  d/w))) * (x >= (d -  w   )) * (x <  d))  +  h*(x >= d))   );

%                  Left End
% y ^
%   |
%   |
%   |
%   |                 
%   |                 <--------------------------0
%   |                                            | \
%   |                                            |   \
%   |                                          h |     \
%   |                                            |       \
%   |-----------------------------------------------------0-------->
%                                                |-  w   -|         x
%                                                |
%                                                |
%                                                d
leftEnd = @(h, w, d) (@(x) ((((  -h/w)*x + h*(1 + (  d/w))) * (x <= (d +  w   )) * (x >  d))  +  h*(x <= d))   );

%                   Spike
% y ^
%   |
%   |
%   |
%   |                 
%   |                 0
%   |               / | \
%   |              /  |  \
%   |             /   |h  \
%   |            /    |    \
%   |-----------0-----X-----0---------------->
%               |-   w|    -|                x
%                     |
%                     |
%                     d
fuzzyMember = @(h, w, d) (@(x) (((( 2*h/w)*x + h*(1 - (2*d/w))) * (x >= (d - (w/2))) * (x <  d))  +  (((-2*h/w)*x + h*(1 + (2*d/w))) * (x <  (d + (w/2))) * (x >= d))));

%                 Generator for Trapezoidal Function
% y ^
%   |
%   |
%   |
%   |                 {------      w          ---}
%   |                 0--------------------------0
%   |               / |                          | \
%   |              /  |                          |   \
%   |             /   | h                        |     \
%   |            /    |                          |       \
%   |-----------0-----X-----------------------------------0-------->
%               |- b -|                          |-  a   -|         x
%                     |
%                     |
%                     d
trapezoid = @(h, b, w, a, d) @(x) ((h/b)*(x - d) + h)*(x >= d-b)*(x < d)  +   h*(x >= d)*(x < d+w)   +   (h/a)*(d+w+a-x)*(x >=d+w)*(x<=d+w+a) ;

%Angle Membership Function
LNf =     leftEnd(1,  6, -12);
 Nf = fuzzyMember(1, 12,  -6);
 Zf = fuzzyMember(1, 12,   0); 
 Pf = fuzzyMember(1, 12,   6);
LPf =    rightEnd(1,  6,  12);
AngleMembership = { LNf Nf Zf Pf LPf };

%Output Membership Function
outputMembershipFunction = { fuzzyMember(1, 20, -20) fuzzyMember(1, 20, -10) fuzzyMember(1, 20, 0) fuzzyMember(1, 20, 10) fuzzyMember(1, 20, 20) };

largeP   = @(goalAngle, ballAngle) FuzzyController(AngleMembership, AngleMembership, largeDist   , outputMembershipFunction, goalAngle, ballAngle, lower, upper, delta );
positive = @(goalAngle, ballAngle) FuzzyController(AngleMembership, AngleMembership, positiveDist, outputMembershipFunction, goalAngle, ballAngle, lower, upper, delta );
zeroDist = @(goalAngle, ballAngle) FuzzyController(AngleMembership, AngleMembership, zeroDist    , outputMembershipFunction, goalAngle, ballAngle, lower, upper, delta );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Distance Membership Function
    Zero = fuzzyMember(1, 0.4, 0);
Positive = trapezoid(1, 0.2, 0.2, 0.3, 0.2);
  LargeP = rightEnd(1, 0.3, 0.7);
DistanceMembership = {Zero Positive LargeP};


% determine whether it should follow left or right (it should already be at the ball)
goal = GoalDirection();

goalAngle = goal(2);

if (goalAngle > 0)
	direction = false;
else
	direction = true
end

display('Dribble - about to enter FollowBall()');

FollowBall(direction);	% get aligned with ball

fully_aligned = false;

% Then spin until it sees the ball/goal
while (~fully_aligned)
	if (direction == true)
		SpinRobot(1);
	else
		SpinRobot(-1);
	end
	
	findBall = BallDirection();
	
	% check to see if ball is in dead centre and update fully_aligned accordingly
	if ((findBall(1)) && (abs(findBall(3)) < 2))
		% findBall
		fully_aligned = true;
	end
	
end

display('Dribble - about to enter while loop if ball is possessed');

UpdateGlobals(2);
BallDirection()
have_ball

while (have_ball && ~goal_scored) % similar to Chase() loop
% Obtain ball direction and distance, and goal angle
	findBall = BallDirection();
	findGoal = GoalDirection();
	
	ballAngle = findBall(3);
	distance = findBall(4);
	goalAngle = findGoal(2);
	
    distanceClassifier = FuzzyClassify(DistanceMembership, distance);

    %Find the index of the largest probability
    currentMax = 0;
    desiredIndex = 0;
    for index = 1:3
        if currentMax < distanceClassifier(index)
            desiredIndex = index;
            currentMax = distanceClassifier(index);
        end;
    end;
    %%%%%%%%%%%%


    if desiredIndex == 1
        % we have selected the 'zero' clasifier
        wheelValue = zeroDist(goalAngle, ballAngle);
    end;

    if desiredIndex == 2
        % we have selected the 'Positive' clasifier
        wheelValue = positive(goalAngle, ballAngle);
    end;

    if desiredIndex == 3
        % we have selected the 'Large Positive' clasifier
        wheelValue = largeP(goalAngle, ballAngle);
    end;
	
	kSetSpeed(ref, 2 - (wheelValue*0.1), 2 + (wheelValue*0.1));
	
	UpdateGlobals(2);
	BallDirection();
	
end

have_ball
display('Dribble - Exited loop');