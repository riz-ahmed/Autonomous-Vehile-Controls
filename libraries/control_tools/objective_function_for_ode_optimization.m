function obj = myObj(k)
% myObj is the objective function that is used to optimise
% given set of data points using a ODE solver

% predicted values
n = 30;
time = linspace(0,20,n);
x0 = 3.0;
[t,x] = ode15s(@(t,x)myModel(t,x,k),time, x0);

end