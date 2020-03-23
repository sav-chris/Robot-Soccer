function testingDistance=KiksDistance()

robotPos=kiks_siminfo_robotpos;  %robot pos at 1:2 and 3rd col is yaw
objectPos=kiks_siminfo_objects;  %ball position at 2:3 col
xr=robotPos(1);     yr=robotPos(2);    yaw=robotPos(3);
xb=objectPos(2);    yb=objectPos(3);
distR_O = norm([xb;yb]- [xr;yr]);   %return distance (the range)


testingDistance=distR_O;