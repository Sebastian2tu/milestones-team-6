function [sorted] = ColumnSort(filename)
    % This program implements columnsort to sort a list
    % of numbers. To use this function, call 
    % ColumnSort(<filename>) in the command line (within MATLAB).
    % Currently only returns the dimensions of the matrix
    % that will be used for implementing columnsort
    fileID = fopen(filename,'r');
    formatSpec = '%f';
    numbers = fscanf(fileID,formatSpec);
    
    %step 0 establish dimensions of matrix
    [closest_pair] = readDimensions(length(numbers));
    disp(closest_pair)
    
    %step1 sort Matrix
    
end

function [closest_pair] = readDimensions(mat_length)
    [pairs] = findAllFactors(mat_length);
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
% 
% 
% function [mat] = sortColumns(matrix)
% end
