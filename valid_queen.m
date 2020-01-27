

% valid_queen.m will be called by t1_move_piece
% for a queen present on the board, check all valid moves
% move isn't valid if another piece is obstructing the queen's path
global gamestate;

% the global row and column variables are used for the requested location
global row;
global column;
global output; %output 0 means invalid, output 1 is valid
global iterator;    % keeps track of the position of the queen in gamestate
global travel;
global p_count;
global current_row;
global current_col;

queen.INDEX = gamestate(iterator).INDEX;

%update current locations
current_row= queen.INDEX(2);
current_col= queen.INDEX(1);

% check the gamestate struct and find the indexes of all pieces
% keeping in mind two indexes belong to the chosen queen and the chosen
% opponent piece, respectively
% so, if an index is in the queen's valid travel path and obstructs its path
% to the chosen opponent piece, then it is an invalid move

%default output
output=0;
   
r=current_row;
c=current_col;

q_rowss = [];
columns = [];
for i = 1:p_count
    if ~isempty(gamestate(i).INDEX)
        if (gamestate(i).INDEX(2) ~= current_row && gamestate(i).INDEX(1) ...
                ~= current_col) && (gamestate(i).INDEX(2) ~= row && ...
                gamestate(i).INDEX(1) ~= column)
            % don't include the chosen queen or the chosen opponent piece
            % indexes, store indexes in separate arrays of q_rows and cols.
            q_rowss(i) = gamestate(i).INDEX(2);
            columns(i) = gamestate(i).INDEX(1);
        end
    end
end

%check down and right diagonal
while r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    r=r+1;
    c=c+1;
    if row==r && column==c && output~=1
        output=1;
        travel = row - current_row;
        if ~isempty(q_rowss) && ~isempty(columns)
            for j = 1:length(q_rowss)
                if q_rowss(j) > current_row && q_rowss(j) < row && ...
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
%check down and left diagonal
while r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    r=r+1;
    c=c-1;
    if row==r && column==c && output~=1
        output=1;
        travel = row - current_row;
        if ~isempty(q_rowss) && ~isempty(columns)
            for j = 1:length(q_rowss)
                if q_rowss(j) > current_row && q_rowss(j) < row && ...
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
%check up and right diagonal
while r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    r=r-1;
    c=c+1;
    if row==r && column==c && output~=1
        output=1;
        travel = column - current_col;
        if ~isempty(q_rowss) && ~isempty(columns)
            for j = 1:length(q_rowss)
                if q_rowss(j) < current_row && q_rowss(j) > row && ...
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
%check up and left diagonal
while r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    r=r-1;
    c=c-1;
    if row==r && column==c && output~=1
        output=1;
        travel = current_row - row;
        if ~isempty(q_rowss) && ~isempty(columns)
            for j = 1:length(q_rowss)
                if q_rowss(j) < current_row && q_rowss(j) > row && ...
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

r=current_row;
c=current_col;
%check down
while r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    r=r+1;    
    if row==r && column==c && output~=1
        output=1;
        travel = row - current_row;
        if ~isempty(q_rowss) && ~isempty(columns)
            for j = 1:length(q_rowss)
                if q_rowss(j) > current_row && q_rowss(j) < row && columns(j) ...
                        == current_col
                    % invalid move, as there is a piece obstructing the
                    % queen's path to the opponent piece
                    output = 0;
                    travel = 100;
                end
            end
        end
    %{
else
        r=r+1;  
      %}
    end
end

r=current_row;
c=current_col;
%check up
while r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    r=r-1;    
    if row==r && column==c && output~=1
        output=1;
        travel = current_row - row;
        if ~isempty(q_rowss) && ~isempty(columns)
            for j = 1:length(q_rowss)
                if q_rowss(j) < current_row && q_rowss(j) > row && columns(j) ...
                        == current_col
                    % invalid move, as there is a piece obstructing the
                    % queen's path to the opponent piece
                    output = 0;
                    travel = 100;
                end
            end
        end
   %{
 else
        r=r-1;  
      %}
    end
end


r=current_row;
c=current_col;
%check left
while r<=8 && c<=8 && r>=1 && c>=1 %within the boundary    
    c=c-1;
    if row==r && column==c && output~=1
        output=1;
        travel = current_col - column;
        if ~isempty(q_rowss) && ~isempty(columns)
            for j = 1:length(columns)
                if columns(j) < current_col && columns(j) > column && ...
                        q_rowss(j) == current_row
                    % invalid move, as there is a piece obstructing the
                    % queen's path to the opponent piece
                    output = 0;
                    travel = 100;
                end
            end
        end
    %{
else        
        c=c-1;
        %}
    end
end

r=current_row;
c=current_col;
%check right
while r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    
    c=c+1;
    if row==r && column==c && output~=1
        output=1;
        travel = column - current_col;
        if ~isempty(q_rowss) && ~isempty(columns)
            for j = 1:length(columns)
                if columns(j) > current_col && columns(j) < column && ...
                        q_rowss(j) == current_row
                    % invalid move, as there is a piece obstructing the
                    % queen's path to the opponent piece
                    output = 0;
                    travel = 100;
                end
            end
        end
   %{
 else       
        c=c+1;
        %}
    end
end


    
