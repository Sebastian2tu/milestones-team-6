function returns = p2_feature()
disp("Calculator");
x= input("First Number: ");
y= input("Second Number: ");
sym= input("Operator: ", 's');

returns = 0;

if size(x) == 0
    x = 0;
elseif size(y) == 0
    y = 0;
end

switch sym
    case '-'
        returns = x-y;
    case '+'
        returns = x+y;
    case '*'
        returns = x*y;
    case '/'
        returns = x/y;
    case '\%'
        returns = mod(x,y);
    otherwise
        returns = 0;
end