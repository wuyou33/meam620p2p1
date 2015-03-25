function [pos, eul] = estimate_pose(sensor, varargin)
%ESTIMATE_POSE 6DOF pose estimator based on apriltags
%   sensor - struct stored in provided dataset, fields include
%          - is_ready: logical, indicates whether sensor data is valid
%          - rpy, omg, acc: imu readings, you should not use these in this phase
%          - img: uint8, 240x376 grayscale image
%          - id: 1xn ids of detected tags
%          - p0, p1, p2, p3, p4: 2xn pixel position of center and
%                                four corners of detected tags
%            Y
%            ^ P3 == P2
%            | || P0 ||
%            | P4 == P1
%            o---------> X
%   varargin - any variables you wish to pass into the function, could be
%              a data structure to represent the map or camera parameters,
%              your decision. But for the purpose of testing, since we don't
%              know what inputs you will use, you have to specify them in
%              init_script by doing
%              estimate_pose_handle = ...
%                  @(sensor) estimate_pose(sensor, your personal input arguments);
%   pos - 3x1 position of the quadrotor in world frame
%   eul - 3x1 euler angles of the quadrotor
toPlot = false;
params = varargin{1};
worldCoords = tag2WorldCoords(sensor.id, params.tags, toPlot);
H_world_in_cam = estHomographyWrapper(sensor, worldCoords );
if toPlot
    compareWorldCoords(sensor, params.tags,worldCoords, HH_world_in_cam);
end
[pos, eul] = estState(params.K,H_world_in_cam);
end

function [pos, eul] = estState(K,H_world_in_cam)

KinvH = K \ H_world_in_cam;

KinvHMod = [ KinvH(:,1:2), cross(KinvH(:,1), KinvH(:,2)) ];
[U,~,V] = svd(KinvHMod);
% V = V';
Rmid=[ 1,0,0;
    0,1,0;
    0,0,det(U*V')];
% det(Rmid)
R_w_in_c = U*Rmid*V';

T_w_in_c = KinvH(:,3)/norm(KinvH(:,1));

R = R_w_in_c;
pos = T_w_in_c;
[R,pos]=cam2rob(R_w_in_c, T_w_in_c);
[r, p, y] = rotmat2eul(R_w_in_c);
eul = [r;p;y];
end

function [R,p]=cam2rob(Rp, T)
H_w_in_c = [Rp,     T;
       0,0,0,  1];
   
cp = cos(pi/4);
H_c_in_r = [  cp,   -cp,    0        0;
             -cp,   -cp,    0,       0;
              0,     0,    -1,     0.03;
              0,     0,     0,       1];
H_w_in_r = H_c_in_r*H_w_in_c;
H_r_in_w = inv(H_w_in_r);
R=H_r_in_w(1:3,1:3);
p = H_r_in_w(1:3,4);
end