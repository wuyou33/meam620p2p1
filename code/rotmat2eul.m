function [roll, pitch, yaw] = rotmat2eul(R)

phi = asin(R(2,3));
psi = atan2(-R(2,1)/cos(phi),R(2,2)/cos(phi));
theta = atan2(-R(1,3)/cos(phi),R(3,3)/cos(phi));

roll =phi ;
pitch =theta ;
yaw =psi ;

end