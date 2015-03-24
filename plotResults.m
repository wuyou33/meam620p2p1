
plotnames = {' x ',' y ', ' z ', ' roll ', ' pitch ', ' yaw ' };
est = [pos;eul];
for i=1:size(est,1)
   
    figure
    if i<=3
        plot(time,vicon(i,:),'b-');
    else
        plot(time,rad2deg(vicon(i,:)),'b-');
    end
    hold on
    if i<=3
        plot(t, (est(i,:)),'r-');
    else
        plot(t, rad2deg(est(i,:)),'r-');
    end

    
    title(plotnames{i})
    legend('vicon', 'est')
    
end