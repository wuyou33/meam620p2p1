function visualizePose(data, time,dataId)
figure;
plot(time', data(1:3,:)');
title(strcat('xyz, ',(dataId)))
legend('x','y','z')
grid on
figure;
plot(time', data(4:6,:)');
title(strcat('roll pitch yaw ',(dataId)));
legend('roll','pitch','yaw')
grid on

plotTraj(data(1:3,:)', time',dataId);

end
