% valid_pawn.m will be called by t1_move_piece
% separate valid pawn function for t2, as a pawn can move diagonally foward
% when capturing a piece
% for a pawn present on the board, check all valid moves
% output is 0 - invalid, or 1 - valid, communicates with GUI
%clear;
%clc;

global gamestate;
global output;
global iterator;

% the global row and column variables are used for the requested location
global row;
global column;

% pawn index is found in the ip_gamestate.m function

pawn.INDEX = gamestate(iterator).INDEX;
pawn.ALLIGNMENT = gamestate(iterator).ALLIGNMENT;

p_allignment = pawn.ALLIGNMENT;

% pawn can move directly forward one square
% so check the pawn's location and compare to the requested location
% the move is only valid if the row value of the requested location
%  is exactly one square (in pixel values) lower or higher based on side of
%  board, side of the board determined by the pawn's location found through
%  image processing

% pawn.LOCATION(2) should be the row value of the centroid location
% pawn.LOCATION should be given as an index value from ip_gamestate.m
if row > 8 || row < 1 || column > 8 || column < 1
    % invalid location
    output = 0;
    
else
    
    if strcmp(p_allignment, 'Player') == 1
        valid_row = pawn.INDEX(2) - 1;
    else
        valid_row = pawn.INDEX(2) + 1;
    end

    if column ~= pawn.INDEX(1)
        % invalid movement
        output = 0;

    else

        if row ~= valid_row
            % invalid movement
            output = 0;
        else
            % valid movement
            output = 1;
        end

    end
end
