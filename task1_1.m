% -*- texinfo -*-
% @deftypefn {Function File} {} task1_1 (@var{fcn}, @var{l)
% @deftypefnx {Function File} {} task1_1 (@var{fcn}, @var{l}, @var{N})
% @deftypefnx {Function File} {[@var{x}, @var{y}] = } task1_1 (@var{fcn}, @dots{})
% Solve differential equation $u'' = -f; u(0) = u(l) = 0$ using Fourier method.
%
% Arguements:
% @table @samp
% @item @var{fcn}
% function in right side of equation
%
% @item @var{l}
% Right edge of interval
%
% @item @var{N}
% Number of sub-intervals.
%
% @end table
%
% Returns:
% @table @samp
% @item @var{x}
% Vector of x coordinates.
%
% @item @var{y}
% Vector of y coordinates.
%
% @end table
function [x, y] = task1_1( FCN, l, N = 1500 )
    % Define step
    h = l/N;
    % Vector of xs
    x = 0:h:l;
    % Helper vector
    indices = (1:length(x)-2);

    % Magic goes here.
    Ls = ((2/h)^2) .* (sin( (0.5 * pi * h * indices / l ) ) ).^2;
    Mu_xs = sqrt(2/l) .* sin( pi * indices' * x(2:end-1) ./ l );
    Fs = FCN( x(2:end-1) ) * Mu_xs * h;
    Cs = Fs ./ Ls;

    y = [0, Cs * Mu_xs, 0 ];

    plot( x, y );
endfunction
