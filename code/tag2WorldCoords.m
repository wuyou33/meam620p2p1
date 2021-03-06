function wc = tag2WorldCoords(tags, tagMat)

    persistent lookup
    if isempty(lookup)
        maxId = max(tagMat(:));
        lookup.p0 = zeros(2,maxId+1);
        lookup.p1 = zeros(2,maxId+1);
        lookup.p2 = zeros(2,maxId+1);
        lookup.p3 = zeros(2,maxId+1);
        lookup.p0 = zeros(2,maxId+1);
        for i = 0:maxId
        j = i+1;
        [lookup.p0(:,j),lookup.p1(:,j),lookup.p2(:,j),lookup.p3(:,j),lookup.p4(:,j)] = ...
                            computeWC(i, tagMat);
        end
        
    end
    
    n = length(tags);
    wc.p0 = zeros(2,n);
    wc.p1 = zeros(2,n);
    wc.p2 = zeros(2,n);
    wc.p3 = zeros(2,n);
    wc.p4 = zeros(2,n);

    for i = 1:n
        wc.p0(:,i)= lookup.p0(:,tags(i)+1);
        wc.p1(:,i)= lookup.p1(:,tags(i)+1);
        wc.p2(:,i)= lookup.p2(:,tags(i)+1);
        wc.p3(:,i)= lookup.p3(:,tags(i)+1);
        wc.p4(:,i)= lookup.p4(:,tags(i)+1);
    end
    
end

function [p0,p1,p2,p3,p4] = computeWC(tag, tagMat)
    d = (0.152);
    dex = (0.178-d);
%     if toPlot
%         d = d*100;
%         dex = dex*100;
%     end
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