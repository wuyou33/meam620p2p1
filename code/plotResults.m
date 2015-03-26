
plotnames = {' x ',' y ', ' z ', ' roll ', ' pitch ', ' yaw ' };
est = [pos;eul];
figure;
for i=1:size(est,1)
   
    if i==4
        figure;
    end
    
    if i<=3
        subplot(3,1,i)
        plot(time,vicon(i,:),'b-');
    else
        subplot(3,1,i-3)
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