function h = quiver(grains,dir,varargin)
% plot directions at grain centers
%
% Syntax
%   quiver(grains,dir,'color','r')
%
%
% Input
%  grains - @grain3d
%  dir    - @vector3d
%
% Options
%  antipodal   - plot directions or axes
%  maxHeadSize - size of the arrow
%

pos = grains.centroid;

if ~check_option(varargin,'noScaling')
  
  dir = dir * get_option(varargin,'autoScaleFactor',1);
  varargin = ['linewidth',1,'autoScale','off',varargin];
else
  varargin = ['linewidth',1,'autoScaleFactor',0.25,varargin];
end

% get color
c = get_option(varargin,'color');

if check_option(varargin,'antipodal') || dir.antipodal

  varargin = [{'MaxHeadSize',0},varargin];
  
  % double color;
  if isnumeric(c) && length(c) == length(dir), c = [c;c]; end

  pos = [pos;pos];
  dir = [dir(:);-dir(:)];
    
end
 
  
if size(c,1) == length(dir)
  % if different color are given - separate them

  [c,~,id] = unique(c,'rows');
  varargin = delete_option(varargin,'color',1);

  for i = 2:size(c,1)
    hold on
    h(i) = optiondraw(quiver3(pos.x(id == i),pos.y(id == i),pos.z(id == i),...
      dir.x(id == i),dir.y(id == i),dir.z(id == i)),varargin{:},'color',c(i,:));  %#ok<AGROW>
  end

else
  
  h = optiondraw(quiver3(pos.x,pos.y,pos.z,dir.x,dir.y,dir.z),varargin{:});

end

if nargout == 0, clear h; end

end
