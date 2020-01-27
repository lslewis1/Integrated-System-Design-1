% t2_elim_piece.m
% task 2 checks the valid moves for each piece
% aligned with the user
% compares valid moves to the index of the chosen opponent piece
% for each valid index that matches the location of the chosen opponent
% piece find the piece that can complete the action with the shortest
% travel path

% pieces, with the exception of the knight, cannot travel if their path is
% obstructed by another piece

global gamestate;
global op;
global t2_error;
t2_error = 0;
global iterator;        % keeps track of chosen piece in gamestate
global output;      % returned by each of the valid_x functions
global row;
global column;
global travel;
global current_row;
global current_col;
global p_count;

op_index = op.INDEX;
op_row = op_index(2);
op_column = op_index(1);

row = op_row;
column = op_column;
   
for iterator = 1:p_count
    
    if strcmp(gamestate(iterator).ALLIGNMENT, 'Player') == 1
        % player piece found, check its valid moves versus the op index
        switch gamestate(iterator).PIECETYPE
            
            case 'Pawn'
                valid_pawn2();
                % check the value of output, if valid move, check the
                % travel distance
                if output == 1
                    % the pawn can move to the opponent piece location
                    distances(iterator) = travel;
                    pieces{iterator} = 'Pawn';
                end
                
            case 'Rook'
                valid_rook();
            
                if output == 1
                    % the rook can move to the opponent piece location
                     
                    distances(iterator) = travel;
                    pieces{iterator}  = 'Rook';
                    
                end
                
            case 'Bishop'
                valid_bishop();
                if output == 1
                    % the bishop can move to the opponent piece location
                    distances(iterator) = travel;
                     pieces{iterator}  = 'Bishop';
                end
                
            case 'Knight'
                valid_knight();
                if output == 1
                    % the knight can move to the opponent piece location
                    distances(iterator) = travel;
                    pieces{iterator}  = 'Knight';
                end
                
            case 'Queen'
                valid_queen();
                if output == 1
                    % the queen can move to the opponent piece location
                    distances(iterator) = travel;
                    pieces{iterator}  = 'Queen';
                end
                
            case 'King'
                valid_king();
                if output == 1
                    % the king can move to the opponent piece location
                    distances(iterator) = travel;
                     pieces{iterator}  =  'King';
                   
                end
        end
                    
        
    end
    
end



% if no distances are found, no piece can complete the task, so send an
% error message
if isempty(distances)
    t2_error = 1;
else

    % choose the piece with the shortest travel distance, referenced by the index variable,
    % to the op index
    % move the opponent piece out of the way and move the user piece to the
    % location
    % travel distance should be found in each valid_x function, where the
    % distance is found by adding the change in row and column
    % if the distance value is equal for multiple pieces, check the actual
    % distance between centroids using the distance formula

    min_dist = distances(1);
    index = 1;
    for j = 1:length(distances)
        if distances(j) < min_dist && distances(j) ~= 0
            min_dist = distances(j);
            index = j;
        end
    end
    
    mp = pieces(index);     
    temp_count = 0;
    
    for k = 1:p_count
        if (strcmp(gamestate(k).PIECETYPE, mp) == 1) && ...
                (strcmp(gamestate(k).ALLIGNMENT, 'Player') == 1)
            % valid piece with shortest distance found on the board
            % first move the opponent piece off of the board
            % then move user piece to the taken location
            % elim_piece() moves uses row and column global variables
            temp_count = temp_count + 1;
            current_row = op_row;
            current_col = op_column;
            
            elim_piece();
  
            current_row = gamestate(k).INDEX(2);
            current_col = gamestate(k).INDEX(1);
            
            row = op_row;
            column = op_column;
            
            move_piece();
        end
    end
    %{
    if temp_count == 0
        t2_error = 1;
    end
    %}
end

