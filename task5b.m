% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} = } task2a (@var{k_x}, @var{v_x}, @var{q_x}, @var{f_x}, @var{mu_0}, @var{mu_1}, @var{xs} )
% @end deftypefn
%
% @end table
% Стойкая при k_h \in [0; 1]
function [z] = task5b(mu, u0, gx0, gx1, g0y, g1y, xs, ys, ts )
    h1 = xs(2) - xs(1);
    h2 = ys(2) - ys(1);
    tau = ts(2) - ts(1);

    M = length( ts );
    N1 = length( xs );
    N2 = length( ys );

    z = zeros( N1, N2, M );
    z( :, :, 1 ) = u0( xs, ys);
    z( 1, :, : ) = g0y( ys, ts);
    z( end, :, :) = g1y( ys, ts);
    z( :, 1, :) = gx0( xs, ts);
    z( :, end, :) = gx1( xs, ts);

    k = mu * tau / 2;

    L2 = @( zs ) (mu/(h2^2))*(zs(3:end) - 2*zs(2:end-1) + zs(1:end-2));

    for j = 1:M-1
        % tau * k^(j+1/2)_k / 2;
        ztmp = zeros( N1, N2 );
        ztmp( 1, 2:end-1 ) = (z( 1, 2:end-1, j ) + z(1, 2:end-1, j+1))/2 .- (tau/4)*L2( z(1,:,j+1)-z(1,:,j));
        ztmp( end, 2:end-1 ) = (z( end, 2:end-1, j ) + z( end, 2:end-1, j+1))/2 -(tau/4)*L2( z(end, :,j+1)-z(end,:,j));
        for n = 2:N2-1
            % near y_{i+1}
            As = ones(1, N1 - 2 ) .* k / (h1^2);
            As = [0, -As, 0];

            % near y_i
            Cs = ones(1, N1 - 2 ) .* (1 + 2 * k /(h1^2));
            Cs = [1, Cs, 1];

            % near y_{i-1}
            Bs = ones(1, N1 - 2) .* k / (h1^2);
            Bs = [0, -Bs, 0];

            Fs = z( 2:end-1, n, j ) .+ (k / (h2^2)).*( z(2:end-1, n-1, j) .- 2 .* z(2:end-1, n, j) .+ z(2:end-1, n+1,j));
            Fs = [ztmp(1, n), Fs', ztmp(end, n)];

            ztmp(:, n) = tridiagonal( As, Bs, Cs, Fs );
        endfor

        for m = 2:N1-1
            % near y_{i+1}
            As = ones(1, N2 - 2 ) .* k / (h2^2);
            As = [0, -As, 0];

            % near y_i
            Cs = ones(1, N2 - 2 ) .* (1 + 2 * k /(h2^2));
            Cs = [1, Cs, 1];

            % near y_{i-1}
            Bs = ones(1, N2 - 2) .* k / (h2^2);
            Bs = [0, -Bs, 0];

            Fs = ztmp( m, 2:end-1 ) .+ (k / (h1^2)) .* ( ztmp(m-1, 2:end-1) - 2 .* ztmp(m, 2:end-1) .+ ztmp(m+1,2:end-1) );
            Fs = [z(m,1,j+1), Fs, z(m, end,j+1)];

            z(m, :, j+1) = tridiagonal( As, Bs, Cs, Fs );
        endfor
    endfor
endfunction
