syms s p1 p2 po
p_des = ((s+p1)^2*(s+p2)^3);
p_des = expand(subs(p_des,[p1,p2], [3,9]));      % enter desired pole values

p_des_o = (s+po)^5;
p_des_o = expand(subs(p_des_o, po, 20))