-module(tailrec).
-export([sum/1, len/1, average/1]).

%% Tail recursive code examples

reverse(List) -> reverse(List,[]).

reverse([],FinalList) -> FinalList;
reverse([Hd|Tl], List) -> reverse(Tl, [Hd|List]).

%% Helper function (interface), for a simpler call
sum(List) -> sum(List, 0).

%% Actual sum function, with an accumulator
sum([], Acc) -> Acc;
sum([H|T], Acc) -> sum(T, Acc + H).

%% Helper function (interface), for a simpler call
len(List) -> len(List, 0).

%% Actual len function, with an accumulator
len([], Acc) -> Acc;
len([_|T], Acc) -> len(T, Acc + 1).

%% Helper function (interface)
%% Normally the average would be something like the sum/len
%% This tail recursive call does a better job
%% once it transaverse the list just once 
average([]) -> 0;
average(List) -> average(List, 0, 0).

average([], Sum, Len) -> Sum/Len;
average([H|T], Sum, Len) -> average(T, Sum + H, Len + 1).

%% Creates a list where all the elements are the same
duplicate(Number, Times) -> duplicate(Number, Times, []).

duplicate(_, 0, List) -> List;
duplicate(Number, Times, List) -> duplicate(Number, Times - 1, [Number|List]).
