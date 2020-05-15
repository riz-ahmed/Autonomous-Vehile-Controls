%---------------------------------------------------
% Exercises on 2.3.2 - Drivetrain dynamic model
% Vehicle parameters
%---------------------------------------------------

load('EngineTorqueRef.mat');    % Load input signal (engine torque)

Jc=6250;                        % Chassis inertia [kgm^2]
Jf=0.625;                       % Flywheel inertia [kgm^2]
ds=1000;                        % Driveshaft damping coefficient [Nms/rad]
cs=85000;                       % Driveshaft spring coefficient [Nm/rad]
r=57;                           % Gear ratio [-]

%---------------------------------------------------
% Enter your A, B and H matrices here
%---------------------------------------------------
A=[-ds/(Jf*r^2) ds/(Jf*r) -cs/(Jf*r);
    ds/(Jc*r) -ds/Jc cs/Jc;
    1/r -1 0];
B=[1/Jf; 0; 0];
H=[0; -1/Jc; 0];
%---------------------------------------------------

B1=[B H];                       % Put the B and H matrix together as one matrix B1 (for Simulink implementation purposes) 
C=eye(3);                       % Output all state variables from the model
D=zeros(3,2);

x0=[120 2 0]';                  % Initial conditions for the state variables