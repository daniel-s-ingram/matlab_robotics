function move2pose(x_goal, y_goal, theta_goal, K_rho, K_alpha, K_beta)
if nargin ~= 6
    x_goal = 20*rand-10;
    y_goal = 20*rand-10;
    theta_goal = pi/2;
    K_rho = 3;
    K_alpha = 5;
    K_beta = -2;
end

vehicle = SimpleVehicle(0, 0, 0, 1);

global running
running = true;
fig = gcf;
set(fig, 'KeyPressFcn', @KeyPressed);

plot(x_goal, y_goal, 'r*');
hold on;

x = vehicle.x;
y = vehicle.y;
theta = vehicle.theta;
L = vehicle.L;

x_diff = x_goal-x;
y_diff = y_goal-y;

rho = sqrt(x_diff^2+y_diff^2);
alpha = atan2(y_diff, x_diff) - theta;
beta = -theta-alpha+theta_goal;

dt = 0.01;

while running
    v = K_rho*rho;
    w = K_alpha*alpha + K_beta*beta;
    
    if alpha > pi/2 || alpha <= -pi/2
        v = -v;
    end
    
    theta = theta + w*dt;
    x = x + v*cos(theta)*dt;
    y = y + v*sin(theta)*dt;
    
    vehicle.UpdatePose(x, y, 3*pi/2+theta);
    PlotPose(vehicle);
    
%     rho = rho - K_rho*cos(alpha)*dt;
%     alpha = alpha + (K_rho*sin(alpha) - K_alpha*alpha - K_beta*beta)*dt;
%     beta = beta - K_rho*sin(cur_alpha)*dt;

    x_diff = x_goal-x;
    y_diff = y_goal-y;

    rho = sqrt(x_diff^2+y_diff^2);
    alpha = atan2(y_diff, x_diff) - theta;
    beta = -theta-alpha+theta_goal;
    
    pause(dt);
end
end

function PlotPose(vehicle)
plot([vehicle.front(1), vehicle.back_right(1)], [vehicle.front(2), vehicle.back_right(2)], 'r-', ...
     [vehicle.back_right(1), vehicle.back_left(1)], [vehicle.back_right(2), vehicle.back_left(2)], 'b-', ...
     [vehicle.back_left(1), vehicle.front(1)], [vehicle.back_left(2), vehicle.front(2)], 'r-');
 
xlim([-10 10]);
ylim([-10 10]);
end

function KeyPressed(~, event)
global running
if strcmp(event.Key, 'escape')
    running = false;
end
end