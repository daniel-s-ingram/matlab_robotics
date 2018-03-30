%Robotics, Vision and Control - Peter Corke
%Problem 3.3
% Make a simulation with a particle moving at constant velocity and a
% rotating reference frame. Plot the position of the particle in the
% inertial and the rotating reference frame and observe how the motion
% changes as a function of the inertial frame velocity.

function rotating_reference_frame(v, w)
if nargin ~= 2
    v = [10;3;2];
    w = [0.2;0.1;0.5];
end

R_ab = eul2r(0,0,0);
Rdot_ab = skew(w)*R_ab;

v_a = v; %Spatial velocity in world frame
v_b = R_ab*v_a; %Spatial velocity in rotating frame

steps = 1000;
dt = 10/steps;

p_a = zeros(3,1);
p_b = zeros(3,1);

for i = 1:steps
    p_a = p_a + v_a*dt;
    p_b = p_b + v_b*dt;
    
    hold on;
    plot3(p_a(1), p_a(2), p_a(3), 'ro');
    plot3(p_b(1), p_b(2), p_b(3), 'bo');
    
    R_ab = R_ab + Rdot_ab*dt;
    Rdot_ab = skew(w)*R_ab;
    v_b = R_ab*v_a;
    
    pause(dt);
end

end