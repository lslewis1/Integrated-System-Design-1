%% ECE 4950 - Final Project
% Group 11
% 
% Image Processing & Game-state identification ip_gamestate.m

clear;
clc;
global gamestate;
global p_count;

%%
% useful stuff:
% preview(cam)
% stopPreview(cam)
% d = imdistline

cam = webcam('HP USB Webcam');

%% background subtraction:

% *** need new background image for final project

background = imread('final_background.jpg');
I = snapshot(cam);
hsv = rgb2hsv(I);

gray = rgb2gray(I);
gray2 = rgb2gray(background);
thresh = im2bw(background,0.20);
thresh2 = im2bw(I,0.3768);
foreground= bitxor(thresh2, thresh); 
bw2 = foreground;
figure, imshow(bw2);

%% Labeling Regions:

L = bwlabel(bw2);
s = regionprops(bw2, 'Centroid');
% centroids are located and displayed as numbered labels on each region
imshow(bw2)
hold on
%% Find Areas and pixel values

Areas = regionprops(L, 'Area');
PixId = regionprops(L, 'PixelIdxList');
PixList = regionprops(L, 'PixelList');

len  = length(PixList);
Cell = struct2cell(Areas);
Cell2 = struct2cell(PixList);
% cells are used to take values from the structs


%% Set Pixel Value to zero if region area is too large or small:

for j = 1:len
    if Cell{j} < 135 || Cell{j} > 1200  % use for actual pics
        Cell2{j} = 0;
    end
end


% count of regions with white pixels within specified area
count=0;
for j = 1:len
    if Cell2{j} > 0
       count=count+1;
    end
end

% print the correct region number in each region
% look for centroids only found in the board area (> 120 & < 620)
% *** the board area may need to be changed for final project

count = 0;
for j = 1:len
    if Cell2{j} > 0
       if s(j).Centroid(1) >= 77  && s(j).Centroid(1) <= 525 ...
               && s(j).Centroid(2) <= 459 && s(j).Centroid(2) >= 20
           count=count+1;
           shape_areas(count) = Areas(j).Area;
           c = s(j).Centroid;
           gamestate(count).LOCATION = round(c);
           gamestate(count).AREA = shape_areas(count);
           text(c(1), c(2), sprintf('%d', count), ...
                'HorizontalAlignment', 'center', ...
                'VerticalAlignment', 'middle');
       end
    end
end

%% Check RGB values to assign colors to each centroid location:
% cent is the temporary centroid location for each region

%for k = 1:length(gamestate)
for k = 1: count
    cent = gamestate(k).LOCATION;
    
    rgbColor = impixel(I, cent(1), cent(2));
    
    % yellow
    if rgbColor(1) == 153 && rgbColor(2) == 0 && rgbColor(3) == 255 
       gamestate(k).COLOR='Yellow';
    
    % red
    elseif rgbColor(1) > rgbColor(2) && rgbColor(1) > rgbColor(3) && rgbColor(1) > 100
       gamestate(k).COLOR='Red';
        
    % green
    elseif rgbColor(2) > rgbColor(1) && rgbColor(2) >= (rgbColor(3)-10)
       gamestate(k).COLOR='Green';
     
    % blue
    elseif rgbColor(3) > rgbColor(1) && rgbColor(3) >= rgbColor(2) && rgbColor(3) > 100
       gamestate(k).COLOR='Blue';
      
    % other
    else 
       gamestate(k).COLOR='Unknown';
      
    end
end
%%
if count~=0
    
    % Check areas of each region and assign the shape:
    for x = 1: length(shape_areas)

        % circle
        if shape_areas(x) >= 610 && shape_areas(x) <= 1200 && ...
                strcmp(gamestate(x).COLOR, 'Unknown') == 0
            gamestate(x).SHAPE = 'Circle';

        % square    
        elseif shape_areas(x) >= 251 && shape_areas(x) <= 600 && ...
                strcmp(gamestate(x).COLOR, 'Unknown') == 0
            gamestate(x).SHAPE = 'Square';

        % triangle
        elseif shape_areas(x) >= 100 && shape_areas(x) <= 250 && ...
                strcmp(gamestate(x).COLOR, 'Unknown') == 0
            gamestate(x).SHAPE = 'Triangle';

        % other
        else
            gamestate(x).SHAPE = 'Unknown';
        end
    end


    
    for i=1:length(gamestate)
        if (~isempty(gamestate(i).AREA))
            gamestate(i).DISTANCE = sqrt((gamestate(i).LOCATION(1)^2) + (gamestate(i).LOCATION(2)^2));
            gamestate(i).ANGLE = radtodeg(atan((gamestate(i).LOCATION(2)) / (gamestate(i).LOCATION(1))));
        else
            gamestate(i).COLOR = 'Unknown';
            gamestate(i).SHAPE = 'Unknown';
        end
    end
    

    % ignore errors
    gamestate(1).COUNT = count;
    for j=1:length(gamestate)
        if j > count
            gamestate(j).COLOR = 'Unknown';
            gamestate(j).SHAPE = 'Unknown';
        end
    end

