function r = mtimes(a,b,varargin)
% r = a * b

% multiplication with -1 -> inversion
if isnumeric(a) 
  
  if size(a,2) == size(b,1)
    % this is kind of a matrix product weights times rotations followed by
    % normalization as an approximation of the weighted mean
    
    r = b;
    r.a = a * b.a;
    r.b = a * b.b;
    r.c = a * b.c;
    r.d = a * b.d;
    r.i = a * b.i;
    
    r = r.normalize;
    r.i = r.i>0.5;
    
  else
  
    assert(all(abs(a(:))==1),'Rotations can be multiplied only by 1 or -1');
    tmp = rotation.id(size(a));
    tmp.i = (1-a)./2;
    r = tmp;

  end
  
elseif isa(b,'vector3d')
  
  % apply rotation
  r = rotate_outer(b,a);
  
elseif isa(b,'quaternion')

  r = mtimes@quaternion(a,b,varargin{:});
 
elseif isa(b,'grain2d')

  r = rotate(b,a);

elseif isa(b,'grain3d')

  r = rotate(b,a);
else
  
  r = rotate_outer(b,a);
  
end
    
end
