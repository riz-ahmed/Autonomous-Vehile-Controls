%---------------------------------------------------
% Exercises on 3.4.2 - Driveline control
% Vehicle parameters
%---------------------------------------------------

Jc=6250;                        % Chassis inertia [kgm^2]
Jf=0.625;                       % Flywheel inertia [kgm^2]
ds=1000;                        % Driveshaft damping coefficient [Nms/rad]
cs=75000;                       % Driveshaft spring coefficient [Nm/rad]
r=57;                           % Gear ratio [-]

%---------------------------------------------------
% Enter your A, B and H matrices here
%---------------------------------------------------
A= [-ds/(Jf*r^2) ds/(Jf*r) -cs/(Jf*r); ds/(Jc*r) -ds/Jc cs/Jc; 1/r -1 0];
B = [1/Jf; 0; 0];
H= [0; -1/Jc; 0];


%---------------------------------------------------
% Enter your control design here
% Hint: charpoly - could be a good  and useful function
%---------------------------------------------------
Wr= [B A*B A^2*B];
Wr_tilde= inv([1 0.6525 48.5087; 0 1 0.6525; 0 0 1]);
K = [10.2 325.53 1959.1];
kr= 906.9;


%---------------------------------------------------
% For simulation purposes (do not modify)
%---------------------------------------------------
B1=[B H];                       % Put the B and H matrix together as one matrix B1 (for Simulink implementation purposes) 
C=eye(3);                       % Output all state variables from the model
D=zeros(3,2);                   % Corresponding D matrix
x0=[120 2 0]';                  % Initial conditions for the state variables

