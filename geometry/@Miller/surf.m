function varargout = surf(m,cdata,varargin)
%
% Syntax
%   surf(m,cdata)
%
% Input
%
% Output
%
% Options
%
% See also
%

[varargout{1:nargout}] = surf@vector3d(m,cdata,varargin{:},m.CS,m.CS.how2plot);
