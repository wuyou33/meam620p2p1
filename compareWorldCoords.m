function compareWorldCoords(sensor, tags, wc_act, H)
    Hi = inv(H)';
    img = sensor.img;
    tform = projective2d(Hi); 
    img_rot = imwarp(img, tform);
    xySrc = [wc_act.p0, wc_act.p1, wc_act.p2, wc_act.p3, wc_act.p4]';
    xySrcH = [ xySrc, ones(length(xySrc),1)]';
    xySrcT = (H*xySrcH);
    xySrcT = bsxfun(@rdivide, xySrcT(1:2,:), xySrcT(3,:));
    xySrcT = xySrcT';
    x = 0:107;
    wc_grid = tag2WorldCoords(x,tags);
    figure(88);
    clf(88)
    subplot(2,2,1)
    hold on
    
    plotGrid(wc_grid, 'b.', 'rx' );
    plotGrid(wc_act, 'mo', 'bo' );
    axis equal
    subplot(2,2,2)
    imagesc(img)
    hold on
    pts = [sensor.p0, sensor.p1, ...
        sensor.p2, sensor.p3, sensor.p4]';
    plot(pts(:,1), pts(:,2),'rx')
    plot(xySrcT(:,1), xySrcT(:,2),'bo')
    

    axis image
    colormap(gray)
    subplot(2,2,3)
    imagesc(img_rot)
    axis image
%     colormap(gray)
    hold  on
%     pts = [wc_act.p0, wc_act.p1, ...
%         wc_act.p2, wc_act.p3, wc_act.p4]';
%     plot(xyDesT(:,1), xyDesT(:,2),'rx')
    drawnow
end


function plotGrid(wc, des1, des2)
    plot(wc.p0(1,:), wc.p0(2,:), des2);
    plot(wc.p1(1,:), wc.p1(2,:), des1);
    plot(wc.p2(1,:), wc.p2(2,:), des1);
    plot(wc.p3(1,:), wc.p3(2,:), des1);
    plot(wc.p4(1,:), wc.p4(2,:), des1);
end


    