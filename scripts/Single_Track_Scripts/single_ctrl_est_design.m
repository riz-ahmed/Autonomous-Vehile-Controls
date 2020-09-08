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
vx=20;               % Vehicle velocity [m/s]


%---------------------------------------------------
% vehcile state space model (lienarzied)
%---------------------------------------------------
A = [0 1 vx 0 0;
     0 -(c1 + c2)/(m*vx) 0 -vx-((a*c1-b*c2)/(m*vx)) c1/m;
     0 0 0 1 0;
     0 -(a*c1-b*c2)/(J*vx) 0 -(c1*a^2+c2*b^2)/(J*vx) (a*c1)/J;
     0 0 0 0 -(1/tau)];
B = [0 0 0 0 (k1/tau)]';
C =[1 0 0 0 0];
D =0;

%---------------------------------------------------
% controllability analysis
%---------------------------------------------------
Mc = ctrb(A,B);                         % controllability matrix
det_cont_model = det(Mc);       % the system is controllable

%---------------------------------------------------
% control design parameters
%---------------------------------------------------
% settling time == 2 sec
% steady-state == 5% within the boundary

% refer to control system notes for more details
% p_des = (s + p1)^2 + (s + p2)^3, with {p1,p2} = {-3,-9}
% p_des = s^5 + 33*s^4 + 414*s^3 + 2430*s^2 + 6561*s + 6561

p_des = A^5 + 33*A^4 + 414*A^3 + 2430*A^2 + 6561*A + 6561*eye(5);
K = [0 0 0 0 1]*inv(Mc)*p_des;
kr = -1/(C * inv(A - B*K)*B);

%---------------------------------------------------
% estimator design parameters
%---------------------------------------------------
%

% Using Kalman Filter
% Let Rw = 0.01, sensor data covariance

[P,E,L] = care(A',C',0.01); % P is covariance matrix (solution to Riccati's equation), L is the estimator gain 

%---------------------------------------------------
% For simulation purposes (not to be modified)
%---------------------------------------------------
B1=[B L'];                   % Put the B and H matrix together as one matrix B1 (for Simulink implementation purposes) 
C1=eye(5);                  % Output all state variables from the model
D1=zeros(5,2);
