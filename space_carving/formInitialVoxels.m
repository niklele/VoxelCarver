function [voxels, voxel_size] = formInitialVoxels(xlim,ylim,zlim,N)
%FORMINITIALVOXELS  create a basic grid of voxels ready for carving
% Arguments:
%          xlim - The limits of the x dimension given as [xmin xmax]
%          ylim - The limits of the y dimension given as [ymin ymax]
%          zlim - The limits of the z dimension given as [zmin zmax]
%          N - The approximate number of voxels we desire in our grid
%
% Returns:
%          voxels - the matrix of N'x3 (where N' approximately equals N) of
%               voxel locations
%          voxel_size - the distance between the locations of adjacent voxel 
%               (a voxel is a cube)
%
% Our initial voxels will create a rectangular prism defined by the x,y,z
% limits. Each voxel will be a cube, so you'll have to compute the
% approximate side-length (voxel_size) of these cubes as well as how many
% cubes you need to place in each dimension to get around the desired
% number of voxels (N). The final "voxels" output should be a matrix where
% every row is the location of the center of the voxel.

V = (xlim(2) - xlim(1)) * (ylim(2) - ylim(1)) * (zlim(2) - zlim(1));

s = nthroot(V/N,3);
s = ceil(s / 0.0001) * 0.0001;

Np = floor(V/s^3);
voxels = zeros(Np,3);

% Keep track of top left corner
dim = [xlim(2) - xlim(1); ylim(2) - ylim(1); zlim(2) - zlim(1)]/s;
h = floor(dim(1)); w = floor(dim(2)); d = floor(dim(3));
[x, y, z] = meshgrid((xlim(1)+s/2):s:xlim(2),...
                     (ylim(1)+s/2):s:ylim(2),...
                     (zlim(1)+s/2):s:zlim(2));
voxels = [x(:) y(:) z(:)];

% i = 1;
% for x = xlim(1):s:xlim(2)
%     x_ = x + s/2;
%     for y = ylim(1):s:ylim(2)
%         y_ = y + s/2;
%         for z = zlim(1):s:zlim(2)
%             z_ = z + s/2;
%             voxels(i,:) = [x_, y_, z_];
%             i = i+1;
%         end
%     end
%     
% end
voxel_size = s;

end

