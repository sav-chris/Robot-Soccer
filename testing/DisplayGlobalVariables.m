function x = DisplayGlobalVariables()

global ref
global dir
global goal_scored
global ball_in_view
global have_ball

x = [ref  dir  goal_scored 	ball_in_view  have_ball];

x = x'