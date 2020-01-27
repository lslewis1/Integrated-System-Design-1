% avoid_check.m
% given a user king location
% find a move that will avoid the king being in a checked position
% look at all valid moves for opponent pieces, seeing if any could
% potentially take the king on their next move
% if so, the king is in check
% either move the king or move another user piece to block the check
% start by finding a move that will remove the first check found on the
% king, then determine if the king is still in a check, if so, the previous
% move is not valid
% check another move strategy and repeat this cycle until either a move is found
% that avoids the king being in a checked posistion alltogether or no such
% move exists and therefore the game is in a checkmate

global gamestate;
global iterator;
global row;
global column;
global current_row;
global current_col;
global output;
global incheck;
global p_count;

% status 0 occurs if there is no player king on the board
global status_0;
status_0 = 0;
% status 1 occurs when king is not in check to begin with
global status_1;  
 % status 2 occurs when a movement is made that takes the king out of check
global status_2; 
% status 3 occurs if no move will take the king out of check (checkmate)
global status_3; 

k_row = 0;
k_col = 0;

% ****** test variables, comment these out *****
gamestate(1).PIECETYPE = 'King';
gamestate(1).ALLIGNMENT = 'Player';
gamestate(1).INDEX(2) = 4;
gamestate(1).INDEX(1) = 2;

gamestate(2).PIECETYPE = 'Rook';
gamestate(2).ALLIGNMENT = 'Opponent';
gamestate(2).INDEX(2) = 4;
gamestate(2).INDEX(1) = 4;

p_count = 2;

% **********************************************


for i = 1:p_count
    if strcmp(gamestate(i).PIECETYPE, 'King') == 1 && ...
            strcmp(gamestate(i).ALLIGNMENT, 'Player') == 1
        k_row = gamestate(i).INDEX(2);
        k_col = gamestate(i).INDEX(1);
        king_num = i;
        break;
    end
end

if (k_row ~= 0) && (k_col ~= 0)
    row = k_row;
    column = k_col;
else
    status_0 = 1;
end

incheck = 0;   
% incheck is the variable that says the king is in a checked position

if status_0 == 0
    is_in_check();
end

if incheck == 0 && status_0 == 0
    status_1 = 1;
else
    % check all valid king move locations
    % store in array
    iterator = king_num;
    count = 1;
    
    current_row = k_row;
    current_col = k_col;
    
    for m_row = 1:8
        for m_col = 1:8
            row = m_row;
            column = m_col;
            
            valid_king();
            
            if output == 1
                k_rowss(count) = row;
                k_cols(count) = column;
                count = count + 1;
            end
        end
    end
end

% if k_rows isn't empty, act as if the king was moved to each valid move
% location and see if the king would still be in a check

if ~isempty(k_rowss) 
    current_row = k_row;
    current_col = k_col;
    k = 1;
    while k <= length(k_rowss)
        row = k_rowss(k);
        column = k_cols(k); 
        is_in_check();
        
        if incheck == 0
            move_piece();
            status_2 = 1;
            %k = length(k_rowss); % ***** this may not work ****
            % if not use
            break;
        end
        k = k + 1;
    end
end

% if moving the king will not take it out of check
% see if moving another player piece will take the king out of check

