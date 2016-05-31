function [ im_out ] = resizeImage( im_path, size_x, size_y )
%RESIZEIMAGE Summary of this function goes here
%   Detailed explanation goes here

im = imread(im_path);
im_out = imresize(im, [size_x size_y]);

end

