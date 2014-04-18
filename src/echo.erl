-module(echo).
-export([send/2, start/0]).

start() -> spawn(fun loop/0).

send(Pid, What) ->
    Pid ! {self(), What},
    receive
		Response ->
			Response
    end.

loop() ->
    receive
	{From, Message} ->
	    From ! Message,
	    loop()
    end.