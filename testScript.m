clc
clear
close all

datasets = {};
%datasets{1} = 'studentdata1.mat';
datasets{1} = 'studentdata4.mat';
datasets{2} = 'studentdata9.mat';

init_script

for i = 1: 1%length(datasets)
    load(datasets{i});
     visualizePose(vicon,time,strcat(' Vicon, DataSet : ' ,datasets{i} ));
    
    n = length(data);
    eul = zeros(3,n);
    pos = zeros(3,n);
    t = zeros(1,n);
    for j = 1:n
        
        if data(j).is_ready
        [pos(:,j),eul(:,j)] = estimate_pose(data(j),params); 
        t(j) = data(j).t;
        end
    end
    
    visualizePose([pos;eul],t,strcat(' Estimation, DataSet : ' ,datasets{i} ));
    plotResults
%     clear time data vicon
end