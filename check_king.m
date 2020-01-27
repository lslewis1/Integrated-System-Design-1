% check_king.m is used for task 3
% the global check piece is taken from the GUI
% switch case to ensure that the piece is present on the board
% check valid moves for the chosen piece, if the piece has a valid move to a
% row/column that is a checked position for the opponent king, move it to
% the checked position

global gamestate;
global p_count;
global check_piece;
global t3_error;        % error if player piece is not present
t3_error = 0;
global t3_error2;       % error if opponent king not present
t3_error2 = 0;
global t3_error3;       % king cant be put in check with chosen piece
t3_error3 = 0;

% have an array of valid movements for the chosen piece, and check to see
% if the next move would end up in the king's location
% loop through all row and column combinations, and if a valid combination
% is found, store this valid move in an array
% check each valid movement location as if the piece were sitting at them,
% then check the valid moves again with the new starting point, if the
% valid moves at this point contain the location of the opponent king, move
% the piece from its original location to the check position

% k_row and k_col is the index for the opponent king
%k_row;
%k_col;

global row;
global column;

global current_row;
global current_col;

global iterator;
global output;


% ****** test variables, comment these out *****
check_piece = 'Rook';
gamestate(1).PIECETYPE = 'Rook';
gamestate(1).ALLIGNMENT = 'Player';
gamestate(1).INDEX(2) = 4;
gamestate(1).INDEX(1) = 2;

gamestate(2).PIECETYPE = 'King';
gamestate(2).ALLIGNMENT = 'Opponent';
gamestate(2).INDEX(2) = 3;
gamestate(2).INDEX(1) = 4;

p_count = 2;

% **********************************************

temp_count = 0;

for i = 1:p_count
    
    if (strcmp(gamestate(i).PIECETYPE, check_piece) == 1) && ...
            (strcmp(gamestate(i).ALLIGNMENT, 'Player') == 1)
            % ensure the chosen piece is present and a user piece
            t3_error = 0;
            iterator = i;
            cp.INDEX = gamestate(i).INDEX; % holds the initial index
            temp_count = temp_count + 1;
            break;
    end
end

if temp_count == 0
    t3_error = 1;
end

temp_count = 0;
for j = 1:p_count
    
    if (strcmp(gamestate(j).PIECETYPE, 'King') == 1) && ...
            (strcmp(gamestate(j).ALLIGNMENT, 'Opponent') == 1)
            % ensure there is an opponent king
            t3_error2 = 0;
            k_row = gamestate(j).INDEX(2);
            k_col = gamestate(j).INDEX(1);
            temp_count = temp_count + 1;
            break;
    end
end

if temp_count == 0
    t3_error2 = 1;
end

