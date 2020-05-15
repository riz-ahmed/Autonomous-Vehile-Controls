r = 4;
angle1 = 2*pi/32;
angle = zeros(33,1);
angle(1) = 0;
for i = 2:33
    angle(i) = angle(i-1)+angle1;
end
x = zeros(33,1);
y = zeros(33,1);
for i = 1:33
    x(i,1) = r*cos(angle(i));
    y(i,1) = r*sin(angle(i));
end
z1 = ones(33,1);
z2 = ones(33,1)*2;
z3 = ones(33,1)*3;
z4 = ones(33,1)*4;
z5 = ones(33,1)*5;
hold on
plot3(x,y,z1);
plot3(x,y,z2);
plot3(x,y,z3);
plot3(x,y,z4);
plot3(x,y,z5);