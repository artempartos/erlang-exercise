-module(ring).
-export([start/1, loop/2, send/3]).

start(Count) -> spawn(ring, loop,[Count-1, self()]).

send(Pid, Msg, Count) ->
	Pid ! {message, Msg, Count, self()},
	wait_message(Pid, self()).

loop(0, FirstPid) ->
	wait_message(FirstPid, FirstPid);

loop(Count, FirstPid) ->
	Pid = spawn(ring, loop,[Count-1, FirstPid]),
	io:format("~p;", [Pid]),
    wait_message(Pid, FirstPid).

wait_message(Pid, FirstPid) ->
	receive
		{final, M, EndPid} ->
			io:format("message ~p over on ~p~n", [M, EndPid]),
			EndPid;
		{message, Msg, 0, FirstPid} ->
			FirstPid ! {final, Msg, self()},
			wait_message(Pid, FirstPid);
	    {message, Msg, Count, FirstPid} ->
			Pid ! {message, Msg, Count - 1, FirstPid},
		    wait_message(Pid, FirstPid)
    end.