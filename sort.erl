%%%----------------------------------------------------------------------------
%%% Description module sort
%%%----------------------------------------------------------------------------
%%% Simple Merge Sorte implementation
%%% I wanted to do this one after a online class on introduction to algorithms
%%% on Coursera. As I am learning Erlang I decided to give ir a try and started
%%% to think about how to do it.
%%% Some of my ideas were right, some wrong. And finally I reached the "final"
%%% solution with some help from a snippet code in stackoverflow.
%%% stackoverflow.com/questions/27087622/tail-recursive-mergesort-algorithm
%%%----------------------------------------------------------------------------
%%% len(lst)
%%%     return the length of a list
%%%----------------------------------------------------------------------------
%%% split(half,lst)
%%%     return the half, first or second, of lst
%%%----------------------------------------------------------------------------
%%% merge(lst)
%%%     return a sorted list using the merge sort method
%%%----------------------------------------------------------------------------
%%% merge/2
%%%     return a sorted list merged piece by piece by iterations over merge/3
%%%----------------------------------------------------------------------------
%%% merge/3
%%%     return a list merged from the first two lists given as arguments
%%%----------------------------------------------------------------------------
%%%
-module(sort).
-export([len/1, split/2]).
-export([merge/1, merge/2, merge/3]).

%% This is a just a in-module function that returns the length of a list
%% Another way to do this is to simply call length directly
%% or doing len(List) -> length(List) (kind of aliasing).
len(List) -> len(List, 0).
len([], Acc) -> Acc;
len([_Hd | Tl], Acc) -> len(Tl, Acc + 1).

reverse(List) -> reverse(List, []).
reverse([], Acc) -> Acc;
reverse([Hd | Tl], Acc) -> reverse(Tl, [Hd | Acc]).

%% Helper function to split a list in tow.
split(1,List) -> split(1, len(List) div 2, List, []);
split(2,List) -> split(2, (len(List) div 2), List, []).

split(1, 0, _RemList, ResList) -> ResList;
split(1, Acc, [Hd | Tl], ResList) -> split(1, Acc - 1, Tl, [Hd | ResList]);
split(2, 0, RemList, _ResList) -> RemList;
split(2, Acc, [_Hd | Tl], RemList) -> split(2, Acc - 1, Tl, RemList).

%% returns a list of lists with all elements of L
%% this is just perfect since we can do comparissons like [L] < [M]
merge(L) -> merge([[X] || X <- L], []).

merge([], []) -> []; 
merge([], [List]) -> List;
merge([], List) -> merge(List, []);
merge([L], List) -> merge([], [L | List]);
merge([L1, L2 | Tail], List) -> merge(Tail, [merge(L1, L2, []) | List]).

merge([], [], Acc) -> reverse(Acc);
merge([Hd | Tl], [], Acc) -> merge(Tl, [], [Hd | Acc]);
merge([], [Hd | Tl], Acc) -> merge([], Tl, [Hd | Acc]);
merge([Hd1 | Tl1], [Hd2 | Tl2], Acc) ->
    case Hd1 < Hd2 of
        true -> merge(Tl1, [Hd2 | Tl2], [Hd1 | Acc]);
        false -> merge([Hd1 | Tl1], Tl2, [Hd2 | Acc])
    end.

