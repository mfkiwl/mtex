function v = discreteSample(S2Fun,n,varargin)
% takes a random sample of n directions from S2Fun
%
% Syntax
%   v = discreteSample(S2Fun,n)
%
% Input
%  sF - @S2Fun
%  n - number of points
%
% Output
%  v -  @vector3d
%    -  @Miller in case of S2Fun is of type @S2FunHarmonicSym
%

res = get_option(varargin,'resolution',0.5*degree);

% take global random samples at grid points
S2G = equispacedS2Grid('resolution',res);
d = eval(S2Fun,S2G);

% take global random samples
d(d<0) = 0;   
v = S2G(discretesample(d,n));

% some local distortions
v = rotation.rand(n,'maxAngle',res*1.5) .* v(:);

% if there is a symmetry, return a Miller
if isa(S2Fun,'S2FunHarmonicSym'), v = Miller(v,S2Fun.CS); end

% set antipodal if function is antipodal
if S2Fun.antipodal == 1; v.antipodal = 1; end
