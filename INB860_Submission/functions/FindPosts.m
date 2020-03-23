function posts = FindPosts(img)
% Function that looks for the goal posts in an encoded image, to hopefully help determine the path to the centre of the goal.
%
% inputs:
% img : a 64 x 1 array (Encoded image)
%
% Returns [<<location of left post in terms of pixels>> << location of right post in terms of pixels>>]
%
% If a post is not visible, a zero is returned for that element of the output array

% Find left most and right most greys, and then left most and right most blacks

% Pixel types
GOAL = 1;
ROBOT = 2;
WALL = 3;
BALL = 4;

% Initialization
l_wall = 0;
r_wall = 0;
l_goal = 0;
r_goal = 0;
l_post = 0;
r_post = 0;

% Post visibility
FAIL = 0; NO_GOAL = 1; LEFT_SIDE = 2; ENTIRE_GOAL = 3; RIGHT_SIDE = 4;

% Find leftmost wall pixel
ii = 1;

while ((l_wall == 0) && (ii < 65))
	if (img(ii) == 3)
		l_wall = ii;
	end
	ii = ii + 1;
end

% Find rightmost wall pixel
ii = 64;
while ((r_wall == 0) && (ii > 0))
	if (img(ii) == 3)
		r_wall = ii;
	end
	ii = ii - 1;
end

% Find leftmost goal pixel
ii = 1;
while ((l_goal == 0) && (ii < 65))
	if (img(ii) == 1)
		l_goal = ii;
	end
	ii = ii + 1;
end

% Find rightmost goal pixel
ii = 64;
while ((r_goal == 0) && (ii > 0))
	if (img(ii) == 1)
		r_goal = ii;
	end
	ii = ii - 1;
end

% If wall and goal was identified, and wall was to the left of the goal, then left post has been found
if ((l_wall ~= 0) && (l_goal ~= 0) && (l_wall < l_goal))
	l_post = l_goal;
end

% If wall and goal was identified, and wall was to the right of the goal, then left post has been found
if ((r_wall ~= 0) && (r_goal ~= 0) && (r_wall > r_goal))
	r_post = r_goal;
end
		
posts = [l_post r_post];