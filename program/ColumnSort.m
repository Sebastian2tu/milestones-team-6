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
    sortMatrix(matrix);
    disp(matrix)
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
    
function sortMatrix(matrix)
    % Sorts each column of the matrix via mergesort in-place.
	% Parameters: a 2-D matrix
	% Modifies the array in place
    rows = length(matrix);
    cols = length(matrix(1,:));
    for c=1:cols
        toSort = matrix(:,c);
        disp(toSort)
        sortColumn(toSort,1,length(toSort));
        disp(toSort)
        matrix(:,c) = toSort;
    end
end

function sortColumn(sequence, left,right)
    %sorts using mergeSort
    % Sort function that takes in an array of integers and a left and right index
    % to represent the subarray to be sorted. This function will first split the subarray
    % in roughly equal halves, sort those, then merge the subarrays together.
    if (left < right)
        middle = floor((left + right )/ 2);
        sortColumn (sequence, left, middle);
        sortColumn(sequence, middle + 1, right);
        merge(sequence, left,middle+1, right);
    end
end

function merge(sequence, lIndex, mIndex, rIndex)
    % Helper function for mergesort. Merges two "partitions" of the array
    % that are given by the parameters left, middle, and right. 
    % The first partition is from lIndex to middle. and the other partition is from middle to rIndex.
    size1 = mIndex - lIndex + 1;
    size2 = rIndex - mIndex;
    
    left = sequence(lIndex:mIndex);
    right = sequence(mIndex+1: rIndex);
    
    i=1;
    j=1;
    k = lIndex;
    while (i < size1 && j < size2)
        if (left(i) <= right(j))
            sequence(k) = left(i);
            i= i +1
        else 
            sequence(k) = right(j);
            j= j + 1;
        end
        k=k+1;
    end
    while (i < size1)
        sequence(k) = left(i)
        i=i +1;
        k= k +1;
    end
    while (j < size2)
        sequence(k) = right(j)
        j = j+1;
        k = k+1;
    end
end
    
% 
% 
% function [mat] = sortColumns(matrix)
% end
