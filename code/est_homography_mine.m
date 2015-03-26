function H = est_homography_mine(x_to,y_to,X_from,Y_from)

% num pts
n = size(x_to,1);

% 2 eqn for each pt
A = zeros(2*n,9);

for i=1:n
    st = 2*(i-1)+1;
    lt = st+1;
    xp=x_to(i);
    yp=y_to(i);
    x=X_from(i);
    y=Y_from(i);
    
    % each 2 rows for a pt corres
    submat = [  -x, -y,- 1,   zeros(1,3),    x*xp, y*xp, xp;
                zeros(1,3),   -x, -y, -1,    x*yp, y*yp, yp ];
    A(st:lt,:) = submat;
end
    [~,~,V] = svd(A);
    h = V(:,end);
    h = h/h(9);
    H = reshape(h,[3,3])';
end

