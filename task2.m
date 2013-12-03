% -*- texinfo -*-
% @deftypefn {Function File} {} task2 (@var{k_x}, @var{v_x}, @var{q_x}, @var{f_x}, @var{mu_0}, @var{mu_1}, @var{l}, @var{N} = 100)
% @deftypefnx {Function File} {[@var{x}, @var{y}] = } task2 (@dots{})
% Find solution for problem:
%  $ (k(x) * u_x)_x + v(x) * u_x - q(x) * u = -f(x) $
%  $ k(x) >= c_1 > 0 $
%  $ q(x) >= 0 $
%  $ | v(x) | <= c_2$
%  $ c1, c2 > 0 $
%  $ u( 0 ) = mu_0 $
%  $ u( l ) = mu_1 $
%  $ 0 < x < l $
%
% Arguements:
% @table @samp
% @item @var{k_x, v_x, q_x, f_x, mu_0, mu_1}
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
function [x, y] = task2(k_x, v_x, q_x, f_x, mu_0, mu_1, l, n = 100)

    h = l/n;
    x = 0:h:l;
    sub_x = x(2:end-1); % x without edges

    N = length(x);

    ks = k_x( sub_x );
    vs = v_x( sub_x );
    qs = q_x( sub_x );
    fs = f_x( sub_x );

% k_{i-0.5} = ( 1/h * int_{x_{i-1}}^{x_i} dx/k(x) )
    k_minus_s = k_x( sub_x .- (h / 2) );
    k_plus_s = k_x( sub_x .+ (h / 2) );

    Bs = (-vs ./ (2 * h)) .+ (k_minus_s ./ (h^2));
    Cs = qs .+ ((k_minus_s + k_plus_s) ./ (h^2));
    As = (vs ./ (2 * h)) + (k_plus_s ./ (h^2));

    As = -[0, As, 0];
    Cs = [1, Cs, 1];
    Bs = -[0, Bs, 0];

    Fs = [ mu_0, fs, mu_1 ];

%    D = [k/h+beta, -2*k/(h^2) - q_x( x(2:end-1) ), 1];
%
%    B = [0, k/(h^2) * ones( 1, N-2 ), 0];
%
%    A = [-k/h, k/(h^2) * ones(1, N-2), 0];
%    f = [gamma1, -f_x( x( 2:end-1)), gamma2];

    % Tridiagonal matrix algorithm

    a = zeros(1,N+1);
    b = zeros(1,N+1);
    a(1) = -As(1)/Cs(1);
    b(1) = Fs(1)/Cs(1);
    for i = 1:(N-1)
        a(i+1) = -As(i) / (Cs(i) + Bs(i)*a(i));
        b(i+1) = (-Bs(i)*b(i)+Fs(i)) / (Cs(i)+Bs(i)*a(i));
    endfor;

    y = zeros(1,N);
    y(N) = (-Bs(N)*b(N)+Fs(N)) / (Cs(N)+Bs(N)*a(N));

    for i=N-1:-1:1
        y(i) = a(i+1)*y(i+1)+b(i+1);
    endfor;
endfunction
