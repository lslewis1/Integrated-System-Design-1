

% valid_valid_bishop.m will be called by t1_move_piece & t2_elim_piece
% for a bishop present on the board, check all valid moves
% for task 2, have to check if there are any pieces obstructing the travel
% path
global gamestate;

% the global row and column variables are used for the requested location
global row;
global column;
global output; %output 0 means invalid, output 1 is valid
global travel;
global iterator;    % keeps track of the position of the bishop in gamestate
global p_count;
global current_row;
global current_col;

bishop.INDEX = gamestate(iterator).INDEX;

% bishop can move diagonally (four diagonals)
% so if the bishop is in the range (user requested) it's a valid move
% check the gamestate struct and find the indexes of all pieces
% keeping in mind two indexes belong to the chosen bishop and the chosen
% opponent piece, respectively
% so, if an index is in the bishop's valid travel path and obstructs its path
% to the chosen opponent piece, then it is an invalid move

%update current locations
current_row= bishop.INDEX(2);
current_col= bishop.INDEX(1);

%default output
output=0;
   
r=current_row;
c=current_col;

b_rowss = [];
columns = [];
for i = 1:p_count
    if ~isempty(gamestate(i).INDEX)
        if (gamestate(i).INDEX(2) ~= current_row && gamestate(i).INDEX(1) ...
                ~= current_col) && (gamestate(i).INDEX(2) ~= row && ...
                gamestate(i).INDEX(1) ~= column)
            % don't include the chosen bishop or the chosen opponent piece
            % indexes, store indexes in separate arrays of b_rows and cols.
            b_rowss(i) = gamestate(i).INDEX(2);
            columns(i) = gamestate(i).INDEX(1);
        end
    end
end

% check down and right diagonal, row and column will be greater
while r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    r=r+1;
    c=c+1;
    if row==r && column==c && output~=1
        output=1;
        travel = row - current_row;
        if ~isempty(b_rowss) && ~isempty(columns)
            for j = 1:length(b_rowss)
                if b_rowss(j) > current_row && b_rowss(j) < row && ...
                        columns(j) > current_col && columns(j) < column
                    output = 0;
                    travel = 100;
                end
            end
        end
   %{
    else
        r=r+1;
        c=c+1;
   %}
    end
end

r=current_row;
c=current_col;
% check down and left diagonal, row greater; column less
while r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    r=r+1;
    c=c-1;
    if row==r && column==c && output~=1
        output=1;
        travel = row - current_row;
        if ~isempty(b_rowss) && ~isempty(columns)
            for j = 1:length(b_rowss)
                if b_rowss(j) > current_row && b_rowss(j) < row && ...
                        columns(j) < current_col && columns(j) > column
                    output = 0;
                    travel = 100;
                end
            end
        end
    %{
    else
        r=r+1;
        c=c-1;
    %}
    end
end



r=current_row;
c=current_col;
% check up and right diagonal, row less; column greater
while r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    r=r-1;
    c=c+1;
    if row==r && column==c && output~=1
        output=1;
        travel = current_row - row;
        if ~isempty(b_rowss) && ~isempty(columns)
            for j = 1:length(b_rowss)
                if b_rowss(j) < current_row && b_rowss(j) > row && ...
                        columns(j) > current_col && columns(j) < column
                    output = 0;
                    travel = 100;
                end
            end
        end
    %{
    else
        r=r-1;
        c=c+1;
        %}
    end
end



r=current_row;
c=current_col;
%check up and left diagonal, row less; column less
while r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    r=r-1;
    c=c-1;
    if row==r && column==c && output~=1
        output=1;
        travel = current_row - row;
        if ~isempty(b_rowss) && ~isempty(columns)
            for j = 1:length(b_rowss)
                if b_rowss(j) < current_row && b_rowss(j) > row && ...
                        columns(j) < current_col && columns(j) > column
                    output = 0;
                    travel = 100;
                end
            end
        end
    %{
    else
        r=r-1;
        c=c-1;
        %}
    end
end




    
