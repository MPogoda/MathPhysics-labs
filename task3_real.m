% -*- texinfo -*-
% @deftypefn {Function File} {[@var{y}] = } task3_real(@var{a}, @var{g}, @var{mu}, @var{xs}, @var{ts} )
% @end deftypefn
%
% @end table
function [y] = task3_real( a, g, mu, xs, ts )
    gs = g( xs .- a .* ts );
    mus = mu( t .- ( x ./ a ) );

    y = (xs >= (a .* ts)) * gs   +   ( xs < (a .* ts)) * mus;
endfunction;
