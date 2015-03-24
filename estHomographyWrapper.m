function H = estHomographyWrapper(sensor, wc)

imPts = [sensor.p0, sensor.p1, sensor.p2, sensor.p3, sensor.p4]';
worldPts = [wc.p0, wc.p1, wc.p2, wc.p3, wc.p4]';
xySrc = worldPts;
xyDest = imPts;

H = est_homography(xyDest(:,1), xyDest(:,2), xySrc(:,1), xySrc(:,2));

end