% valid_pawn2.m will be called by t2_elim_piece
% separate valid pawn function for t2, as a pawn can move diagonally foward
% when capturing a piece
% for a pawn present on the board, check all valid moves
% output is 0 - invalid, or 1 - valid, communicates with GUI
global gamestate;
global output;
global iterator;    % keeps track of the position of the pawn in gamestate

% the global row and column variables are used for the requested location
global row;
global column;
global travel; % travel distance is always 1 square for a valid pawn move

% pawn index is found in the ip_gamestate.m function

pawn.INDEX = gamestate(iterator).INDEX;
pawn.ALLIGNMENT = gamestate(iterator).ALLIGNMENT;

p_allignment = pawn.ALLIGNMENT;

% pawn can move directly forward one square or diagonally forward when
% capturing a piece
% so check the pawn's location and compare to the requested location
% the move is only valid if the row value of the requested location
%  is exactly one square (in pixel values) lower or higher based on side of
%  board, side of the board determined by the pawn's location found through
%  image processing, or one square forward diagonally

% pawn.INDEX(2) should be the row value of the centroid location
% pawn.INDEX should be given as an index value from ip_gamestate.m

if row > 8 || row < 1 || column > 8 || column < 1
    % invalid location
    output = 0;
    
else
    
    if strcmp(p_allignment, 'Player') == 1
        valid_row = pawn.INDEX(2) - 1;
        vc1 = pawn.INDEX(1) + 1;
        vc2 = pawn.INDEX(1) - 1;
    else
        valid_row = pawn.INDEX(2) + 1;
        vc1 = pawn.INDEX(1) + 1;
        vc2 = pawn.INDEX(1) - 1;
    end

    if row ~= valid_row
        % invalid movement
        output = 0;
    elseif row == valid_row && column == vc1 || column == vc2
        % valid movement
        output = 1;
        travel = 1;
    end


end