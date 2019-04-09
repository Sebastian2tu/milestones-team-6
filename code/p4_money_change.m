classdef p4_money_change
    methods (Static)
        function main()
            szValues = [];
            szText = [];
            dInput = input("How much money do you want? ");
            if (0 > dInput)
                disp("goodbye!");
            end
            
            if (0 ~= floor(dInput/20))
                szValues = [szValues, floor(dInput/20)];
                if (1 < floor(dInput/20))
                    szText = [szText, "20 bills"];
                else
                    szText = [szText, "20 bill"];
                end
                dInput= mod(dInput,20);
            end
        
            if (0 ~= floor(dInput/10))
                szValues = [szValues, floor(dInput/10)];
                if (1 < floor(dInput/10))
                    szText = [szText, "10 bills"];
                else
                    szText = [szText, "10 bill"];
                end
                dInput= mod(dInput,10);
            end
		
            if (0 ~= floor(dInput/5))
                szValues = [szValues, floor(dInput/5)];
                if (1 < floor(dInput/5))
                    szText = [szText, "5 bills"];
                else
                    szText = [szText, "5 bill"];
                end
                dInput= mod(dInput,5);
            end
            
            if (0 ~= floor(dInput/1))
                szValues = [szValues, floor(dInput/1)];
                if (1 < floor(dInput/1))
                    szText = [szText, "1 bills"];
                else
                    szText = [szText, "1 bill"];
                end
                dInput= mod(dInput,1);
            end
            
            dInput = (100*dInput);
        
            if (0 ~= floor(dInput/25))
                szValues = [szValues, floor(dInput/25)];
                if (1 < floor(dInput/25))
                    szText = [szText, "quarters"];
                else
                    szText = [szText, "quarter"];
                end
                dInput= mod(dInput,25);
            end
			
            if (0 ~= floor(dInput/10))
                szValues = [szValues, floor(dInput/10)];
                if (1 < floor(dInput/10))
                    szText = [szText, "dimes"];
                else
                    szText = [szText, "dime"];
                end
                dInput= mod(dInput,10);
            end

            if (0 ~= floor(dInput/5))
                szValues = [szValues, floor(dInput/5)];
                if (1 < floor(dInput/5))
                    szText = [szText, "nickles"];
                else
                    szText = [szText, "nickle"];
                end
                dInput= mod(dInput,5);
            end
            if (0 ~= floor(dInput/1))
                szValues = [szValues, floor(dInput/1)];
                if (1 < floor(dInput/1))
                    szText = [szText, "pennies"];
                else
                    szText = [szText, "penny"];
                end
            end
            showResults(szText,szValues)
        end
    end
end

function showResults(szText, szValues)
    disp("I will give you: ");
    for nCounter = 1 : (length(szText))
        disp(szValues(nCounter) + " " + szText(nCounter));                    
    end
end