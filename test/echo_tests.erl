-module(echo_tests).
-include_lib("eunit/include/eunit.hrl").


echo_test() ->
	Ping = {test, message},
	Pid = echo:start(),
	Pong = echo:send(Pid, Ping),
	?assertEqual(Ping, Pong).
