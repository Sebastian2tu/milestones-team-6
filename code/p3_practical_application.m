%sorter of four user input numbers

szInput = int16.empty();
for n = 1:4
    szInput = horzcat(szInput, input("Enter random number: "));
end

szInput = sort(szInput);
n = 5;
while n > 1
    n= n-1;
    disp(szInput(n));
end