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

-module(map).
-export([map/2, filter/2, fold/3]).

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

%% Interface function that calls the internal fold function.
% fold(Func, List) -> fold(Func, List, []).

%% Internal fold.
fold(_Func, [], Acc) -> Acc;
fold(Func, [Hd|Tl], Acc) -> fold(Func, Tl, Func(Hd, Acc)).
