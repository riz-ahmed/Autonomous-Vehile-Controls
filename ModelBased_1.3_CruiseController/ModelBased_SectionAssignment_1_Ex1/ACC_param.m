%----------------------------------------------
% Vehicle data
%----------------------------------------------

m=1000;         % Vehicle mass [kg]
g=9.82;         % Gravitational constant [m/s^2]
b=10000;        % Throttle gain" [N/rad]
a=200;          % "Resistance" [Ns/m]"

%----------------------------------------------
% PID controller
%----------------------------------------------

p= 0.34;             % Enter the pole value here

kp= -(3*p^2*m)/b;             % Enter an expression here
ki= -(p^3*m)/b;            % Enter an expression here
kd= (a - 3*p*m)/b;            % Enter an expression here
