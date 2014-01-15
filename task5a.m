% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} = } task2a (@var{k_x}, @var{v_x}, @var{q_x}, @var{f_x}, @var{mu_0}, @var{mu_1}, @var{xs} )
% @end deftypefn
%
% @end table
% Стойкая при k_h \in [0; 1]
function [z] = task5a(mu, u0, gx0, gx1, g0y, g1y, xs, ys, ts )
    h1 = xs(2) - xs(1);
    h2 = ys(2) - ys(1);
    tau = ts(2) - ts(1);

    M = length( ts );
    N1 = length( xs );
    N2 = length( ys );

    z = zeros( N1, N2, M );
    z( :, :, 1 ) = u0( xs, ys);
    z( 1, :, : ) = g0y( ys, ts);
    z( N1, :, :) = g1y( ys, ts);
    z( :, 1, :) = gx0( xs, ts);
    z( :, N2, :) = gx1( xs, ts);

    for j = 1:M-1
        l1y = z( 1:end-2, 2:end-1, j ) .- 2 .* z( 2:end-1, 2:end-1, j ) .+ z( 3:end, 2:end-1, j );
        l1y /= h1^2;

        l2y = z( 2:end-1, 1:end-2, j ) .- 2 .* z( 2:end-1, 2:end-1, j ) .+ z( 2:end-1, 3:end, j );
        l2y /= h2^2;

        z( 2:end-1, 2:end-1, j+1 ) = z( 2:end-1, 2:end-1, j) .+ tau * mu .* ( l1y .+ l2y );
    endfor
endfunction
