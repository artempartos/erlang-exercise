-module(mylist).
-export([map/2]).

map(_F,[]) -> ([]);
map(F, [T|H]) -> ([F(T) | map(F, H)]).



