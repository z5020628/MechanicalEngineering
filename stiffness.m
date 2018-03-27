function [temp] = stiffness(info, dim)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
    
    area = info(1);
    E = info(2);
    L = info(3);
    l = info(4);
    m = info(5);
    
    b = info(6)*2;
    a = b-1;
    d = info(7)*2;
    c = (d-1);
    
    temp1 = [l^2 l*m  ; l*m m^2 ];
    temp2 = [-(l^2) -(l*m); -(l*m) -(m^2)];
    temp3 = [-l^2 -(l*m);-(l*m) -(m^2) ];
    temp4 = [ l^2 l*m; l*m m^2];
    
    temp = zeros(dim);
       
    temp([a,b],[a,b]) = temp1;
    temp([a,b],[c,d]) = temp2;
    temp([c,d],[a,b]) = temp3;
    temp([c,d],[c,d]) = temp4;
    
    temp = ((area*E)/L).*temp ;

end
