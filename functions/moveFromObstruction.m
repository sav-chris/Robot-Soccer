function moveFromObstruction()

% This function is entered if during the search for ball function, a full
% 360 degree turn is made and the ball is not sighted but an opposing robot
% is. Thus it is assumed the robot is obstructing the view of the ball.


%This function turns our robot 5 degrees and moves it a little bit so that 
%it can search for the ball again.


global ref

FixedSpin(5)

for i =1:200
    kSetSpeed(ref,5,5)
end

kSetSpeed(ref,0,0)