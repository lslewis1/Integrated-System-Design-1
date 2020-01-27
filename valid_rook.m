% valid_rook.m will be called by t1_move_piece
% for a rook present on the board, check all valid moves
% global ouput is the output from valid rook, 0 - invalid move, 1 - valid
% the output communicates with the GUI to display an error message or to
% carry through with the movement operation
% move isn't valid if another piece is obstructing the rook's path

global gamestate;
global output;
global iterator;    % keeps track of the position of the rook in gamestate
global p_count;

% the global row and column variables are used for the requested location
global row;
global column;
global travel; % only update travel if a valid move is found

global current_row;
global current_col;

rook.INDEX = gamestate(iterator).INDEX;
current_row = rook.INDEX(2);
current_col = rook.INDEX(1);

% rook can move 1 to 7 squares, forward, back, left, or right, regardless
% of the allignment, unless the path is obstructed

% check the gamestate struct and find the indexes of all pieces
% keeping in mind two indexes belong to the chosen rook and the chosen
% opponent piece, respectively
% so, if an index is in the rook's valid travel path and obstructs its path
% to the chosen opponent piece, then it is an invalid move
r_rowss = [];
columns = [];
for i = 1:p_count
    if ~isempty(gamestate(i).INDEX)
        if (gamestate(i).INDEX(2) ~= current_row && gamestate(i).INDEX(1) ...
                ~= current_col) && (gamestate(i).INDEX(2) ~= row && ...
                gamestate(i).INDEX(1) ~= column)
            % don't include the chosen rook or the chosen opponent piece
            % indexes, store indexes in separate arrays of r_rows and cols.
            r_rowss(i) = gamestate(i).INDEX(2);
            columns(i) = gamestate(i).INDEX(1);
        end
    end
end

if column == current_col
    
    if row == current_row || row > 8 || row < 1
        % invalid move
        output = 0;
    else
        % valid move
        output = 1;
        travel = row - current_row;
        if row > current_row && ~isempty(r_rowss) && ~isempty(columns)
            for j = 1:length(r_rowss)
                if r_rowss(j) > current_row && r_rowss(j) < row && columns(j) ...
                        == current_col
                    % invalid move, as there is a piece obstructing the
                    % rook's path to the opponent piece
                    output = 0;
                    travel = 100;
                end
            end
        elseif row < current_row && ~isempty(r_rowss) && ~isempty(columns)
            % row < current_row, moving up across the board
            for j = 1:length(r_rowss)
                if r_rowss(j) < current_row && r_rowss(j) > row && columns(j) ...
                        == current_col
                    % invalid move, as there is a piece obstructing the
                    % rook's path to the opponent piece
                    output = 0;
                    travel = 100;
                end
            end
        end            
    end
    
elseif row == current_row
    
    if column == current_col || column > 8 || column < 1
        % invalid move
        output = 0;
    else
        % valid move
        output = 1;
        travel = column - current_col;
        if column > current_col && ~isempty(r_rowss) && ~isempty(columns)
            for j = 1:length(columns)
                if columns(j) > current_col && columns(j) < column && ...
                        r_rowss(j) == current_row
                    % invalid move, as there is a piece obstructing the
                    % rook's path to the opponent piece
                    output = 0;
                    travel = 100;
                end
            end
        elseif column < current_col && ~isempty(r_rowss) && ~isempty(columns)
            % column < current_col, moving left across the board
            for j = 1:length(columns)
                if columns(j) < current_col && columns(j) > column && ...
                        r_rowss(j) == current_row
                    % invalid move, as there is a piece obstructing the
                    % rook's path to the opponent piece
                    output = 0;
                    travel = 100;
                end
            end
        end 
    end
    
else
    % invalid move
    output = 0;
    
end