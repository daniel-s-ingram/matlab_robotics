classdef SimpleVehicle < handle
    
    properties
        x
        y
        theta
        L
        front
        back_left
        back_right
    end
    
    methods
        function obj = SimpleVehicle(x, y, theta, L)
            obj.L = L;
            
            obj.front = [0; obj.L/2];
            obj.back_left = [-obj.L/2; -obj.L/2];
            obj.back_right = [obj.L/2; -obj.L/2];
            
            UpdatePose(obj, x, y, theta);
        end
        
        function obj = UpdatePose(obj, x, y, theta)
            obj.x = x;
            obj.y = y;
            obj.theta = theta;
            UpdatePoints(obj);
        end
        
        function obj = UpdatePoints(obj)
            R = eul2r(obj.theta, 0, 0);
            R = R(1:2, 1:2);
            obj.front = [obj.x; obj.y] + (R*[0; obj.L/2]);
            obj.back_left = [obj.x; obj.y] + (R*[-obj.L/2; -obj.L/2]);
            obj.back_right = [obj.x; obj.y] + (R*[obj.L/2; -obj.L/2]);
        end
    end
    
end

