classdef p4_newClass
   properties
      x
      y
   end
   methods
       function z = average(obj)
           z = (obj.x+obj.y)/2;
      end
   end
end