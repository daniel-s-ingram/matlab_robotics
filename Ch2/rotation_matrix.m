%Robotics, Vision and Control - Peter Corke
%Problem 2.8
% For the 3-dimensional rotation about the vector [2,3,4] by 0.5 rad
% compute an SO(3) rotation matrix using: the matrix exponential functions
% expm and trexp, Rodrigues' rotation formula (code this yourself), and the
% Toolbox function angvec2tr. Compute the equivalent unit quaternion.
function rotation_matrix(theta, v)
if nargin == 0
    theta = 0.5;
    v = [2,3,4];
end

mag = sqrt(v(1)^2+v(2)^2+v(3)^2);
v(1) = v(1)/mag;
v(2) = v(2)/mag;
v(3) = v(3)/mag;

disp('SO(3) rotation matrix computed using the matrix exponential');
R = expm(skew(v*theta))

disp('SO(3) rotation matrix computed using Rodrigues'' formula');
R = eye(3,3) + sin(theta)*skew(v) + (1-cos(theta))*skew(v)^2

disp('SO(3) rotation matrix computed using the MATLAB Robotics Toolbox function');
R = angvec2r(theta, v)

disp('Equivalent unit quaternion');
q = Quaternion(R)

end

