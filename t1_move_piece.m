% t1_move_piece.m is used for task 1
% the gamestate struct must be checked to find the type of piece present
% using a switch case to choose the piece present.
% after determining the piece type, call one of the valid_x functions
% corresponding to the type of piece.
% check the global output value, if it is a 1, send the message to move the
% system, pick up the piece, and move the piece to the desired location
% otherwise, change error to a 1 to indicate an invalid move
%clear;
%clc;

global gamestate;
global output;
global error;
global iterator;
%global row;
%global column;
global current_row;
global current_col;

%row = 2;
%column = 1;

%gamestate(1).ALLIGNMENT = 'Player';
%gamestate(1).PIECETYPE = 'Queen';
iterator = 1;

piece_type = gamestate(1).PIECETYPE;

current_row = gamestate(1).INDEX(2);
current_col = gamestate(1).INDEX(1);


switch piece_type
    
    case 'Pawn'
        valid_pawn();
        if output == 0
            error = 1;
        else
            % execute the move, and reset the system to the origin point
            move_piece();
        end
    case 'Rook'
        valid_rook();
        if output == 0
            error = 1;
        else
            % execute the move, and reset the system to the origin point
            move_piece();
        end
    case 'Bishop'
        valid_bishop();
        if output == 0
            error = 1;
        else
            % execute the move, and reset the system to the origin point
            move_piece();
        end
    case 'Knight'
        valid_knight();
        if output == 0
            error = 1;
        else
            % execute the move, and reset the system to the origin point
            move_piece();
        end
    case 'Queen'
        valid_queen();
        if output == 0
            error = 1;
        else
            % execute the move, and reset the system to the origin point
            move_piece();
        end
    case 'King'
        valid_king();
        if output == 0
            error = 1;
        else
            % execute the move, and reset the system to the origin point
            move_piece();
        end
end
        
        