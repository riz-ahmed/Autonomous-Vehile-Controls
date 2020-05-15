%---------------------------------------------------
% Final exam 5 - Lane change control
% Vehicle parameters
%---------------------------------------------------

m=1700;             % Vehicle mass [kg]
J=2000;             % Vehicle inertia [kgm^2]
c1=80000;          % Front wheel cornering stiffness [kgm/s^2]
c2=100000;           % Rear wheel cornering stiffness [kgm/s^2
a=1.3;              % Vehicle length, front wheel to center of gravity [m]
b=1.5;              % Vehicle length, rear wheel to center of gravity [m]
tau=0.1;            % Actuator time constant [s]
k1=0.01;            % Actuator gain 1 [rad/V]
k2=0.0056;          % Actuator gain 2 [rad/V^3]    


%---------------------------------------------------
% vehicle forward velocity
%---------------------------------------------------
vx=20;               % Vehicle velocity [m/s]


%---------------------------------------------------
% Enter your A and B matrices here
%---------------------------------------------------
A= [0 1 vx 0 0; 
    0 -(c1+c2)/(m*vx) 0 ((-a*c1+b*c2)/(m*vx))-vx c1/m;
    0 0 0 1 0;
    0 -(a*c1-b*c2)/(J*vx) 0 -(a^2*c1+b^2*c2)/(J*vx) (a*c1)/J;
    0 0 0 0 -1/tau];
B= [0;0;0;0;k1/tau];
C=[1 0 0 0 0];
D=0;


%---------------------------------------------------
% Enter your control design here
%---------------------------------------------------
%
% K=
% kr=


%---------------------------------------------------
% Enter your estimator design here
%---------------------------------------------------
%
%L=


%---------------------------------------------------
% For simulation purposes (do not modify)
%---------------------------------------------------
B1=[B];                   % Put the B and H matrix together as one matrix B1 (for Simulink implementation purposes) 
C1=eye(5);                  % Output all state variables from the model
D1=zeros(5,2);
