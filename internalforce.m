function [ force ] = internalforce( info ,U )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    area = info(1);
    E = info(2);
    L = info(3);
    l = info(4);
    m = info(5);

    vi = info(6)*2;
    ui = vi-1;
    vj = info(7)*2;
    uj = vj-1;
    
    force = ((area*E)/L).*[l, m]*[(U(uj)-U(ui)); (U(vj)-U(vi))];

end
