function follow_line(a, b, c, Kd, Kh)
if nargin ~= 5
    a = 2;
    b = 4;
    c = 100;
    Kd = 0.01;
    Kh = 0.1;
end

vehicle = SimpleVehicle(0, 0, pi/4, 1);

dt = 0.01;

v = 20;
x = vehicle.x;
y = vehicle.y;
theta = vehicle.theta;
theta_des = atan2(-a, b);

global running
running = true;

fig = gcf;
set(fig, 'KeyPressFcn', @KeyPressed);

xl = -50:50;
yl = (-a/b)*xl + (-c/b);
plot(xl, yl);
hold on;

while running
    theta = theta - Kd*(dot([a, b, c], [x, y, 1])/sqrt(a^2+b^2)) + Kh*angdiff(theta_des, theta);
    x = x + v*cos(theta)*dt;
    y = y + v*sin(theta)*dt;
    
    vehicle.UpdatePose(x, y, 3*pi/2+theta);
    
    PlotPose(vehicle);
    
    pause(dt);
end

close;

end

function PlotPose(vehicle)
    plot([vehicle.front(1), vehicle.back_right(1)], [vehicle.front(2), vehicle.back_right(2)], 'r-', ...
         [vehicle.back_right(1), vehicle.back_left(1)], [vehicle.back_right(2), vehicle.back_left(2)], 'b-', ...
         [vehicle.back_left(1), vehicle.front(1)], [vehicle.back_left(2), vehicle.front(2)], 'r-');
end

function KeyPressed(~, event)
global running
if strcmp(event.Key, 'escape')
    running = false;
end
end

