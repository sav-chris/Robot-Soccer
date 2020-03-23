function x = InitializeGlobalVariables(temp_ref, temp_dir)
x = 0;

global ref
global dir
global goal_scored
global ball_in_view
global have_ball

ref = temp_ref;
dir = temp_dir;
goal_scored = false;
ball_in_view = false;
have_ball = false;

