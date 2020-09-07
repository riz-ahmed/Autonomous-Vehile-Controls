syms x1 x2 x3 x4 x5 a b c1 c2 m vx J u tau k1 k2
f1 = vx*sin(x3) + x2*cos(x3);
f2 = -((c1 + c2)/(m*vx))*x2 + ((-a*c1+b*c2)/(m*vx) - vx)*x4 + (c1/m)*x5;
f3 = x4;
f4 = -((a*c1-b*c2)/(J*vx))*x2 - (a^2*c1+b^2*c2)/(J*vx)*x4 + ((a*c1)/(J))*x5;
f5 = -(1/tau)*x5 + (k1/tau)*u + (k2/tau)*u^3;
A = [diff(f1,x1) diff(f1,x2) diff(f1,x3) diff(f1,x4) diff(f1,x5); diff(f2,x1) diff(f2,x2) diff(f2,x3) diff(f2,x4) diff(f2,x5); diff(f3,x1) diff(f3,x2) diff(f3,x3) diff(f3,x4) diff(f3,x5);diff(f4,x1) diff(f4,x2) diff(f4,x3) diff(f4,x4) diff(f4,x5);diff(f5,x1) diff(f5,x2) diff(f5,x3) diff(f5,x4) diff(f5,x5)];
A_lin = subs(A, [x1 x2 x3 x4 x5 u], [0 0 0 0 0 0]);
 