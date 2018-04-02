%Robotics, Vision and Control - Peter Corke
%Problem 4.6
% Moving to a point: plot x, y, and theta against time.
function move2point(x_goal, y_goal, Kp)
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
    
    theta = atan2(y_diff, x_diff);
    
    v = Kp * distance;
    x = x + (v*cos(theta))*dt;
    y = y + (v*sin(theta))*dt;
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
      
    xlim([-abs(x_goal)-L, abs(x_goal)+L]);
    ylim([-abs(y_goal)-L, abs(y_goal)+L]);
    xlabel('x-position');
    ylabel('y-position');
    hold off;
    
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
     