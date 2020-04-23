%%%----------------------------------------------------------------------------
%%% Code seen in learnyousomeerlang.com
%%% in section "Erros and Processes"
%%%----------------------------------------------------------------------------
%%% Module description: monitors
%%%----------------------------------------------------------------------------
%%% Monitors are a special kind of links
%%%     - they are unidirectional
%%%     - they can be stacked
%%%
%%% erlang:monitor/2, where the first argument is the atom process and the other
%%% is a PID. Ex: erlang:monitor(process, spawn(fun() -> timer:sleep(500) end)).
%%% When a monitored process goes down a message is received in the form
%%%     {'DOWN', MonitorReference, process, Pid, Reason}
%%%
%%% spawn_monitor/1-3 spawn a process while monitoring it
%%%
%%%----------------------------------------------------------------------------
%%% start_chat()
%%%     initalize a chat
%%%----------------------------------------------------------------------------
%%% start_chat2()
%%%     initalize a chat with a restarter
%%%----------------------------------------------------------------------------
%%% respond ()
%%%     receives a pid a subject to respond and an opnion from who is speaking
%%%     and send a message responding to it accordingly
%%%----------------------------------------------------------------------------
%%%
%%%
%%%----------------------------------------------------------------------------

-module(monitors).
-export([start_chat/0, start_chat2/0, restarter/0]).
-export([chat/0, respond/3, chat2/0, respond2/2]).

start_chat () -> spawn (?MODULE, chat, []).

respond (Pid, Subject, Opnion) ->
    Pid ! {self (), {Subject, Opnion}},
    receive
        {Pid, Response} -> Response
    after 2000 ->
              timeout
    end.

chat () ->
    receive
        {From, {"Music", "Metal"}} ->
            From ! {self (), "Great!"};
        {From, {"Politics", "Ultra Right"}} ->
            From ! {self (), "That sucks."};
        {From, {_Subject, _Opinion}} ->
            From ! {self (), "Dunno..."}
    end,
    chat ().

start_chat2 () -> spawn(?MODULE, restarter, []).

% WARNING: named process can lead to race conditions
% if there are many process with a same name
restarter () ->
    process_flag (trap_exit, true),
    Pid = spawn_link (?MODULE, chat2, []),
    % register give a process a name
    % whereis(<named_process>) returns PID
    register (chatter, Pid),
    receive
        % not a crash
        {'EXIT', Pid, normal} -> ok;
        % manual termination
        {'EXIT', Pid, shutdown} -> ok;
        % a crash
        {'EXIT', Pid, _Reason} -> restarter ()
    end.

respond2 (Subject, Opnion) ->
    % this line creates a unique value to identify a message
    Ref = make_ref (),
    chatter ! {self (), Ref, {Subject, Opnion}},
    receive
        {Ref, Response} -> Response
    after 2000 ->
              timeout
    end.

chat2 () ->
    receive
        {From, Ref, {"Music", "Metal"}} ->
            From ! {Ref, "Great!"};
        {From, Ref, {"Politics", "Ultra Right"}} ->
            From ! {Ref, "That sucks."};
        {From, Ref, {_Subject, _Opinion}} ->
            From ! {Ref, "Dunno..."}
    end,
    chat2 ().


