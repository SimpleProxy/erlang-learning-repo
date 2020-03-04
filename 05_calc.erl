%%%--------------------------------------------------------
%%% Code seen in learnyousomeerlang.com
%%% in the section "Functionally solving problems"
%%%--------------------------------------------------------
%%% Module description calc
%%%--------------------------------------------------------
%%% A simple implementation of a RPN calculator
%%% RPN: Reverse Polish Notation
%%%--------------------------------------------------------
%%% calc(String)
%%%     return a numerical result from the operands and
%%%     operator contained in String
%%%--------------------------------------------------------

-module(calc).
-export([calc/1]).

%% Takes a string and call the other helper functions
%% to do the math and then return the sole result contained
%% in the resulting list.
calc(List) when is_list(List) ->
    [Res] = lists:foldl(fun calc/2,
                       [],
                       string:tokens(List, " ")),
    Res.

%% This block is devoted to match against the operators
%% and then do the aperation.
calc("+", [First, Second | Stack]) ->
    [First + Second | Stack];
calc("-", [First, Second | Stack]) ->
    [First - Second | Stack];
calc("*", [First, Second | Stack]) ->
    [First * Second | Stack];
calc("/", [First, Second | Stack]) ->
    [First / Second | Stack];

%% Here a given value will match if it didn't already
%% and the string, which will be a number will be converted
%% to an integer or a float.
calc(Val, Stack) -> [read(Val)|Stack].

%% Convert Val from a string into a number.
read(Val) ->
    case string:to_float(Val) of
        {error, no_float} -> list_to_integer(Val);
        {F, _Anything}    -> F
    end.

