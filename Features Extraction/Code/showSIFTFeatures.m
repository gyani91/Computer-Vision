% show image with key points
%
% Input:
%   img        - n x m color image 
%   f          - features
%   d          - descriptors
%   fig        - figure id
function showImageWithCorners(img, f, d, fig)
% Visualize Features and Descriptors
    figure(fig);
    imshow(img);
    hold on;
    perm = randperm(size(f,2));
    sel = perm(1:50);
    h1 = vl_plotframe(f(:,sel));
    h2 = vl_plotframe(f(:,sel));
    set(h1,'color','k','linewidth',3);
    set(h2,'color','y','linewidth',2);
    h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel));
    set(h3,'color','g');
    hold off;
end