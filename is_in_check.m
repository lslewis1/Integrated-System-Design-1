global gamestate;
global output;
global iterator;
global incheck;
global p_count;
global current_row;
global current_col;

incheck = 0;

for iterator = 1:p_count
    if strcmp(gamestate(iterator).ALLIGNMENT, 'Opponent') == 1

        switch gamestate(iterator).PIECETYPE

            case 'Pawn'
                current_row = gamestate(iterator).INDEX(2);
                current_col = gamestate(iterator).INDEX(1);
                valid_pawn2();
                % if output is 1, the pawn can move to the king location
                if output == 1
                    incheck = 1;
                end

            case 'Rook'
                current_row = gamestate(iterator).INDEX(2);
                current_col = gamestate(iterator).INDEX(1);
                valid_rook();
                % if output is 1, the rook can move to the king location
                if output == 1
                    incheck = 1;
                end
            case 'Bishop'
                current_row = gamestate(iterator).INDEX(2);
                current_col = gamestate(iterator).INDEX(1);
                valid_bishop();
                % if output is 1, the bishop can move to the king location
                if output == 1
                    incheck = 1;
                end
            case 'Knight'
                current_row = gamestate(iterator).INDEX(2);
                current_col = gamestate(iterator).INDEX(1);
                valid_knight();
                % if output is 1, the knight can move to the king location
                if output == 1
                    incheck = 1;
                end

            case 'Queen'
                current_row = gamestate(iterator).INDEX(2);
                current_col = gamestate(iterator).INDEX(1);
                valid_queen();
                % if output is 1, the queen can move to the king location
                if output == 1
                    incheck = 1;
                end

            case 'King'
                current_row = gamestate(iterator).INDEX(2);
                current_col = gamestate(iterator).INDEX(1);
                valid_king();
                % if output is 1, the king can move to the king location
                if output == 1
                    incheck = 1;
                end

        end
    end
end