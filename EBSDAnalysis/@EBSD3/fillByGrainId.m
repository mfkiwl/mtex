function ebsd = fillByGrainId(ebsd)
% extrapolate spatial EBSD data by nearest neighbour for tetragonal lattice
%
% Syntax
%   ebsd = fill(ebsd)
%
% Input
%  ebsd - @EBSD
%

% generate a regular grid
ext = ebsd.extent;
dx = max(ebsd.unitCell(:,1))-min(ebsd.unitCell(:,1));
dy = max(ebsd.unitCell(:,2))-min(ebsd.unitCell(:,2));
[xgrid,ygrid] = meshgrid(ext(1):dx:ext(2),ext(3):dy:ext(4)); % ygrid runs first
sGrid = size(xgrid);

% detect position within grid
ind = sub2ind(sGrid, 1 + round((ebsd.pos.y - ext(3))/dy), ...
  1 + round((ebsd.pos.x - ext(1))/dx));

ebsd.pos.x = xgrid(:);
ebsd.pos.y = ygrid(:);
ebsd.id = (1:numel(xgrid)).';
clear xgrid ygrid

% the rotations
a = nan(sGrid); b = a; c = a; d = a;
a(ind) = ebsd.rotations.a;
b(ind) = ebsd.rotations.b;
c(ind) = ebsd.rotations.c;
d(ind) = ebsd.rotations.d;
ebsd.rotations = reshape(rotation(quaternion(a,b,c,d)),[],1);
clear a b c d

for fn = fieldnames(ebsd.prop).'
  ebsd.prop.(char(fn)) = ebsd.prop.(char(fn))(ci);
end


% the grainIds
grainId = zeros(sGrid);
if ebsd.hasGrainId, grainId(ind) = ebsd.prop.grainId; end
ebsd.prop.grainId = grainId(:);

% the phaseId
phaseId = zeros(numel(ebsd.id),1);
phaseId(ind) = ebsd.phaseId;
ebsd.phaseId = phaseId;
clear phaseId


