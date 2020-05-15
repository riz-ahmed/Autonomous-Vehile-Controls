%---------------------------------------------------
% Exercises on 2.4.2 - Suspension system model
% Vehicle parameters
%---------------------------------------------------
        
mc=401;                         % Quarter car mass [kg]
mw=48;                          % Wheel mass [kg]
ds=2200;                        % Suspension damping coefficient [Ns/m]
cs=23000;                       % Suspension spring coefficient [N/m]
cw=250000;                      % Wheel spring coefficient [N/m]

%---------------------------------------------------
% Enter your matrices here
%---------------------------------------------------
A= [0 1 0 0;
    -(cw+cs)/mw -ds/mw cs/mw ds/mw;
    0 0 0 1;
    cs/mc ds/mc -cs/mc -ds/mc];
B= [0; cw/mw; 0; 0];
C= [-1 0 1 0;
    cs/mc ds/mc -cs/mc -ds/mc];
D= zeros(2,1);
%---------------------------------------------------
