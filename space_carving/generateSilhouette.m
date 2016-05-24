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
S = im(:,:,1) > im(:,:,3);
S = bwareaopen(S, ceil(h*w/10));
s = S;
end
