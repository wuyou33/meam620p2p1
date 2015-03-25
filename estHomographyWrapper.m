function H = estHomographyWrapper(sensor, wc)

imPts = [sensor.p0, sensor.p1, sensor.p2, sensor.p3, sensor.p4]';
worldPts = [wc.p0, wc.p1, wc.p2, wc.p3, wc.p4]';
%%
% figure(100);
% subplot(2,1,1)
% title('x')
% plot([imPts(:,1), -worldPts(:,2)*300+1000])
% subplot(2,1,2)
% title('y')
% plot([imPts(:,2), worldPts(:,2)*300])
% drawnow
%%
xySrc = worldPts;
xyDest = imPts;

H = est_homography(xyDest(:,1), xyDest(:,2), xySrc(:,1), xySrc(:,2));
% xyDestH = [ xyDest, ones(length(xyDest),1)]';
% xyDesT = (inv(H)*xyDestH)
% xyDesT = bsxfun(@rdivide, xyDesT(1:2,:), xyDesT(3,:));
% xyDesT = xyDesT';


% H = -2*H;
end