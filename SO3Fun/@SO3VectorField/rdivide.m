function SO3VF = rdivide(SO3VF1, SO3VF2)
% overloads |SO3VF1 ./ SO3VF2|
%
% Syntax
%   SO3VF = SO3VF1 ./ SO3VF2
%   SO3VF = SO3VF1 ./ a
%   SO3VF = a ./ SO3VF2
%   SO3VF = SO3F .* SO3VF1
%   SO3VF = SO3VF1 .* SO3F
%
% Input
%  SO3VF1, SO3VF2 - @SO3VectorField
%  a - double, @vector3d
%  SO3F - @SO3Fun
%
% Output
%  SO3VF - @SO3VectorField
%

if isnumeric(SO3VF1)
  SO3VF = SO3VectorFieldHandle(@(rot) SO3VF1./ SO3VF2.eval(rot),SO3VF2.SRight,SO3VF2.SLeft,SO3VF2.tangentSpace);
  return
end
if isa(SO3VF2,'SO3Fun')   % prevent quadrature in case of SO3FunHarmonic
  SO3VF = SO3VectorFieldHandle(@(rot) SO3VF1.eval(rot)./ SO3VF2.eval(rot),SO3VF2.SRight,SO3VF2.SLeft,SO3VF2.tangentSpace);
  return
end
SO3VF = times(SO3VF1,1./SO3VF2);

end
