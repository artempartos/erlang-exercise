-module(db).
-import(mylist,[filter/2]).
-export([new/0, destroy/1, write/3, delete/2, read/2, values/2]).

new() -> [].

destroy(_Db) -> ok.

write(Db, K, V) -> [{K,V} | filter_key(Db, K)].

delete(Db, K) -> filter_key(Db, K).

read([], _K) -> {error, keynotexist};
read([{K, V}|_T], K) -> {ok, V};
read([_ | T], K) -> read(T,K).

filter_key(Db, K) -> [{K1,_V} || {K1, _V} <- Db, K1 /= K].

values([], _V) -> [];
values([{K, V} | T], V) -> [K | values(T,V)];
values([_ | T], V) -> values(T,V).



