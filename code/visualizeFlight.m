function visualizeFlight(data)
%% This function justs plots the image from the quad to visualize the 
% flight
for i=1:length(data)
    imagesc(data(i).img)
    axis image
    colormap gray
    drawnow
end