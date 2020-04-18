%%%----------------------------------------------------------------------------
%%% Code seen in learnyousomeerlang.com
%%% in section "Erros and Processes"
%%%----------------------------------------------------------------------------
%%% Module description: links
%%%----------------------------------------------------------------------------
%%% A link is a relationship created between processes 
%%% This is useful to create fault tolerant system
%%% This is done with the link/1 primitive, which takes a PID as argument
%%% Links are bidirectional and do not stack, only two processes are linked
%%% at a time
%%%----------------------------------------------------------------------------
%%% init()
%%%     spawn a proc processes that does nothing for a while
%%%     and then throws an "time_out" exit. 
%%%----------------------------------------------------------------------------
%%% To links this in the Erlang shell just type:
%%%     link(init()).
%%%     \_ init/0 returns a PID.
%%%     \_ link takes a PID and link the caller with this processes
%%%----------------------------------------------------------------------------
%%% There is also a spawn_link/1-3 that takes the same argument as spawn/1-3,
%%% creates a process and link it, all as an atomic operation
%%%----------------------------------------------------------------------------

-module(links).
-export([init/0, proc/0]).

%%% spawn could be called like spawn (proc) or spawn (fun() -> proc() end)
init() -> spawn (?MODULE, proc, []).

proc () -> timer:sleep(3000),
           exit(time_out).
