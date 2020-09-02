
%---------------------------------------------------
% Model parameters
%---------------------------------------------------
a=2;
b=4;
v0=12;

%---------------------------------------------------
% Model matrices
%---------------------------------------------------

A=[0 v0;0 0];
B=[a*v0/b v0/b]';
C=eye(2);
D=[0 0]';


%---------------------------------------------------
% Control design
%---------------------------------------------------

zeta=1;
wn=1;

K=[b*wn^2/v0^2 (2*zeta*wn*b/v0-a*b*wn^2/v0^2)];
kr=b*wn^2/v0^2;

%---------------------------------------------------
% Observer design
%---------------------------------------------------

% As the observer dynamics are required to be stablized earlier than the
% controller dynamics, choosing a desired polynomial with poles {p1,p2} =
% {-6,-4}

% with pole placement using the desired polynomial poles, the following
% observer gains are determined

% with this state estimator gains, error is stabilzed to 3x10^{-3}
l1 = 10;
l2 = 2;
L = [l1 l2];