function [sorted] = ColumnSort(filename)
    % This program implements columnsort to sort a list
    % of numbers. To use this function, call 
    % ColumnSort(<filename>) in the command line (within MATLAB).
    % Currently only returns the dimensions of the matrix
    % that will be used for implementing columnsort
    fileID = fopen(filename,'r');
    formatSpec = '%f';
    numbers = fscanf(fileID,formatSpec);
    
    %step 0 establish dimensions of matrix and create it
    [closest_pair] = readDimensions(length(numbers));
    matrix = toMatrix(numbers,closest_pair(1),closest_pair(2));
    %disp(closest_pair)
    disp("Number of elements to be sorted: " + length(numbers));
    disp("Number of rows in matrix: " + closest_pair(1));
    disp("Number of columns in column: " + closest_pair(2));
    
    %step1 sort Matrix
    matrix = sortMatrix(matrix);
    
    %step2 transpose and reshape
    matrix = matrix.';
    matrix = reshape1(matrix);
    
    %step 3 sort columns
    matrix = sortMatrix(matrix);
    
    % step 4 reshape inverse
    matrix = reshapeInverse(matrix);
    matrix = matrix.';
    
    %tep 5
    matrix = sortMatrix(matrix);
    
    %step 6
    matrix = shiftDownR2(matrix)
    
    
    
end

function [closest_pair] = readDimensions(mat_length)
    [pairs] = findAllFactors(mat_length)
    closest_pair = [0 0];   
    min_close = "not a number";
    for i = 1:length(pairs)
        r = pairs(i,2);
        s = pairs(i,1);
        cur = r - 2 * (s-1 ^ 2);
        if (strcmp(min_close,"not a number") ==1)
           min_close = cur;
        end
        if (cur <= min_close && cur >=0)
            min_close = cur;
            closest_pair = [r s];
        end
    end
end

function [pairs] = findAllFactors(mat_length)
    %This function returns all the possible pairs of
    %factors from mat_length. These pairs are stored
    %in pairs as a nx2 array.
    basecase = [1 mat_length];
    pairs = [basecase];
    for i = 2:sqrt(mat_length)
        if mod(mat_length,i) == 0 && mod(mat_length/i,i) ==0
            pair = [i mat_length/i];
            pairs = [pairs; pair];
        end
    end
end

function matrix = toMatrix(nums, numRows,numCols)
    %converts a list of nums into a 2D array with numRow rows and numCols
    %cols.The function places the items columns-first. I.E.
	% a list of [a,b,c,d,e,f], 2, 3 becomes [[a,b,c][d,e,f]]
    matrix = zeros(numRows,numCols);
    for i = 0:(length(nums) -1)
        val = nums(i+1);
        col = mod(i, numCols) + 1;
        row = floor( i / numCols) +1;
        matrix(row,col) = val;
    end
end
    
function result =  sortMatrix(matrix)
    % Sorts each column of the matrix via mergesort in-place.
	% Parameters: a 2-D matrix
	% Modifies the array in place
    rows = length(matrix);
    cols = length(matrix(1,:));
    for c=1:cols
        toSort = matrix(:,c);
        %disp("A" + toSort)
        matrix(:,c) = quickSort(toSort);
    end
    result = matrix;
end


function sortedArray = quickSort(array)
    %This function implements the quicksort algorithm to sort a vector.
    if numel(array) <= 1 %If the array has 1 element then it can't be sorted       
        sortedArray = array;
        return
    end
 
    pivot = array(end);
    array(end) = [];
 
    sortedArray = [quickSort( array(array <= pivot) ) pivot quickSort( array(array > pivot) )];
 
end

function result = reshape1(matrix)
    %Reshapes the matrix by taking each row from the sxr Matrix
	% and changing it to a r/s xs submatrix.
    rows = length(matrix(1,:));
    cols = length(matrix(:,1));
    result = zeros(rows,cols);
    for i=0:cols-1
        for j=0:rows-1
            result(i* floor(rows/cols) + floor(j/cols)+1,mod(j,cols)+1)= matrix(i+1,j+1);
        end
    end
end

function result = reshapeInverse(matrix)
    rows = length(matrix(:,1));
    cols = length(matrix(1,:));
    result = zeros(cols,rows);
    
    for i=0:rows-1
        for j=0:cols-1
            result(floor(i/(rows/cols))+1,mod(i*cols+j,rows)+1) =  matrix(i+1,j+1);
        end
    end
end


function result = shiftDownR2(matrix)
    disp(matrix)
    intmin('int64');
    result = reshape(matrix,1,[]).'
    result = 
    
end
% 
% function [mat] = sortColumns(matrix)
% end
