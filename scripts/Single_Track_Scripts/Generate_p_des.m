syms s p1 p2
p_des = ((s+p1)^2*(s+p2)^3);
p_des = expand(subs(p_des,[p1,p2], [3,9]))      % enter desired pole values