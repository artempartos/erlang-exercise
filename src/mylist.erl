-module(mylist).
-export([map/2, filter/2, flatten/1, reduce/3, quick_sort/1]).

map(_F,[]) -> ([]);
map(F, [H|T]) -> ([F(H) | map(F, T)]).

filter(_F, []) -> [];
filter(F, S) -> 
	[X || X <- S, F(X)].

flatten([]) -> [];
flatten([H|T]) -> flatten(H) ++ flatten(T);
flatten(El) -> [El].

reduce(_F, Ac, []) -> Ac;
reduce(F, Ac, [H|T]) -> reduce(F, F(H, Ac), T).

quick_sort([]) -> [];
quick_sort([H|T]) -> 
	quick_sort([X || X <- T, X =< H]) ++ [H] ++ quick_sort([X || X <- T, X > H]).