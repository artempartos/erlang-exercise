-module(mylist_tests).
-include_lib("eunit/include/eunit.hrl").


map_test() -> 
	?assertEqual([2,6,10], mylist:map(fun(X) -> X * 2 end, [1,3,5])).

map_with_origin_test() -> 
	F = fun(X) -> X * 3 end,
	X = [2,3,5],
	?assertEqual(lists:map(F,X), mylist:map(F,X)).	

filter_test() -> 
	?assertEqual([2,4], mylist:filter(fun(X) -> X rem 2 == 0 end, [1,2,3,4,5])).

filter_with_origin_test() -> 
	F = fun(X) -> X rem 2 == 0 end,
	X = [1,2,3,4,5],
	?assertEqual(lists:filter(F,X), mylist:filter(F,X)).	

flatten_test() ->
	?assertEqual([1,2,3,4,5,6,7], mylist:flatten([1,[2,3],[],4,[5,[6,7]]])).		

flatten_with_origin_test() -> 
	X = [1,[2,3],[],4,[5,[6,7]]],
	?assertEqual(lists:flatten(X), mylist:flatten(X)).			

reduce_test() ->
	?assertEqual(15, mylist:reduce(fun(X, Sum) -> X + Sum end, 0, [1,2,3,4,5] )).			

reduce_with_origin_test() -> 
	F =  fun(X, Sum) -> X + Sum end,
	X = [1,2,3,4,5],
	?assertEqual(lists:foldl(F, 0, X), mylist:reduce(F,0,X)).			

quick_sort_test() -> 
	?assertEqual([1,2,4,8,11,12,34,54,90], mylist:quick_sort([34,12,54,1,4,11,8,2,90])).				




	