end

%% Yellow Identification (repeats most of the image processing techniques):

hsv = rgb2hsv(I);
savecount=count;
for i = 20:459 % y
    for j = 77:530 % x
        if hsv(i,j,1)<.21 && hsv(i,j,1)>.099 && hsv(i,j,3)>.5 && hsv(i,j,3)<.6  
            I(i,j,1)=153;
            I(i,j,2)=0;
            I(i,j,3)=255;
        end
    end
end

binary=im2bw(I,0.30);
binary2=~binary;

L = bwlabel(binary2);
s = regionprops(binary2, 'Centroid');

%%area processing

Areas = regionprops(L, 'Area');
Cell_area = struct2cell(Areas);


for i=1:length(Cell_area)
    if Cell_area{i} < 135 || Cell_area{i} > 1000  % use for actual pics
        Cell_area{i} = 0;
        s(i).Centroid(1)=0;
        s(i).Centroid(2)=0;     
      
    end
end

count=1;
len=length(s);
Yellow_struct = struct;
for i=1:len
    if  s(i).Centroid(1)~=0 && s(i).Centroid(2)~=0
        rgbColor = impixel(I,round(s(i).Centroid(1)),round(s(i).Centroid(2)));
        
        if s(i).Centroid(1) >= 88  && s(i).Centroid(1) <= 590 ...
            && s(i).Centroid(2) <= 450 && s(i).Centroid(2) >= 15
            if rgbColor(1) == 153 && rgbColor(2) == 0 && rgbColor(3) == 255
                Yellow_struct(count).COLOR='Yellow';
                Yellow_struct(count).ROW=s(i).Centroid(2);
                Yellow_struct(count).COL=s(i).Centroid(1);
                 Yellow_struct(count).AREA=Cell_area{i};
                if Yellow_struct(count).AREA >490 && Yellow_struct(count).AREA <700
                    Yellow_struct(count).SHAPE='Square';
                elseif Yellow_struct(count).AREA >700 && Yellow_struct(count).AREA <1000
                    Yellow_struct(count).SHAPE='Circle';
                elseif Yellow_struct(count).AREA >180 && Yellow_struct(count).AREA <490
                    Yellow_struct(count).SHAPE='Triangle';
                else
                    Yellow_struct(count).SHAPE='Unknown';
                end
                
                Yellow_struct(count).DISTANCE = sqrt((s(i).Centroid(1)^2) + (s(i).Centroid(2)^2));
                Yellow_struct(count).ANGLE = radtodeg(atan((s(i).Centroid(2)) / (s(i).Centroid(1))));
                count=count+1;
            end
        end
        
    end
   
end
imshow(binary2);
for i=1:count-1
    text(Yellow_struct(i).COL, Yellow_struct(i).ROW, sprintf('%d', i), ...
                'HorizontalAlignment', 'center', ...
                'VerticalAlignment', 'middle');

end
i=savecount;

a=1;
for i= savecount+1:length(Yellow_struct)+savecount
    if isfield(Yellow_struct,'COLOR')    
        gamestate(i).COLOR=Yellow_struct(a).COLOR; 
        gamestate(i).SHAPE=Yellow_struct(a).SHAPE; 
        gamestate(i).DISTANCE=Yellow_struct(a).DISTANCE; 
        gamestate(i).ANGLE=Yellow_struct(a).ANGLE; 
        gamestate(i).AREA=Yellow_struct(a).AREA;
        gamestate(i).LOCATION(2)=Yellow_struct(a).ROW;
        gamestate(i).LOCATION(1)=Yellow_struct(a).COL;
    a=a+1;
    end
    
    
end

gamestate(1).COUNT= length(Yellow_struct)+savecount;

%% CODE BELOW HERE WILL ACCEPT USER INPUT FOR THE PIECE TYPES AND RETRIEVE
% INDEX LOCATIONS FOR EACH PIECE, within (1,1) to (8,8)
% index locations will be found based on a threshold of pixel values for
% each square on the board

% the concept for indexing - find the bounding pixel coordinates for index
% (1,1) then continue with every row and column
    
fprintf("The gamestate is as follows:\n\n");

for i = 1:length(gamestate)
    % display each piece's color and shape
    if strcmp(gamestate(i).SHAPE, 'Unknown') == 0
        game_piece = [gamestate(i).COLOR, gamestate(i).SHAPE];
        fprintf("Piece %d: ", i);
        disp(game_piece);
        fprintf("\n");
    end
