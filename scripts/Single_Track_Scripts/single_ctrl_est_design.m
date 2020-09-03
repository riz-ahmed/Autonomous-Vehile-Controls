%---------------------------------------------------
% Linear single track vehicle model
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
% Enter A and B matrices here
%---------------------------------------------------
% A=
% B=
C=[1 0 0 0 0];
D=0;


%---------------------------------------------------
% Enter control design parameters here
%---------------------------------------------------
%
%K=
%kr=


%---------------------------------------------------
% Enter estimator design parameters here
%---------------------------------------------------
%
%L=


%---------------------------------------------------
% For simulation purposes (not to be modified)
%---------------------------------------------------
B1=[B L];                   % Put the B and H matrix together as one matrix B1 (for Simulink implementation purposes) 
C1=eye(5);                  % Output all state variables from the model
D1=zeros(5,2);
