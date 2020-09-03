function val = fcn_desPoly(z, w)

% init syms
syms s
syms zeta wn p3 real

% construct second order polynomial
eq1 = s^2 + 2*zeta*wn*s + wn^2;

% construct third pole
eq2 = (s + 3*zeta*wn);

% construct the complete polynomial
eq3 = eq2 * eq1;

% substitue the numeric values
eq4 = subs(eq3, [zeta, wn], [z w]);

% solve for s
eq5 = vpa(solve(eq4, s));

val = double(eq5);

end