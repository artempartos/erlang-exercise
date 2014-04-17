-module(mylist_test).
-include_lib("eunit/include/eunit.hrl").


map_test() -> 
	?assertEqual([2,6,10], mylist:map(fun(X) -> X * 2 end, [1,3,5])).

map_with_origin_test() -> 
	F = fun(X) -> X * 2 end,
	X = [1,3,5],
	?assertEqual(lists:map(F,X), mylist:map(F,X)).	
	