% Script file for VehicleSteering_sim.slx

%---------------------------------------------------
% Section 3.1.1 Example 1 - Vehicle steering 
% Pole placement design
%
%---------------------------------------------------
% Model parameters
%---------------------------------------------------
a=2;
b=4;
v0=12;

%---------------------------------------------------
% Model matrices
%---------------------------------------------------

A=[0 v0;0 0];
B=[a*v0/b v0/b]';
C=eye(2);
D=[0 0]';


%---------------------------------------------------
% Control design
%---------------------------------------------------

zeta=1;
wn=10;

K=[b*wn^2/v0^2 (2*zeta*wn*b/v0-a*b*wn^2/v0^2)];
kr=b*wn^2/v0^2;
