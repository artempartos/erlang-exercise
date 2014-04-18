-module(db_tests).
-include_lib("eunit/include/eunit.hrl").


new_test() ->
	?assertEqual([], db:new()).

destroy_test() ->
	Db = db:new(),
	?assertEqual(ok, db:destroy(Db)).

write_test() ->
  Db = db:new(),
  State1 = db:write(Db, k1, v1),
  ?assertEqual([{k1, v1}], State1),

  State2 = db:write(State1, k2, v2),
  ?assertEqual([{k2, v2}, {k1, v1}], State2),

  State3 = db:write(State2, k1, v3),
  ?assertEqual([{k1, v3}, {k2, v2}], State3).

delete_test() ->
  Db = db:new(),
  State1 = db:write(Db, k1, v1),
  ?assertEqual([{k1, v1}], State1),

  State2 = db:write(State1, k2, v2),
  ?assertEqual([{k2, v2}, {k1, v1}], State2),

  State3 = db:delete(State2, k3),
  ?assertEqual([{k2, v2}, {k1, v1}], State2),

  State4 = db:delete(State3, k1),
  ?assertEqual([{k2, v2}], State4).

read_test() ->
  Db = db:new(),
  State1 = db:write(Db, k1, v1),
  ?assertEqual([{k1, v1}], State1),

  State2 = db:write(State1, k2, v2),
  ?assertEqual([{k2, v2}, {k1, v1}], State2),

  Val1 = db:read(State2, k3),
  ?assertEqual({error, keynotexist}, Val1),

  Val2 = db:read(State2, k1),
  ?assertEqual({ok, v1}, Val2).

values_test() ->
  Db = db:new(),
  State1 = db:write(Db, k1, v1),
  ?assertEqual([{k1, v1}], State1),

  State2 = db:write(State1, k2, v2),
  ?assertEqual([{k2, v2}, {k1, v1}], State2),

  State3 = db:write(State2, k3, v2),
  ?assertEqual([{k3,v2},{k2, v2}, {k1, v1}], State3),

  Val1 = db:values(State3, v2),
  ?assertEqual([k3,k2], Val1),

  Val2 = db:values(State3, v1),
  ?assertEqual([k1], Val2),

  Val3 = db:values(State3, v3),
  ?assertEqual([], Val3).