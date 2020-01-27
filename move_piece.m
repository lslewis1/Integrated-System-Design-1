% move_piece.m sends signals to the physical system components to execute a
% move opperation on the given piece
% then resets the unit to the origin point

% servo with claw set to 80,000 for open claw, 0 for closed claw
% 1 for CCW, 0 for CW on the stepper motors
% the pulse for the stepper motors needs to be stopped once they have
% reached the correct location, based on time calculation
% DC motor set to 0 degrees for up, high degrees for down

% move consists of having the stepper motors rotate in opposite directions
% until the unit has reached the correct row, then rotate in the same
% direction until the unit reaches the correct column
% slight pause
% open claw with 80000
% pause
% DC motor sent a high degree input to send the claw down to the piece
% pause when reaching final resting point
% close claw with 0
% pause
% reverse order on previous steps
% once piece is in the new location, send the unit back to the origin point
%clear;
%clc;

global current_row;
global current_col;

global row;
global column;

global claw_height;
claw_height = 1;

% test values
%current_row = 4;
%current_col = 4;

%row = 1;
%column = 1;

% claw_h is the degrees used to turn the DC motor
% calculated based on the claw height in inches
% *** 1 inch = _X_ degrees
% conversion is degrees = claw_height * X
X = 4000; % temporary
claw_h = claw_height * X;

% *** need to have a global variable that stores the claw height
% *** calculate degrees needed to reach this height and lower correctly
% global claw_height



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

% position over the row and column
run_time(time_y,2);
pause(time_y);
if current_col ~= 1
    run_time(time_x,1);
    pause(time_x);
end

% open the claw
%set_param('Final_system/hi_var', 'Value',  num2str(17000));
%pause(1);

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

% move the unit to the new location, given by row and column

if row == current_row
    if column > current_col
        time_x = x_move*(column - current_col);
        y = 1;
        
        run_time(time_x,y);
        pause(time_x);
    else
        time_x = x_move*(current_col - column);
        y = 3;
        
        run_time(time_x,y);
        pause(time_x);
    end
    
elseif column == current_col
    if row > current_row
        time_y = y_move*(row - current_row);
        y = 2;
        
        run_time(time_y,y);
        pause(time_y);
    else
        time_y = y_move*(current_row - row);
        y = 4;
        
        run_time(time_y,y);
        pause(time_y);
    end
    
else
    if row > current_row && column > current_col
        time_y = y_move*(row - current_row);
        y1 = 2;
        time_x = x_move*(column - current_col);
        y2 = 1;
        
        run_time(time_x,y2);
        pause(time_x);
        run_time(time_y,y1);
        pause(time_y);
        
    elseif row > current_row && column < current_col
        time_y = y_move*(row - current_row);
        y1 = 2;
        time_x = x_move*(current_col - column);
        y2 = 3;
        
        run_time(time_x,y2);
        pause(time_x);
        run_time(time_y,y1);
        pause(time_y);
        
    elseif row < current_row && column > current_col
        time_y = y_move*(current_row - row);
        y1 = 4;
        time_x = x_move*(column - current_col);
        y2 = 1;
        
        run_time(time_x,y2);
        pause(time_x);
        run_time(time_y,y1);
        pause(time_y);
        
    elseif row < current_row && column < current_col
        time_y = y_move*(current_row - row);
        y1 = 4;
        time_x = x_move*(current_col - column);
        y2 = 3;
        
        run_time(time_x,y2);
        pause(time_x);
        run_time(time_y,y1);
        pause(time_y);
    end
end

% lower claw
%dist_down = (-1 * claw_h);
set_param('Final_system/degrees', 'Value',  num2str(z_down));
pause(1.5);

% open claw
set_param('Final_system/hi_var', 'Value',  num2str(cl_open));
pause(2);

% raise claw
set_param('Final_system/degrees', 'Value',  num2str(z_up));
pause(1.5);

% close claw
set_param('Final_system/hi_var', 'Value',  num2str(cl_close));

% move unit back to origin point
if row == 1 && column == 1
    run_time(origin_to_y,4);
    pause(origin_to_y);

else
    if row == 1
        time_x = x_move*(column - 1);
        run_time(time_x,3);
        pause(time_x);
        
    elseif column == 1 && row ~= 1
        time_y = y_move*(row - 1);
        run_time(time_y,4);
        pause(time_y);
        
        
    else
        time_x = x_move*(column - 1);
        time_y = y_move*(row - 1);
        
        run_time(time_x,3);
        pause(time_x);
        run_time(time_y,4);
        pause(time_y);
    end
    run_time(origin_to_y,4);
    pause(origin_to_y);
end


set_param('Final_system/hi_var', 'Value',  num2str(cl_open));
% *** reset the claw to its topmost point, given by a positive degree that
% is (-1 * the total distance down constant) - claw_h
%dist_up = ((-1 * 4000) - claw_h);
%set_param('Final_system/degrees', 'Value',  num2str(.5*(dist_up)));



