-module(phone).
-export([new/0, on_hook/0, up_phone/1, call/1, say/1, down/1]).

new() -> 
	io:format("новый телефон, с лежачей трубкой~n"),
	spawn(?MODULE, on_hook,[]).

up_phone(Pid) -> 
	Pid ! {up, self()},
	receive
		{ok, idle} ->
			{ok, idle}
	after 500 ->
		{error, timeout}
	end.

call(Pid) -> 
    Pid ! {call, self()},
    receive
        {ok, connected} ->
            {ok, connected}
    after 500 ->
        {error, timeout}
    end.

say(Pid) -> 
    Pid ! {say, self()},
    receive
        {ok, said} ->
            {ok, said}
    after 500 ->
        {error, timeout}
    end.    

down(Pid) -> 
    Pid ! {down, self()},
    receive
        {ok, on_hook} ->
            {ok, on_hook}
    after 500 ->
        {error, timeout}
    end.

on_hook() ->
    receive
	{up, Pid} ->
		Pid ! {ok, idle},
		io:format("трубку подняли~n"),
	    idle();
    _ -> 
        on_hook()
    end.

idle() ->
    receive
        {down, Pid} ->
            Pid ! {ok, on_hook},
            io:format("трубку положили~n"),
            on_hook();
        {call, Pid} ->
            Pid ! {ok, connected},
            io:format("позвонили и соединили~n"),
            connect(0);
	    _ ->
	        idle()
    end.	

connect(2) -> 
    receive
        {down, Pid} ->
            Pid ! {ok, on_hook},
            io:format("трубку положили~n"),
            on_hook();
        {say, Pid} ->
            Pid ! {ok, said},
            io:format("сказали фразу~n"),
            io:format("трубку положили~n"),
            on_hook();
        _ ->
            connect(2)
    end;

connect(CountMessage) ->
    receive
        {down, Pid} ->
            Pid ! {ok, on_hook},
            io:format("трубку положили~n"),
            on_hook();
        {say, Pid} ->
            Pid ! {ok, said},
            io:format("сказали фразу~n"),
            connect(CountMessage + 1);
        _ ->
            connect(CountMessage)
    end.      
