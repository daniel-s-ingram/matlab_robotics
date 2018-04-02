%Robotics, Vision and Control - Peter Corke
%Problem 4.6
% Moving to a point: plot x, y, and theta against time.
function move2point(x_goal, y_goal, Kv, Kh)
vehicle = SimpleVehicle(0, 0, 0, 1);

L = vehicle.L;

dt = 0.1;
t = 0;
x = vehicle.x;
y = vehicle.x;
theta = vehicle.theta;

x_diff = x_goal-x;
y_diff = y_goal-y;
distance = sqrt(x_diff^2 + y_diff^2);

while distance > L/2
    x_diff = x_goal-x;
    y_diff = y_goal-y;
    distance = sqrt(x_diff^2 + y_diff^2);
    
    theta = theta + Kh*angdiff(atan2(x_diff, y_diff), theta)*dt;
    
    v = Kv * distance;
    x = x + (v*sin(theta))*dt;
    y = y + (v*cos(theta))*dt;
    t = t+dt;
    
    vehicle.UpdatePose(x, y, -theta);
    PlotPose(vehicle, dt, x_goal, y_goal, L, t, x, y, theta);
end
end

function PlotPose(vehicle, dt, x_goal, y_goal, L, t, x, y, theta)
    subplot(4, 3, [1, 9]);
    plot([vehicle.front(1), vehicle.back_right(1)], [vehicle.front(2), vehicle.back_right(2)], 'r-', ...
         [vehicle.back_right(1), vehicle.back_left(1)], [vehicle.back_right(2), vehicle.back_left(2)], 'b-', ...
         [vehicle.back_left(1), vehicle.front(1)], [vehicle.back_left(2), vehicle.front(2)], 'r-', ...
         x_goal, y_goal, 'bo');
     
    xlim([-2*abs(x_goal), 2*abs(x_goal)]);
    ylim([-2*abs(y_goal), 2*abs(y_goal)]);
    xlabel('x-position');
    ylabel('y-position');
    hold on;
    
    subplot(4, 3, 10);
    plot(t, x, 'b.');
    ylabel('x-position');
    xlabel('time');
    hold on;
    
    subplot(4, 3, 11);
    plot(t, y, 'b.');
    ylabel('y-position');
    xlabel('time');
    hold on;

    subplot(4, 3, 12);
    plot(t, theta, 'b.');
    ylabel('heading');
    xlabel('time');
    hold on;
    
    pause(dt);
end
     