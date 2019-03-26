n = 10;
while n > 0
    disp(n)
    n = n-2;
    if n == 4
        n = n-2;
    else
        continue;
    n= n-1;
    end
end