% parameters
V_s = 24;       % supply in volts
L = 0.1;          % Inductance in Henry [H]
R_load = 1.01;  % Load resistance [ohms]
step = 0.1;     % step size of simulation
time = [0:step:5];   % simulation time
c = find(time == 1);

% ON state
i_on = zeros(c,1);
for i = 1:c
    i_on(i) = (V_s/L)*time(i);
end
i = 0;
% plot(time(:,1:c),i_on(1:c))

% OFF state

d = size(time,2) - c;
i_off = zeros(d,1);
t_s = ones(d,1) * 1;
for i = 1:d
    i_off(i) = (V_s / R_load) + ((i_on(end,1) - (V_s/R_load)) * exp(-(R_load/L)*(time(i+c))));
end
% i_off = (V_s / R_load) + (i_on - (V_s/R_load)) * exp(-(R_load/L)*(T-t_s));
