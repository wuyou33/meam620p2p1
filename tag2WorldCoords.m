function wc = tag2WorldCoords(tags, tagMat, toPlot)
    
    n = length(tags);
    wc.p0 = zeros(2,n);
    wc.p1 = zeros(2,n);
    wc.p2 = zeros(2,n);
    wc.p3 = zeros(2,n);
    wc.p4 = zeros(2,n);

    for i = 1:n
        [wc.p0(:,i),wc.p1(:,i),wc.p2(:,i),wc.p3(:,i),wc.p4(:,i)] = ...
                            computeWC(tags(i), tagMat, toPlot);
    end
    
end

function [p0,p1,p2,p3,p4] = computeWC(tag, tagMat,toPlot)
    d = (0.152);
    dex = (0.178-d);
    if toPlot
        d = d*100;
        dex = dex*100;
    end
    p4 = [0;0];
    [i,j] = find(tagMat==tag);
    
    % just in case multiple matches
    i = i(1);
    j = j(1);
    
    %top lt
    p4(1) = (i-1)*2*d;
    p4(2) = (j-1)*2*d;
    
    if j>=7
        p4(2) = p4(2) + (2*dex);
    elseif j>=4
        p4(2) = p4(2) + dex;
    end
    
    % mid pt
    p0 = p4+(d/2);
    
    %bot lt
    p1 = p4;
    p1(1) = p1(1)+d;
    
    %bot rt
    p2 = p4+d;
    
    %top rt
    p3 = p4;
    p3(2) = p3(2)+d;
    
    
end