%Robotics, Vision and Control - Peter Corke
%Problem 2.2
% Animate a rotating cube.
% a) Write a function to plot the edges of a cube centered at the origin.
% b) Modify the function to accept an argument which is a homogeneous transformation which is
%    applied to the cube vertices before plotting.
% c) Animate rotation about the x-axis.
% d) Animate rotation about all axes.

function rotating_cube(l, w, h)
if nargin ~= 3
    l = 5; w = 5; h = 5;
end

r = 0;
p = 0;
y = 0;
t = 0;

maxDim = max([l, w, h]);

while true
    length = l*sin(t);
    width = w*sin(t+pi/4);
    height = h*cos(t);
    r = r+0.01;
    p = p+0.01;
    y = y+0.01;
    t = t+0.1;
    
    plot_cube(length, width, height, r, p, y, maxDim);
    
    drawnow;
end

end

function plot_cube(l, w, h, r, p, y, maxDim)
R = eul2r(r, p, y);
p = [[w/2; l/2; h/2], ...
      [w/2; -l/2; h/2], ...
      [w/2; l/2; -h/2], ...
      [w/2; -l/2; -h/2], ...
      [-w/2; l/2; h/2], ...
      [-w/2; -l/2; h/2], ...
      [-w/2; l/2; -h/2], ...
      [-w/2; -l/2; -h/2]];

p = R*p;

x = [[p(1,1); p(1,2)], [p(1,1); p(1,3)], [p(1,1); p(1,5)], ...
        [p(1,6); p(1,5)], [p(1,6); p(1,2)], [p(1,6); p(1,8)], ...
        [p(1,7); p(1,5)], [p(1,7); p(1,3)], [p(1,7); p(1,8)], ...
        [p(1,4); p(1,2)], [p(1,4); p(1,3)], [p(1,4); p(1,8)]];
   
y = [[p(2,1); p(2,2)], [p(2,1); p(2,3)], [p(2,1); p(2,5)], ...
        [p(2,6); p(2,5)], [p(2,6); p(2,2)], [p(2,6); p(2,8)], ...
        [p(2,7); p(2,5)], [p(2,7); p(2,3)], [p(2,7); p(2,8)], ...
        [p(2,4); p(2,2)], [p(2,4); p(2,3)], [p(2,4); p(2,8)]];
    
z = [[p(3,1); p(3,2)], [p(3,1); p(3,3)], [p(3,1); p(3,5)], ...
        [p(3,6); p(3,5)], [p(3,6); p(3,2)], [p(3,6); p(3,8)], ...
        [p(3,7); p(3,5)], [p(3,7); p(3,3)], [p(3,7); p(3,8)], ...
        [p(3,4); p(3,2)], [p(3,4); p(3,3)], [p(3,4); p(3,8)]];
   

plot3(x, y, z, 'r');
limit = maxDim;
xlim([-limit, limit]);
ylim([-limit, limit]);
zlim([-limit, limit]);
end

