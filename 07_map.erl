%%%------------------------------------------------------------------
%%% Code seen in learnyousomeerlang.com
%%%------------------------------------------------------------------
%%% Description module map
%%%------------------------------------------------------------------
%%% Basic map function showing the concepts of a mapping/filter function,
%%% high order function.
%%%------------------------------------------------------------------
%%% map(fun, lst)
%%%     return the resulting list with the elements from the list
%%%     lst filtered by the function fun
%%%------------------------------------------------------------------
%%% filter(fun, lst)
%%%     return a list with the elements from lst filtered by the
%%%     funtcion fun
%%%------------------------------------------------------------------
%%% fold(fun, lst, acc)
%%%     return the accumulator acc which contains the result of
%%%     passing all elements of lst as arguments to the function fun.
%%%     The final result can either be a list or  single value.
%%%------------------------------------------------------------------
%%% mapf(fun, lst)
%%%  return a list where all the elements of lst passed through the
%%%  function fun. Using fold/3 in its internals.
%%%------------------------------------------------------------------
%%% filterf(fun, lst)
%%%     return a new list with the elements filtered from lst by the
%%%     function fun. Using filterf/2 as a interface to fold/3.
%%%------------------------------------------------------------------
%%%

-module(map).
-export([map/2, filter/2, fold/3, reverse/1, mapf/2, filterf/2]).

map(_Fun, []) -> [];
map(Fun, [Hd|Tl]) -> [Fun(Hd)|map(Fun, Tl)].

%% Interface function that calls the internal filter function.
filter(Fun, List) -> filter(Fun, List, []).

%% Pass a list through a selector function, in case the element pass the
%% filter it is added to the accumulator
filter(_Fun, [], Accumulator) -> Accumulator;
filter(Fun, [Hd|Tl], Acc) -> 
    case Fun(Hd) of
        true -> filter(Fun, Tl, [Hd|Acc]);
        false -> filter(Fun, Tl, Acc)
    end.

%% fold takes 3 arguments, a function to work on the list, which is the second
%% argument, and an accumulator
fold(_Func, [], Acc) -> Acc;
fold(Func, [Hd|Tl], Acc) -> fold(Func, Tl, Func(Hd, Acc)).

%% In fact, many functions can use fold to do their jobs

%% Invert a list using fold
reverse(List) -> fold(fun(Element, Acc) -> [Element|Acc] end, List, []).

%% maps a list using fold
%% Defines, and pass to fold, a simple function that only prepends an element 
%% to the given list after passing it to the given function
mapf(Func, List) ->
    reverse(fold(
              fun(Element, Acc) -> [Func(Element)|Acc] end,
              List,
              [])).

%% Filter using fold
%% A internal helper function is declared just as in filter/2
%% Fold uses this helper function which uses the given function to select
%% the right elements of the list, at the end a list is returned to
%% reverse/1 then inverted and finally is returned to the caller
filterf(Func, List) ->
    InternalF = fun(Element, Acc) ->
                        case Func(Element) of
                            true -> [Element|Acc];
                            false -> Acc
                        end
                end,
    reverse(fold(InternalF, List, [])).

