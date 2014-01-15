% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} = } task2a (@var{k_x}, @var{v_x}, @var{q_x}, @var{f_x}, @var{mu_0}, @var{mu_1}, @var{xs} )
% @end deftypefn
%
% @end table
% Стойкая при k_h \in [0; 1]
function [y] = task4b(v, mu, k, u0, g0, g1, xs, ts )
    h = xs(2) - xs(1);
    tau = ts(2) - ts(1);

    M = length( ts );
    N = length( xs );

    y = zeros( M, N);
    y( 1, : ) = u0( xs );
    y( :, 1 ) = g0( ts );
    y( :, N ) = g1( ts );

    k_h = v * tau / h;
    k_p = 2 * mu * tau / (h^2);

    for j = 1:M-1
        % tau * k^(j+1/2)_k / 2;
        ks = tau * k( xs(2:end-1), ts(j)+(tau/2) ) / 2;

        % near y_{i+1}
        As = ones( 1, N - 2 ) .* (k_h - k_p)/4;
        #As = 0.25 * k_h * ones( 1, N - 2 );
        As = [0, As, 0];
        % near y_i
        Cs = (1 + k_p/2) .+ ks;
        Cs = [1, Cs, 1];
        % near y_{i-1}
        Bs = ones(1, N - 2 ) .* (-k_h - k_p) / 4;
        Bs = [0, Bs, 0];

        Fs = y(j, 2:end-1 ) .* ((1 - k_p/2) .- ks) .+ y(j, 3:end) .*(k_p-k_h)/4 .+ y(j, 1:end-2) .*(k_h+k_p)/4;
        Fs = [y( j + 1, 1 ), Fs, y(j + 1, N) ];

        y( j + 1, 1:end ) =  tridiagonal( As, Bs, Cs, Fs );
    endfor
endfunction
