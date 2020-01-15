-module(concurrent).
-export([start/0, main/1, stop/1, sum/2]).

% Spawn the main function, returns its PID
start() ->
    spawn(?MODULE, main, [0]).

% In this example the main just add is internal value to the on it receives
main(Number) ->
    receive
        {Pid, stop} ->
            Pid ! ok;
        {Pid, N} ->
            NN = N + Number,
            Pid ! NN,
            main(NN)
    end.

% Take the main's PID and send a message with a number to it 
sum(Pid, Number) ->
    Self = self(),
    Pid ! {Self, Number},
    receive
        Result -> Result
    end.

% Send a stop signal to PID (in the case, the main function)
stop(Pid) ->
    Pid ! {self(), stop},
    receive
        _ -> ok
    end.
