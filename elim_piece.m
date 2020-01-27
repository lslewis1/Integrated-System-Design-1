% elim_piece.m removes a given piece from the board, similar to move_piece,
% but to a location not indexed

global current_row;
global current_col;
%global elim_time;

% test variables
%current_row = 1;
%current_col = 8;

global claw_height;
% claw_h is the degrees used to turn the DC motor
% calculated based on the claw height in inches
% *** 1 inch = _X_ degrees
% conversion is degrees = claw_height * X
X = 4000; % temporary
claw_h = claw_height * X;


x_move = 1.3;
y_move = 1.23;
origin_to_y = 3.3;

cl_open = 20000;
cl_close = 14000;
z_up = 0;
z_down = -5900;

switch current_row
    
    case 1
        time_y = origin_to_y;    
    case 2
        time_y = origin_to_y + y_move;
    case 3
        time_y = origin_to_y + (2*y_move);
    case 4
        time_y = origin_to_y + (3*y_move);
    case 5
        time_y = origin_to_y + (4*y_move);
    case 6
        time_y = origin_to_y + (5*y_move);
    case 7
        time_y = origin_to_y + (6*y_move);
    case 8
        time_y = origin_to_y + (7*y_move);
        
end

switch current_col
       
    case 2
        time_x = x_move;
    case 3
        time_x = 2*x_move;
    case 4
        time_x = 3*x_move;
    case 5
        time_x = 4*x_move;
    case 6
        time_x = 5*x_move;
    case 7
        time_x = 6*x_move;
    case 8
        time_x = 7*x_move;
        
end

% position over the current row and column
run_time(time_y,2);
pause(time_y);
if current_col ~= 1
    run_time(time_x,1);
    pause(time_x);
    %elim_time = time_y + time_x;
else
    %elim_time = time_y;
end



% open the claw
set_param('Final_system/hi_var', 'Value',  num2str(cl_open));
pause(1);

% lower the claw
%  *** claw is originally all the way up, need the distance for reaching a piece
% from its topmost point, will be constant
set_param('Final_system/degrees', 'Value',  num2str(z_down));
pause(1.5);

% close the claw on the piece
set_param('Final_system/hi_var', 'Value',  num2str(cl_close));
pause(1);

% raise the claw
set_param('Final_system/degrees', 'Value',  num2str(z_up));
pause(1.5);

%elim_time = elim_time + 4;

% move unit back to origin point
if current_row == 1 && current_col == 1
    run_time(origin_to_y,4);
    pause(origin_to_y);

    %elim_time = elim_time + origin_to_y;
else
    if current_row == 1
        time_x = x_move*(current_col - 1);
        run_time(time_x,3);
        pause(time_x);
        %elim_time = elim_time + time_x;
        
    elseif current_col == 1 && current_row ~= 1
        time_y = y_move*(row - 1);
        run_time(time_y,4);
        pause(time_y);
       % elim_time = elim_time + time_y;
        
    else
        time_x = x_move*(current_col - 1);
        time_y = y_move*(row - 1);
        
        run_time(time_x,3);
        pause(time_x);
        run_time(time_y,4);
        pause(time_y);
        
       % elim_time = elim_time + time_x + time_y;
    end
    run_time(origin_to_y,4);
    pause(origin_to_y);

    %elim_time = elim_time + origin_to_y;
end



% lower claw
%dist_down = (-1 * claw_h);
set_param('Final_system/degrees', 'Value',  num2str(z_down));
pause(1.5);

% open claw
set_param('Final_system/hi_var', 'Value',  num2str(cl_open));
pause(1);

% raise claw
set_param('Final_system/degrees', 'Value',  num2str(z_up));
pause(1.5);

% close claw
set_param('Final_system/hi_var', 'Value',  num2str(cl_close));


set_param('Final_system/hi_var', 'Value',  num2str(cl_open));
%elim_time = elim_time + 3;

% *** reset the claw to its topmost point, given by a positive degree that
% is (-1 * the total distance down constant) - claw_h
%dist_up = ((-1 * 4000) - claw_h);
%set_param('Final_system/degrees', 'Value',  num2str(.5*(dist_up)));


