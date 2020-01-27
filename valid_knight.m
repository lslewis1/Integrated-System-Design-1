

% valid_knight.m will be called by t1_move_piece
% for a queen present on the board, check all valid moves
%global gamestate;

% the global row and column variables are used for the requested location
global row;
global column;
global output; % output 0 means invalid, output 1 is valid
global iterator;    % keeps track of the position of the knight in gamestate
global travel;  % travel is always 3 for a valid knight move
global current_row;
global current_col;

knight.INDEX = gamestate(iterator).INDEX;

%update current locations
current_row= knight.INDEX(2);
current_col= knight.INDEX(1);

%default output
output=0;
   
r=current_row;
c=current_col;
%down down right
r=r+2;
c=c+1;
if r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    if row==r && column==c && output~=1
        output=1;
        travel = 3;
    end
end


r=current_row;
c=current_col;
%down down left
r=r+2;
c=c-1;
if r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    if row==r && column==c && output~=1
        output=1;
        travel = 3;
    end
end


r=current_row;
c=current_col;
%up up left
r=r-2;
c=c-1;
if r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    if row==r && column==c && output~=1
        output=1;
        travel = 3;
    end
end

r=current_row;
c=current_col;
%up up right
r=r-2;
c=c+1;
if r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    if row==r && column==c && output~=1
        output=1;
        travel = 3;
    end
end

r=current_row;
c=current_col;
%right right down
r=r+1;
c=c+2;
if r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    if row==r && column==c && output~=1
        output=1;
        travel = 3;
    end
end

r=current_row;
c=current_col;
%right right up
r=r-1;
c=c+2;
if r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    if row==r && column==c && output~=1
        output=1;
        travel = 3;
    end
end

r=current_row;
c=current_col;
%left left up
r=r-1;
c=c-2;
if r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    if row==r && column==c && output~=1
        output=1;
        travel = 3;
    end
end

r=current_row;
c=current_col;
%left left down
r=r+1;
c=c-2;
if r<=8 && c<=8 && r>=1 && c>=1 %within the boundary
    if row==r && column==c && output~=1
        output=1;
        travel = 3;
    end
end



