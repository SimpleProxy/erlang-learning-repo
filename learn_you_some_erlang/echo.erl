-module(echo).
-export([go/0, loop/0]).

%% Sample code from Erlang Express Course 6/13
%% By Simon Thompson

%% go starts a process, send it a message and waits for the answer
go() ->
    % spawn takes 3 arguments
    % the module name, the function to spawn and its arguments
    Pid = spawn(?MODULE, loop, []),
    Pid ! {self(), hello}, % the atom hello is the messege
    receive
        {Pid, Msg} ->
            io:format("~w~n",[Msg])
    end,
    Pid ! stop.

%% loop, when started, waits for a message
%% when it is received loop send it back and call it self
loop() ->
    receive
        {From, Msg} ->
            From ! {self(), Msg},
            loop();
        stop ->
            true
    end.
