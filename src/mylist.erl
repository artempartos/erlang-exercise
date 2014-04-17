-module(mylist).
-export([map/2, filter/2, flatten/1, reduce/3]).

map(_F,[]) -> ([]);
map(F, [H|T]) -> ([F(H) | map(F, T)]).

filter(_F, []) -> [];
filter(F, [H|T]) -> 
	case F(H) of
		true -> [H | filter(F,T)];
		false -> filter(F,T)
	end.

flatten([]) -> [];
flatten([H|T]) -> flatten(H) ++ flatten(T);
flatten(El) -> [El].

reduce(_F, Ac, []) -> Ac;
reduce(F, Ac, [H|T]) -> reduce(F, F(H, Ac), T).