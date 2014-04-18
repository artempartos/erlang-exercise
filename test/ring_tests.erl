-module(ring_tests).
-include_lib("eunit/include/eunit.hrl").

ring_start_test() ->
	Count = 30,
	Pid = ring:start(Count),
	ExitPid = ring:send(Pid, "my_message", (Count + 1) * 10),
	?assertEqual(Pid, ExitPid).