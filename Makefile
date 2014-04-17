REBAR="rebar"

clean:
	$(REBAR) clean

compile:
	$(REBAR) compile

run: 
	erl -pa ebin

test: compile 
	$(REBAR) eu