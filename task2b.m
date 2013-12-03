% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} = } task2b (@var{k_x}, @var{v_x}, @var{q_x}, @var{f_x}, @var{mu_0}, @var{mu_1}, @var{xs} )
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
% This method is using splitting v(x) into two separate functions: v^- and v^+.
%
% Arguements:
% @table @samp
% @item @var{k_x, v_x, q_x, f_x, mu_0, mu_1}
% corresponding functions from problem statement
%
% @item @var{xs}
% All x in w_h.
%
% @end table
%
% Returns:
% @table @samp
% @item @var{y}
% Vector of y coordinates.
%
% @end table
function [y] = task2b(k_x, v_x, q_x, f_x, mu_0, mu_1, xs)
    h = max( diff( xs ) );

    sub_x = xs(2:end-1); % x without edges

    N = length(xs);

    ks = k_x( sub_x );
    vs = v_x( sub_x );
    qs = q_x( sub_x );
    fs = f_x( sub_x );

    % magic goes here (v = v^- + v^+)
    v_plus = 0.5 * (vs + abs(vs));
    v_minus = 0.5 * (vs - abs(vs));

% k_{i-0.5} = ( 1/h * int_{x_{i-1}}^{x_i} dx/k(x) )
    k_minus_s = k_x( sub_x .- (h / 2) );
    k_plus_s = k_x( sub_x .+ (h / 2) );

    % near y_{i+1}
    As = k_plus_s ./ (h^2) .+ (v_plus ./ ks ) .* k_plus_s / h;
    As = -As;
    % near y_i
    Cs = -qs .- ((k_minus_s + k_plus_s) ./ (h^2)) .+ (v_minus ./ ks) .* k_minus_s / h .- (v_plus ./ ks) .* k_plus_s / h;
    Cs = -Cs;
    % near y_{i-1}
    Bs = k_minus_s ./ (h^2) .- (v_minus ./ ks) .* k_minus_s / h;
    Bs = -Bs;

    As = [0, As, 0];
    Cs = [1, Cs, 1];
    Bs = [0, Bs, 0];

    Fs = [ mu_0, fs, mu_1 ];

    y = tridiagonal( As, Bs, Cs, Fs );
endfunction
