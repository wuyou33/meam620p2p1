function plotTraj(xyz, t, id)

figure
n = length(t);
grid on
xlabel('x')
ylabel('y')
zlabel('z')
% pause
hold on
for i=1:(n-1)
    %plot3([xyz(i,1)],[xyz(i,2)],[xyz(i,3)],'b.');
    plot3([xyz(i,1),xyz(i+1,1)],[xyz(i,2),xyz(i+1,2)],[xyz(i,3),xyz(i+1,3)],'r-')
%     drawnow
end

title(strcat('traj, dataset: ',id));
hold off
end