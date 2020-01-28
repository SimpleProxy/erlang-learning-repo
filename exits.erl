%%%--------------------------------------------------------
%%% Code similar to the one seen on 
%%% learnyousomeerlang.com/errors-and-exceptions
%%% The sole purpose of this code is educational
%%%--------------------------------------------------------
%%% Module description exits
%%%--------------------------------------------------------
%%% Experiencing some cenarios with:
%%% - exits;
%%% - errors;
%%% - throws and
%%% - try...catch.
%%%--------------------------------------------------------
%%% myerror(Function)
%%%     return ok or a tuple with the error reason
%%%--------------------------------------------------------
%%% myexit(Function)
%%%     return ok or a tuple with the exit reason
%%%--------------------------------------------------------
%%% mythrow(Function)
%%%     return ok or a tuple with the throw reason
%%%--------------------------------------------------------

-module(exits).
-export([myerror/1, myexit/1, mythrow/1]).

%% Always return ok when a function is passed
%% Unless the function calls erlang:error(Reason)
%% Then, the expected output is {error, Reason}.
myerror(F) ->
    try F() of
        _ -> ok
    catch
        error:Error -> {error, Error}
    end.

%% Similar to myerror, always return ok unless exis/1 is called
%% Then the expected output will be {exit, Reason}.
myexit(F) ->
    try F() of
        _ -> ok
    catch
        exit:Exit -> {exit, Exit}
    end.

%% Same thing goes here, this time throw/1 has not an ok return
%% If so, {throw, Reason} will be returned.
mythrow(F) ->
    try F() of
        _ -> ok
    catch
        throw:Throw -> {throw, Throw}
    end.

