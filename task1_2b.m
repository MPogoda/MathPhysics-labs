% -*- texinfo -*-
% @deftypefn {Function File} {} task1_2a (@var{q_x}, @var{k, @var{beta}, @var{gamma1}, @var{gamma2}, @var{f_x}, @var{l}, @var{N} = 100)
% @deftypefnx {Function File} {[@var{x}, @var{y}] = } task1_1 (@dots{})
% Find solution for problem:
%  $ k*u''(x) - q(x) * u(x) = -f(x) $
%  $ -k * u'(0) + beta*u(0) = gamma1 $
%  $ u(l) = gamma2 $
%  $ 0 < x < l $
%
% Arguements:
% @table @samp
% @item @var{q_x, k, beta, gamma1, gamma2, f_x}
% corresponding functions from problem statement
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
function [x, y] = task1_2b( q_x, k, beta, gamma1, gamma2, f_x, l, n = 100)

    h = l/n;
    x = 0:h:l;

    N = length(x);

    D = [k/h+beta+h*q_x(x(1))/2, -2*k/(h^2) - q_x( x(2:end-1) ), 1];

    B = [0, k/(h^2) * ones( 1, N-2 ), 0];

    A = [-k/h, k/(h^2) * ones(1, N-2), 0];

    % Tridiagonal matrix algorithm
    f = [gamma1 + h*f_x(x(1)), -f_x( x( 2:end-1)), gamma2];

    a = zeros(1,N);
    b = zeros(1,N);
    a(1) = -A(1)/D(1);
    b(1) = f(1)/D(1);
    for i = 1:(N-1)
        a(i+1) = -A(i) / (D(i) + B(i)*a(i));
        b(i+1) = (-B(i)*b(i)+f(i)) / (D(i)+B(i)*a(i));
    endfor;

    y = zeros(1,N);
    y(N) = (-B(N)*b(N)+f(N)) / (D(N)+B(N)*a(N));

    for i=N-1:-1:1
        y(i) = a(i+1)*y(i+1)+b(i+1);
    endfor;
endfunction
