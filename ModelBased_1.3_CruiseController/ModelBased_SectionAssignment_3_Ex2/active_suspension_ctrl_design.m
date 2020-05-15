%---------------------------------------------------
% Exercises on Section Assignment 3 - Active suspension control design
% Model parameters
%---------------------------------------------------

mc=401;                         % Quarter car mass [kg]
mw=48;                          % Wheel mass [kg]
ds=2200;                        % Suspension damping coefficient [Ns/m]
cs=23000;                       % Suspension spring coefficient [N/m]
cw=250000;                      % Wheel spring coefficient [N/m]
tau=0.001;                      % Actuator time constant [s]

%---------------------------------------------------
% The active suspension model
% A, B, C, and H matrices
%---------------------------------------------------
A=[[0 1 0 0 0];[-(cw+cs)/mw -ds/mw cs/mw ds/mw -1/mw];[0 0 0 1 0];[cs/mc ds/mc -cs/mc -ds/mc 1/mc];[0 0 0 0 -1/tau]];
B=[0 0 0 0 1/tau]';
H=[0 cw/mw 0 0 0]';

C=[[-1 0 1 0 0];[cs/mc ds/mc -cs/mc -ds/mc 1/mc]];   

%---------------------------------------------------
% Enter your control design here
%---------------------------------------------------
alpha1 = 1; alpha2 = 0; rho = 1;                    % weights for output params
y1_max = 0.05; y2_max = 5; u_max = 1000;            % max output and control params
Qy = [alpha1/y1_max^2 0; 0 alpha2/y2_max^2];        % from ouput parameter weights
Qx= transpose(C)*Qy*C;                              % state penatly matrix from output penalty matrix
Qu= rho/u_max^2;
K= lqr(A,B,Qx,Qu);



%---------------------------------------------------
% For simulation purposes (do not modify)
%---------------------------------------------------
B1=[B H];                   % Put the B and H matrix together as one matrix B1 (for Simulink implementation purposes) 
C1=eye(5);                  % Output all state variables from the model
D1=zeros(5,2);              % Corresponding D matrix