if (t3_error == 0) && (t3_error2 == 0)
    
    switch check_piece

        case 'Pawn'
            
            count = 1;
            for r = 1:8
                for c = 1:8
                    row = r;
                    column = c;
                    
                    valid_pawn();
                   
                    if output == 1
                       
                        p_rowss(count) = row;
                        p_columns(count) = column;
                        count = count + 1;
                    end
                end
            end
            
            if (~isempty(p_rowss))
            
                row = k_row;
                column = k_col;

                for j = 1:length(p_rowss)
                    gamestate(iterator).INDEX(2) = p_rowss(j);
                    gamestate(iterator).INDEX(1) = p_columns(j);
                    
                    valid_pawn();

                    if output == 1
                        gamestate(iterator).INDEX = cp.INDEX; % reset index
                        
                        current_row = gamestate(iterator).INDEX(2);
                        current_col = gamestate(iterator).INDEX(1);
                        
                        row = p_rowss(j);
                        column = p_columns(j);
                        
                        move_piece();
                        
                        break;
                    end
                end
  
                if output == 0
                    t3_error3 = 1;
                end
                
            else
                t3_error3 = 1;
            end
           
       
        case 'Rook'
            
            count = 1;
            for r = 1:8
                for c = 1:8
                    row = r;
                    column = c;
                    
                    valid_rook();
                   
                    if output == 1
                       
                        r_rowss(count) = row;
                        r_columns(count) = column;
                        count = count + 1;
                    end
                end
            end
            
            if (~isempty(r_rowss))
            
                row = k_row;
                column = k_col;

                for j = 1:length(r_rowss)
                    gamestate(iterator).INDEX(2) = r_rowss(j);
                    gamestate(iterator).INDEX(1) = r_columns(j);
                    
                    valid_rook();

                    if output == 1
                        gamestate(iterator).INDEX = cp.INDEX; % reset index
                        
                        current_row = gamestate(iterator).INDEX(2);
                        current_col = gamestate(iterator).INDEX(1);
                        
                        row = r_rowss(j);
                        column = r_columns(j);
                        
                        move_piece();
                        
                        break;
                    end
                end
  
                if output == 0
                    t3_error3 = 1;
                end
                
            else
                t3_error3 = 1;
            end
                
        case 'Bishop'
            
            count = 1;
            for r = 1:8
                for c = 1:8
                    row = r;
                    column = c;
                    
                    valid_bishop();
                   
                    if output == 1
                       
                        b_rowss(count) = row;
                        b_columns(count) = column;
                        count = count + 1;
                    end
                end
            end
            
            if (~isempty(b_rowss))
            
                row = k_row;
                column = k_col;

                for j = 1:length(b_rowss)
                    gamestate(iterator).INDEX(2) = b_rowss(j);
                    gamestate(iterator).INDEX(1) = b_columns(j);
                    
                    valid_bishop();

                    if output == 1
                        gamestate(iterator).INDEX = cp.INDEX; % reset index
                        
                        current_row = gamestate(iterator).INDEX(2);
                        current_col = gamestate(iterator).INDEX(1);
                        
                        row = b_rowss(j);
                        column = b_columns(j);
                        
                        move_piece();
                        
                        break;
                    end
                end
  
                if output == 0
                    t3_error3 = 1;
                end
                
            else
                t3_error3 = 1;
            end
           
        case 'Knight'
            
            count = 1;
            for r = 1:8
                for c = 1:8
                    row = r;
                    column = c;
                    
                    valid_knight();
                   
                    if output == 1
                       
                        kn_rowss(count) = row;
                        kn_columns(count) = column;
                        count = count + 1;
                    end
                end
            end
            
            if (~isempty(kn_rowss))
            
                row = k_row;
                column = k_col;

                for j = 1:length(kn_rowss)
                    gamestate(iterator).INDEX(2) = kn_rowss(j);
                    gamestate(iterator).INDEX(1) = kn_columns(j);
                    
                    valid_knight();

                    if output == 1
                        gamestate(iterator).INDEX = cp.INDEX; % reset index
                        
                        current_row = gamestate(iterator).INDEX(2);
                        current_col = gamestate(iterator).INDEX(1);
                        
                        row = kn_rowss(j);
                        column = kn_columns(j);
                        
                        move_piece();
                        
                        break;
                    end
                end
  
                if output == 0
                    t3_error3 = 1;
                end
                
            else
                t3_error3 = 1;
            end
            
        case 'Queen'
            
            count = 1;
            for r = 1:8
                for c = 1:8
                    row = r;
                    column = c;
                    
                    valid_queen();
                   
                    if output == 1
                       
                        q_rowss(count) = row;
                        q_columns(count) = column;
                        count = count + 1;
                    end
                end
            end
            
            if (~isempty(q_rowss))
            
                row = k_row;
                column = k_col;

                for j = 1:length(q_rowss)
                    gamestate(iterator).INDEX(2) = q_rowss(j);
                    gamestate(iterator).INDEX(1) = q_columns(j);
                    
                    valid_queen();

                    if output == 1
                        gamestate(iterator).INDEX = cp.INDEX; % reset index
                        
                        current_row = gamestate(iterator).INDEX(2);
                        current_col = gamestate(iterator).INDEX(1);
                        
                        row = q_rowss(j);
                        column = q_columns(j);
                        
                        move_piece();
                        
                        break;
                    end
                end
  
                if output == 0
                    t3_error3 = 1;
                end
                
            else
                t3_error3 = 1;
            end
            
        case 'King'
            
            count = 1;
            for r = 1:8
                for c = 1:8
                    row = r;
                    column = c;
                    
                    valid_king();
                   
                    if output == 1
                       
                        k_rowss(count) = row;
                        k_columns(count) = column;
                        count = count + 1;
                    end
                end
            end
            
            if (~isempty(k_rowss))
            
                row = k_row;
                column = k_col;

                for j = 1:length(k_rowss)
                    gamestate(iterator).INDEX(2) = k_rowss(j);
                    gamestate(iterator).INDEX(1) = k_columns(j);
                    
                    valid_king();

                    if output == 1
                        gamestate(iterator).INDEX = cp.INDEX; % reset index
                        
                        current_row = gamestate(iterator).INDEX(2);
                        current_col = gamestate(iterator).INDEX(1);
                        
                        row = k_rowss(j);
                        column = k_columns(j);
                        
                        move_piece();
                        
                        break;
                    end
                end
  
                if output == 0
                    t3_error3 = 1;
                end
                
            else
                t3_error3 = 1;
            end
            
            
    end
            
    
end   
            
        
        
       