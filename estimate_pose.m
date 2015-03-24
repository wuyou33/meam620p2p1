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

params = varargin{1};
worldCoords = tag2WorldCoords(sensor.id, params.tags);
H = estHomographyWrapper(sensor, worldCoords);
[pos, eul] = estState(params.K,H);
end

function [pos, eul] = estState(K,H)

KinvH = K \ H;

KinvHMod = [ KinvH(:,1:2), cross(KinvH(:,1), KinvH(:,2)) ];
[U,~,V] = svd(KinvHMod);

Rmid=[ 1,0,0;
    0,1,0;
    0,0,det(U*V')];
Rp = U*Rmid*V';

T = KinvH(:,3)/norm(KinvH(:,1));

R = Rp;
pos = T;  
% [R,pos]=cam2rob(Rp, T);
[r, p, y] = rotmat2eul(R);
% TODO
%eul =[y;r;p];
eul = [r;p;y];
end

function [R,p]=cam2rob(Rp, T)
Hcam = [Rp,     T;
       0,0,0,  1];
HcamInRob = [rotMatZ(-(pi/4)),[0, 0, 0.015]';
           0,0,0           ,   1];
Hrob = HcamInRob*Hcam;
R=Hrob(1:3,1:3);
p = Hrob(1:3,4);
end