function vis = PostVisibility(img)
% Function that returns an integer representing one of several possible views
%
% INPUTS:
% img : a 64x1 array (encoded image)
%
% RETURN VALUES:
% 0 : FAIL
% 1 : No goal in the image
% 2 : Left side of goal only
% 3 : Entire goal visible OR nothing but the goal is visible
% 4 : Right side of goal only

NO_GOAL = 1;
LEFT_SIDE = 2;
GOAL = 3;	% could either be with both posts found, or only one post found
RIGHT_SIDE = 4;

vis = 0;

posts = FindPosts(img);

if ((posts(1) ~= 0) && (posts(2) ~= 0))
	vis = GOAL;
elseif ((posts(1) ~= 0) && (posts(2) == 0))
	vis = LEFT_SIDE;
elseif ((posts(1) == 0) && (posts(2) ~= 0))
	vis = RIGHT_SIDE;
else
	% this could either mean that the goal is not in view, or alternatively that the goal is all that is in view
	% first search for some goal
	for (ii = 1:64)
		if (img(ii) == 1)
			vis = GOAL;
		end
	end
	if (vis ~= GOAL)
		vis = NO_GOAL;
	end
end
	
vis;