if status_2 ~= 1
    for i = 1:p_count
        if strcmp(gamestate(i).ALLIGNMENT,'Player') == 1
            switch gamestate(i).PIECETYPE

                case 'Pawn'
                    count = 1;
                    
                    p_row = gamestate(i).INDEX(2);
                    p_col = gamestate(i).INDEX(1);
                    
                    for r = 1:8
                        for c = 1:8
                            
                            row = r;
                            column = c;
                            iterator = i;
                            
                            valid_pawn();
                            
                            if output == 1
                                p_rowss(count) = row;
                                p_cols(count) = column;
                                count = count + 1;
                            end
                        end
                    end
                    
                    if ~isempty(p_rowss)
                        k = 1;
                        while k <= length(p_rowss)
                            
                            gamestate(iterator).INDEX(2) = p_rowss(k);
                            gamestate(iterator).INDEX(1) = p_cols(k);
                            row = k_row;
                            column = k_col;
                            
                            is_in_check();
                            
                            if incheck == 0
                                
                                gamestate(iterator).INDEX(2) = p_row;
                                gamestate(iterator).INDEX(1) = p_col;
                                
                                current_row = p_row;
                                current_col = p_col;
                                row = p_rowss(k);
                                column = p_cols(k);
                                
                                move_piece();
                                
                                break;
                            end
                            k = k + 1;
                        end
                    end
                    
                case 'Bishop'
                    
                    count = 1;
                    b_row = gamestate(i).INDEX(2);
                    b_col = gamestate(i).INDEX(1);
                    
                    for r = 1:8
                        for c = 1:8
                            
                            row = r;
                            column = c;
                            iterator = i;
                            
                            valid_bishop();
                            if output == 1
                                
                                b_rowss(count) = row;
                                b_cols(count) = column;
                                count = count + 1;
                            end
                        end
                    end
                    
                    if ~isempty(b_rowss)
                        k = 1;
                        while k <= length(b_rowss)
                            
                            gamestate(iterator).INDEX(2) = b_rowss(k);
                            gamestate(iterator).INDEX(1) = b_cols(k);
                            row = b_row;
                            column = b_col;
                            
                            is_in_check();
                            
                            if incheck == 0
                                
                                gamestate(iterator).INDEX(2) = b_row;
                                gamestate(iterator).INDEX(1) = b_col;
                                
                                current_row = b_row;
                                current_col = b_col;
                                
                                row = b_rowss(k);
                                column = b_cols(k);
                                
                                move_piece();
                                
                                break;
                            end
                            k = k + 1;
                        end
                    end
                    
                case 'Rook'
                    
                    count = 1;
                    r_row = gamestate(i).INDEX(2);
                    r_col = gamestate(i).INDEX(1);
                    
                    for r = 1:8
                        for c = 1:8
                            
                            row = r;
                            column = c;
                            iterator = i;
                            
                            valid_rook();
                            if output == 1
                                
                                r_rowss(count) = row;
                                r_cols(count) = column;
                                count = count + 1;
                            end
                        end
                    end
                    
                    if ~isempty(r_rowss)
                        k = 1;
                        while k <= length(r_rowss)
                            
                            gamestate(iterator).INDEX(2) = r_rowss(k);
                            gamestate(iterator).INDEX(1) = r_cols(k);
                            
                            row = r_row;
                            column = r_col;
                            
                            is_in_check();
                            
                            if incheck == 0
                                
                                gamestate(iterator).INDEX(2) = r_row;
                                gamestate(iterator).INDEX(1) = r_col;
                                
                                current_row = r_row;
                                current_col = r_col;
                                
                                row = r_rowss(k);
                                column = r_cols(k);
                                
                                move_piece();
                                
                                break;
                            end
                            k = k + 1;
                        end
                    end

                case 'Knight'
                    
                    count = 1;
                    kn_row = gamestate(i).INDEX(2);
                    kn_col = gamestate(i).INDEX(1);
                    
                    for r = 1:8
                        for c = 1:8
                            
                            row = r;
                            column = c;
                            iterator = i;
                            
                            valid_knight();
                            if output == 1
                                
                                kn_rowss(count) = row;
                                kn_cols(count) = column;
                                count = count + 1;
                            end
                        end
                    end
                    
                    if ~isempty(kn_rowss)
                        k = 1;
                        while k <= length(kn_rowss)
                            
                            gamestate(iterator).INDEX(2) = kn_rowss(k);
                            gamestate(iterator).INDEX(1) = kn_cols(k);
                            
                            row = kn_row;
                            column = kn_col;
                            
                            is_in_check();
                            
                            if incheck == 0
                                
                                gamestate(iterator).INDEX(2) = kn_row;
                                gamestate(iterator).INDEX(1) = kn_col;
                                
                                current_row = kn_row;
                                current_col = kn_col;
                                
                                row = kn_rowss(k);
                                column = kn_cols(k);
                                
                                move_piece();
                                
                                break;
                            end
                            k = k + 1;
                        end
                    end

                case 'Queen'
                    
                    count = 1;
                    q_row = gamestate(i).INDEX(2);
                    q_col = gamestate(i).INDEX(1);
                    
                    for r = 1:8
                        for c = 1:8
                            
                            row = r;
                            column = c;
                            iterator = i;
                            
                            valid_queen();
                            if output == 1
                                
                                q_rowss(count) = row;
                                q_cols(count) = column;
                                count = count + 1;
                            end
                        end
                    end
                    
                    if ~isempty(q_rowss)
                        k = 1;
                        while k <= length(q_rowss)
                            
                            gamestate(iterator).INDEX(2) = q_rowss(k);
                            gamestate(iterator).INDEX(1) = q_cols(k);
                            
                            row = q_row;
                            column = q_col;
                            
                            is_in_check();
                            
                            if incheck == 0
                                
                                gamestate(iterator).INDEX(2) = q_row;
                                gamestate(iterator).INDEX(1) = q_col;
                                
                                current_row = q_row;
                                current_col = q_col;
                                
                                row = q_rowss(k);
                                column = q_cols(k);
                                
                                move_piece();
                                
                                break;
                            end
                            k = k + 1;
                        end
                    end

            end
        end

        if incheck == 0
            status_2 = 1;
            break;
        end
        
    end
end

if incheck == 1
    status_3 = 1;
end





    
    

