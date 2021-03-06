% -*- texinfo -*-
% @deftypefn {Function File} {[@var{y}] = } task3_real(@var{a}, @var{g}, @var{mu}, @var{xs}, @var{ts} )
% @end deftypefn
%
% @end table
% ts should be vertical
function [y] = task3_real( a, g, mu, xs, ts )
    N = length( xs );
    M = length( ts );
    [xs,ts] = meshgrid(xs, ts);

    gs = g( xs .- a .* ts );
    mus = mu( ts .- ( xs ./ a ) );

    mask = (xs >= (a .* ts ));

    y = mask .* gs .+ (1 .- mask ) .* mus;
endfunction;
