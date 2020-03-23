%This m-file generates the crisp output required

function Speed = GetCrispOutput(Distance,Angle)

[x, SpeedOutput]=MapOutput(Distance,Angle); % calls the MapOutput Function and receives x values and the corresponding Speed output values (mapped membership function)

%Using the centroid approach to get a crisp output
%centroid * sum of y-value = each x-value * each y-value
%thus centroid = (each x-value*corresponding y value)/sum of y-values

Speed = (x*transpose(SpeedOutput))/sum(SpeedOutput);

