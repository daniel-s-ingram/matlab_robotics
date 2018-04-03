function pure_pursuit()
Kv = 3;
Ki = 0.00001;
Kh = 6;

A = 5;
range = 4*pi;
dt = 0.01;

global running
running = true;

fig = gcf;
set(fig, 'KeyPressFcn', @KeyPressed);

x_traj = -range:dt:range;
y_traj = A*sin(x_traj);
plot(x_traj, y_traj);
hold on;

vehicle = SimpleVehicle(2*range*rand-range, 2*A*rand-A, 2*pi*rand, 1);

des_x = -range;
x = vehicle.x;
y = vehicle.y;
theta = vehicle.theta;

totalError = 0;
T = 0;
d = 10*dt;

while running
    des_y = A*sin(des_x);
    plot(des_x, des_y, 'r.');
    des_theta = atan2(des_x-x, des_y-y);
    des_x = des_x+dt;
    
    error = sqrt((des_x-x)^2+(des_y-y)^2)-d;
    totalError = totalError + error;
    T = T + dt;
    
    theta = theta + Kh*angdiff(des_theta, theta)*dt;
    v = Kv*error + Ki*totalError*T;
    x = x + v*sin(theta)*dt;
    y = y + v*cos(theta)*dt;
    
    vehicle.UpdatePose(x, y, -theta);
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