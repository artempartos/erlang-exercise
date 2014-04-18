-module(db).
-import(mylist,[filter/2]).
-export([new/0, destroy/1, write/3, delete/2, read/2, values/2]).

new() -> [].

destroy(_Db) -> ok.

write(Db, K, V) ->
	[{K,V}] ++ filter_key(Db, K).

delete(Db, K) ->
	filter_key(Db, K).

read([], _K) -> nil;
read([{K, V}|_T], K) -> V;
read([_H | T], K) -> read(T,K).

filter_key(Db, K) ->
	[{K1,_V} || {K1, _V} <- Db, K1 /= K].

values([], _V) -> [];
values([{K, V} | T], V) -> [K] ++ values(T,V);
values([_H | T], V) -> values(T,V).



