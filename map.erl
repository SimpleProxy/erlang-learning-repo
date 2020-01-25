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
-export([map/2]).

map(_Fun, []) -> [];
map(Fun, [Hd|Tl]) -> [Fun(Hd)|map(Fun, Tl)].