end

%fprintf("Possible piece types are: King, Queen, Rook, Pawn, Bishop, and Knight.\n");
%fprintf("Possible piece allignment are: Player or Opponent.\n");

p_count = 0;
for j = 1:length(gamestate)

    if (strcmp(gamestate(j).SHAPE, 'Unknown') == 0) && ...
            (strcmp(gamestate(j).COLOR, 'Unknown') == 0)
        p_count = p_count + 1;
        %fprintf("Please enter the piece type and allignment for piece %d: \n", piece_count);
        %piece_type = input('piece type: ','s');
        %gamestate(j).PIECETYPE = piece_type;
        %piece_allignment = input('piece allignment: ','s');
        %fprintf("\n");
        %gamestate(j).ALLIGNMENT = piece_allignment;
        
        gamestate(p_count) = gamestate(j);
        
    end
    
end

if length(gamestate) > p_count
    for k = (p_count+1):length(gamestate)
        %gamestate(k).SHAPE='Unknown';
        %gamestate(k).COLOR='Unknown';
        %gamestate(k).PIECETYPE='Unknown';
        %gamestate(k).ALLIGNMENT='Unknown';
        gamestate(k).LOCATION(1) = 0;
        gamestate(k).LOCATION(2) = 0;
    end
end

for k = 1:p_count
    % find the column index
    %switch gamestate(k).LOCATION(1)
        
    if gamestate(k).LOCATION(1) >= 77 && ...
            gamestate(k).LOCATION(1) <= 131
        % piece is in the first column
        gamestate(k).INDEX(1) = 1;

    elseif gamestate(k).LOCATION(1) >= 132 && ...
            gamestate(k).LOCATION(1) <= 185
        % piece is in the second column
        gamestate(k).INDEX(1) = 2;

    elseif gamestate(k).LOCATION(1) >= 186 && ...
        gamestate(k).LOCATION(1) <= 239
    % piece is in the third column
    gamestate(k).INDEX(1) = 3;

    elseif gamestate(k).LOCATION(1) >= 240 && ...
        gamestate(k).LOCATION(1) <= 293
    % piece is in the fourth column
    gamestate(k).INDEX(1) = 4;

    elseif gamestate(k).LOCATION(1) >= 294 && ...
        gamestate(k).LOCATION(1) <= 347
    % piece is in the fifth column
    gamestate(k).INDEX(1) = 5;

    elseif gamestate(k).LOCATION(1) >= 348 && ...
        gamestate(k).LOCATION(1) <= 401
    % piece is in the sixth column
    gamestate(k).INDEX(1) = 6;

    elseif gamestate(k).LOCATION(1) >= 402 && ...
        gamestate(k).LOCATION(1) <= 455
    % piece is in the seventh column
    gamestate(k).INDEX(1) = 7;

    elseif gamestate(k).LOCATION(1) >= 456 && ...
        gamestate(k).LOCATION(1) <= 519
    % piece is in the eigth column
    gamestate(k).INDEX(1) = 8;
        
    end
    
    % find the row index
   % gamestate(k).LOCATION(2)
        
    if gamestate(k).LOCATION(2) >= 20 && ...
                gamestate(k).LOCATION(2) <= 81
            % piece is in the first row
            gamestate(k).INDEX(2) = 1;
            
    elseif gamestate(k).LOCATION(2) >= 82 && ...
                gamestate(k).LOCATION(2) <= 135
            % piece is in the second row
            gamestate(k).INDEX(2) = 2;
            
    elseif gamestate(k).LOCATION(2) >= 136 && ...
        gamestate(k).LOCATION(2) <= 189
    % piece is in the third row
    gamestate(k).INDEX(2) = 3;

    elseif gamestate(k).LOCATION(2) >= 190 && ...
        gamestate(k).LOCATION(2) <= 243
    % piece is in the fourth row
    gamestate(k).INDEX(2) = 4;

    elseif gamestate(k).LOCATION(2) >= 244 && ...
        gamestate(k).LOCATION(2) <= 297
    % piece is in the fifth row
    gamestate(k).INDEX(2) = 5;

    elseif gamestate(k).LOCATION(2) >= 298 && ...
        gamestate(k).LOCATION(2) <= 351
    % piece is in the sixth row
    gamestate(k).INDEX(2) = 6;

    elseif gamestate(k).LOCATION(2) >= 352 && ...
        gamestate(k).LOCATION(2) <= 405
    % piece is in the seventh row
    gamestate(k).INDEX(2) = 7;

    elseif gamestate(k).LOCATION(2) >= 406 && ...
        gamestate(k).LOCATION(2) <= 459
    % piece is in the eigth row
    gamestate(k).INDEX(2) = 8;
        
    end
end
    

    
    