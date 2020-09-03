% Model Parameters
%------------------------------------------------------
Jc=6250;                        % Chassis inertia [kgm^2]
Jf=0.625;                       % Flywheel inertia [kgm^2]
ds=1000;                        % Driveshaft damping coefficient [Nms/rad]
cs=75000;                       % Driveshaft spring coefficient [Nm/rad]
r=57;                           % Gear ratio [-]

% State space model
%------------------------------------------------------
A=[[-ds/Jf/r^2 ds/Jf/r -cs/Jf/r];[ds/Jc/r -ds/Jc cs/Jc];[1/r -1 0]];
B=[1/Jf 0 0]';
H=[0 -1/Jc 0]';
C=[0 1 0];
 
% Observability
%------------------------------------------------------
obv = obsv(A,C);       % observability matrix
det_obv = det(obv);   % non-singular matrix --> controllable
% the system is observable when either the engine speed or the wheel speed
% are measured from the output or both of them together

% controllability
%------------------------------------------------------
Mc = ctrb(A,B);       % controllability matrix
det_ctrb = det(Mc);   % if det neq 0, matirx is non-sinular and system is completely controllable

 
% state feedback controller
%------------------------------------------------------ 
% desired parameters for two dominating poles
zeta = 1; wn = 5;
% des_eq1 = s^2 + 2*zeta*wn*s + wn^2 = s^2 + 10*s + 25

% desired position for the third pole
pole3 = -3*zeta*wn;
% des eq2 = (s + 15)

% des_polynomial = eq2 * eq1 -- > s^3 + 25*s^2 + 175*s + 375

% pole placement using desied poles (Akremann's formula)

p_des = A^3 + 25*A^2 + 175*A + 375*eye(3);
K_akr = [0 0 1]*inv(Mc)*p_des;
K = K_akr;
% K= [15.2 245.9 4313.0];

% reference gain
Kr = -1/(C * inv(A - B*K_akr)*B);
% Kr= 1113.3;

% Eigenvalues of the closed loop system
eig_val = eig(A - B*K_akr);  % if all values < 0, the system is stable

% Observer design
%------------------------------------------------------
% desired observer poles 4 times faster than controller
% p_des = (s + 60)^3 = s^3 + 180*s^2 + 10800*s + 216000

% p_des2 = A^3 + 180*A^2 + 10800*A + eye(3)*216000;
% L = [0 0 1]*inv(obv)*p_des2;
L= [179.3 101.6 -3.7]';

% Inital conditions for real plant
%---------------------------------------------------
x0=[120 2 0]';                  % Initial conditions for the state variables



% For simulation purposes only (not to be modified)
%------------------------------------------------------
B1=[B H];                   % Put the B and H matrix together as one matrix B1 (for Simulink implementation purposes) 
B2=[B L];                   % Put the B and L matrix together as one matrix B2 (for Simulink implementation purposes) 
C1=eye(3);                  % Output all state variables from the model
D=zeros(3,2);


