% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} = } task2a (@var{k_x}, @var{v_x}, @var{q_x}, @var{f_x}, @var{mu_0}, @var{mu_1}, @var{xs} )
% @end deftypefn
%
% @end table
% (24) --- НЕОбычная неявная схема с центральной производной
% Стойкая
function [y] = task3e(a, g, mu, xs, ts )
    h = xs(2) - xs(1);
    tau = ts(2) - ts(1);

    M = length( ts );
    N = length( xs );

    y = zeros( M, N);
    y( 1, : ) = g( xs );
    y( :, 1 ) = mu( ts );

    k_h = a * tau / h

    for j = 1:M-1

        % near y_{i+1}
        As = 0.25 * k_h * ones( 1, N - 2 );
        As = [0, As, 0];
        % near y_i
        Cs = [ones( 1, N - 1 ), (1 + k_h) ];
        % near y_{i-1}
        Bs = -0.25 * k_h * ones( 1, N - 2 );
        Bs = [0, Bs, -k_h ];

        Fs = y( j, 2:end-1) .- 0.25 * k_h .* (y(j, 3:end) - y(j, 1:end-2) );
        Fs = [y( j + 1, 1 ), Fs, y(j, N) ];

        y( j + 1, 1:end ) =  tridiagonal( As, Bs, Cs, Fs );
    endfor
endfunction
