m = 1700;
J = 2000;
c1 = 100000;
c2 = 80000;
a = 1.5;
b = 1.3;
vx = 0.1;

for i = 1:1000000
    
    a1 = ((a^2*c1 + b^2*c2)/(J*vx)) + ((c1+c2)/(m*vx));
    
    a2 = (((c1*c2)*(a+b)^2)/(m*J*vx^2))*(1 + ((b*c2 - a*c1)/(c1*c2*(a+b)^2))*m*vx^2);
    
    lambda1 = (-a1 + sqrt(a1^ - 4*a2))/(2*a1);
    lambda2 = (-a1 - sqrt(a1^ - 4*a2))/(2*a1);
    
    if (lambda1 > 0 || lambda2 > 0)
        break
    end
    
    vx = vx + 0.1;
    
end