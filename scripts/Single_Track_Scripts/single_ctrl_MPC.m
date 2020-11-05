load Params_Lane.mat t posRef yawRef
%---------------------------------------------------
% Linear single track vehicle model
% Vehicle parameters
%---------------------------------------------------

m=2300;             % Vehicle mass [kg]
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
vx=15;               % Vehicle velocity [m/s]


%---------------------------------------------------
% vehcile state space model (lienarised)
%---------------------------------------------------
A = [0,                     1, vx,                           0;
    0,     -(c1 + c2)/(m*vx),  0, - vx - (a*c1 - b*c2)/(m*vx);
    0,                     0,  0,                           1;
    0, -(a*c1 - b*c2)/(J*vx),  0,   -(c1*a^2 + c2*b^2)/(J*vx)];
B = [0 c1/m 0 (a*c1)/J]';
C = eye(4);
D = zeros(4,1);

%---------------------------------------------------
% controllability analysis
%---------------------------------------------------
Mc = ctrb(A,B);                         % controllability matrix
det_cont_model = det(Mc);       % the system is controllable

%---------------------------------------------------
% control design parameters
%---------------------------------------------------

% K = 
% kr = 

%---------------------------------------------------
% estimator design parameters
%---------------------------------------------------
%

% L = 

%---------------------------------------------------
% For simulation purposes (not to be modified)
%---------------------------------------------------
% B1=[B L'];                   % Put the B and H matrix together as one matrix B1 (for Simulink implementation purposes) 
% C1=eye(5);                  % Output all state variables from the model
% D1=zeros(5,2);
