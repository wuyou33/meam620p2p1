function [roll, pitch, yaw] = rotmat2eul(R)

roll = (1/2)*asin((R(3,2)^2)-1);
pitch = atan2(-R(3,1), R(3,3));
yaw = atan2(-R(1,2),R(2,2));

end