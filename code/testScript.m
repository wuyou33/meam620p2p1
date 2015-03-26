clc
clear
close all
addpath('../data')
datasets = {};
%datasets{1} = 'studentdata1.mat';
datasets{1} = 'studentdata4.mat';
datasets{2} = 'studentdata9.mat';
init_script


for i = 1: 1%length(datasets)
    
    load(datasets{i});
%      visualizePose(vicon,time,strcat(' Vicon, DataSet : ' ,datasets{i} ));

    n = length(data);
    eul = zeros(3,n);
    pos = zeros(3,n);
    t = zeros(1,n);    
    vicon_int=[];
    for j=1:n
        t(j) = data(j).t;
    end
    for k=4:6
        vicon_int = [vicon_int; spline(time, vicon(k,:), t)]; 
    end

    for j = 1:n
        j
        clc
        if data(j).is_ready
            e_vicon=vicon_int(:,j)
            R_vicon = RPYtoRot_ZXY(e_vicon(1),e_vicon(2),e_vicon(3))
            [pos(:,j),eul(:,j)] = estimate_pose(data(j),params); 
        end
    end
    
%     visualizePose([pos;eul],t,strcat(' Estimation, DataSet : ' ,datasets{i} ));
    plotResults
%     clear time data vicon
end