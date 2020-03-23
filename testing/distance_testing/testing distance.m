% Distance testing

% These test images were used to determine  how many pixels the ball
% occupies with respect to the distance the ball is from the robot.

%Code used to determine distance
%--------------------------------

%robotPos=kiks_siminfo_robotpos;  %robot pos at 1:2 and 3rd col is yaw
%objectPos=kiks_siminfo_objects;  %ball position at 2:3 col
%xr=robotPos(1);     yr=robotPos(2);    yaw=robotPos(3);
%xb=objectPos(2);    yb=objectPos(3);
%distR_O = norm([xb;yb]- [xr;yr]);   %return distance (the range)
%distR_O = norm(objectPos(2:3)- robotPos(1:2)); %same as last 3 lines



%These image files were taken in decreasing length order

%POSITION 1
