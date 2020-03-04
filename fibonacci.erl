%%% TODO: move tail recursive fibonnaci to tailrec.erl module
-module(fibonacci).
-export([start/0,main/0, stop/1, calc/2, fibonacci/1]).

% Helper function to the tail recursive fibonacci
fibonacci(Accumulator) -> fibonacci(1, 1, Accumulator).

% Tail recursive fibonacci
fibonacci(_, _, Accumulator) when Accumulator < 0 -> undefined;
fibonacci(_, Nth, 0) -> {ok, Nth};
fibonacci(_, Nth, 1) -> {ok, Nth};
fibonacci(Prev2, Prev1, Accumulator) ->
    fibonacci(Prev1, Prev1 + Prev2, Accumulator - 1).

% Spawn process function. Returns a PID
start() ->
    spawn(?MODULE, main,[]).

% Send a stop message to Pid
stop(Pid) ->
    Pid ! {self(), stop},
    receive
        _ -> ok
    end.

% Receives 2 arguments, a PID and a number
% Send the number to the PID requested and listens to the result
calc(Pid, Number) ->
    Self  = self(),
    Pid ! {Self, Number},
    receive
        Return -> Return
    end.

% Main function. Listen to signals
% Either to stop working or to calculate the nth number in fibonacci sequence
main() ->
    receive
        {Pid, stop} ->
            Pid ! ok;
        {Pid, Number} ->
            Pid ! fibonacci(Number),
            main()
    end.

