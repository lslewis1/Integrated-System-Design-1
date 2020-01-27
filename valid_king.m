% valid_king.m will be called by t1_move_piece
% for a king present on the board, check all valid moves
% global ouput is the output from valid king, 0 - invalid move, 1 - valid
% the output communicates with the GUI to display an error message or to
% carry through with the movement operation


global gamestate;
global output;
global iterator;    % keeps track of the position of the king in gamestate

% the global row and column variables are used for the requested location
global row;
global column;
global travel; % travel is always a 1 for a valid king move
global current_row;
global current_col;

% king location will have the index, not pixel coordinates

king.INDEX = gamestate(iterator).INDEX;
current_row = king.INDEX(2);
current_col = king.INDEX(1);

vr1 = current_row + 1;
vr2 = current_row - 1;

vc1 = current_col + 1;
vc2 = current_col - 1;

if row > 8 || row < 1 || column > 8 || column < 1
    % invalid move
    output = 0;
    
elseif row == current_row && column == current_col
    % invalid move
    output = 0;

elseif row ~= current_row
    % this means up, down, or a diagonal movement
        
        if row ~= vr1 && row ~= vr2
            % invalid move
            output = 0;
        else
            
            if column == current_col
                % valid move (up or down one space)
                output = 1;
                travel = 1;
               
            else 
                
                if column ~= vc1 && column ~= vc2
                    % invalid move
                    output = 0;
                else 
                    % valid move (diagonally)
                    output = 1;
                    travel = 1;
                end
                
            end
            
        end
        
elseif row == current_row && column ~= current_col
    % left or right
    if column ~= vc1 && column ~= vc2
        % invalid move
        output = 0;
    else
        % valid move (left or right)
        output = 1;
        travel = 1;
    end
    
else
    % invalid move
    output = 0;
end


        