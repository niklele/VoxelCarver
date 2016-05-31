function s = generateSilhouette( im )
%GENERATESILHOUETTE - find the silhouette of an object centered in the image
% Arguments:
%          im - an image matrix read in by im2read (size H X W X C)
%
% Returns:
%          s - the silhouette matrix (size HxW) of 0's and 1's, where 0
%          means that it is not part of the object, and 1 is part of the
%          object (the parts labeled 0 will be carved away).
%
% You must come up with a simple way to distinguish the object from the
% background. The better you distinguish it, the better the overall carving
% will be at the end. However, you do not need to make the silhouette
% generation perfect - or even "good". However to get a decent carving at
% the end, you should at least have the majority of the object as 1
% A valid solution can be as simple as 1 line long.
% We use the RGB colors/gradients in our solution, but feel free to 
% experiment with other features as well.
[h,w,~] = size(im);

% convert to LAB colorspace
cform = makecform('srgb2lab');
lab_s = applycform(im,cform);

% classify in AB space with kmeans
ab = double(lab_s(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 3;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);
                                  
pixel_labels = reshape(cluster_idx,nrows,ncols);

% find the bluest cluster center to select which cluster to use for
% silhouette
mean_cluster_value = mean(cluster_center,2);
[tmp, idx] = sort(mean_cluster_value);
blue_cluster_num = idx(1);

rgb_label = repmat(pixel_labels,[1 1 3]);
im(rgb_label ~= blue_cluster_num) = 0;
im(rgb_label == blue_cluster_num) = 255;

s = im2double(im);

end
