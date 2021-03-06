-module(phone_tests).
-include_lib("eunit/include/eunit.hrl").

phone_start_test() ->
	Pid = phone:new(),
    ?assertEqual({ok, idle}, phone:up_phone(Pid)),
    ?assertEqual({ok, unprocessable}, phone:up_phone(Pid)),
    ?assertEqual({ok, connected}, phone:call(Pid)),
    ?assertEqual({ok, unprocessable}, phone:call(Pid)),
    ?assertEqual({ok, said}, phone:say(Pid)),
    ?assertEqual({ok, said}, phone:say(Pid)),
    ?assertEqual({ok, said}, phone:say(Pid)),
    ?assertEqual({ok, unprocessable}, phone:say(Pid)).
    % ?assertEqual({ok, timeout}, phone:connect(Pid)).
