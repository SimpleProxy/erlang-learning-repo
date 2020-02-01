%%%------------------------------------------------------------------
%%% Description module state
%%%------------------------------------------------------------------
%%% Concepts comprehension
%%% Messsge passing module similar to concurrent.erl
%%%------------------------------------------------------------------
%%% init()
%%%     just spawns the main loop
%%%------------------------------------------------------------------
%%% main_loop(State)
%%%     keep its own state and waits for a message to either
%%%     store a new one or take a past one
%%%------------------------------------------------------------------
%%% store(Pid, State)
%%%     send a message to the pid Pid asking it to store the state
%%%     State and then waits for the answer.
%%%------------------------------------------------------------------
%%% take(Pid, State)
%%%     send a message to the pid Pid asking it for the state State
%%%     and the waits for the answer.
%%%------------------------------------------------------------------
%%% stop(Pid)
%%%     send a message to the pid Pid asking it to stop its work.
%%%------------------------------------------------------------------

-module(state).
-export([init/0, main_loop/1]).
-export([store/2, take/2, stop/1]).

init() ->
    spawn(?MODULE, main_loop,[[]]).

main_loop(StoredState) ->
    receive
        {Pid, stop} ->
            Pid ! ok;
        {Pid, {store, NewState}} ->
            Pid ! {self(), {ok, stored}},
            main_loop([NewState | StoredState]);
        {Pid, {take, State}} ->
            case lists:member(State, StoredState) of
                true ->
                    Pid ! {self(), {ok, State}},
                    main_loop(lists:delete(State, StoredState));
                false ->
                    Pid ! {self(), not_found},
                    main_loop(StoredState)
            end
    end.

store(Pid, State) ->
    Pid ! {self(), {store, State}},
    receive
        {Pid, Msg} -> Msg
    after 2000 -> timeout
    end.

take(Pid, State) ->
    Pid ! {self(), {take, State}},
    receive
        {Pid, Msg} -> Msg
    after 2000 -> timeout
    end.

stop(Pid) ->
    Pid ! {self(), stop},
    receive
        _ -> ok
    after 5000 -> timeout
    end.
