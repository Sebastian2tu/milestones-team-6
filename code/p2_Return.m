function String = Return()
    String = "";
    arrayToSearch = [1 2 3 4 5 6 7];   
    if size(arrayToSearch) > 5
        String = "Greater Than 5";
    else
        String = "Not Greater Than 5";
    end
end