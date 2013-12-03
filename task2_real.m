% -*- texinfo -*-
% @deftypefn {Function File} {[@var{y}] = } task2_real(@var{k}, @var{v}, @var{q}, @var{mu_0}, @var{mu_1}, @var{xs} )
% Find solution for problem:
%  $ k * u_xx + v * u_x - q * u = 0 $
%  $ k > 0 $
%  $ q >= 0 $
%  $ | v(x) | <= c_2$
%  $ c1, c2 > 0 $
%  $ u( 0 ) = mu_0 $
%  $ u( l ) = mu_1 $
%  $ 0 < x < l $
%
% Arguements:
% @table @samp
% @item @var{k, v, q, mu_0, mu_1}
% corresponding constants from problem statement.
%
% @item @var{xs}
% All x in w_h.
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
function [y] = task2_real(k, v, q, mu_0, mu_1, xs)
    b = v/(2*k);
    a = sqrt( b^2 + (q/k));

    left_e = e .^ ( (-b + a) .* xs);
    right_e = e .^ ( (-b - a) .* xs);

    % c_1 + c_2 = mu_0
    % c_1 * left_e( end ) + c_2 * right_e( end ) = mu_1
    A = [ 1, 1; left_e( end ), right_e( end ) ];
    mu_s = [mu_0; mu_1];
    c = pinv(A) * mu_s;

    y = c(1) .* left_e .+ c(2) .* right_e;
endfunction;
