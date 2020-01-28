%%%------------------------------------------------------------------
%%% Description module tailrec
%%%------------------------------------------------------------------
%%% Tail recursive examples
%%%------------------------------------------------------------------
%%% sum(List)
%%%     return the sum of elements in the list
%%%------------------------------------------------------------------
%%% len(List)
%%%     return the lenght of a list
%%%------------------------------------------------------------------
%%% average(List)
%%%     retunr the list's average value
%%%------------------------------------------------------------------
%%% duplicate(Len, Num)
%%%     return a list of lenght Len where all the elements are Num
%%%------------------------------------------------------------------
%%% reverse(List)
%%%     return a List reversed
%%%------------------------------------------------------------------

-module(tailrec).
-export([reverse/1, sum/1, len/1, average/1,
         duplicate/2, factorial/1]).

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

factorial(Number) -> factorial(Number, 1).

factorial(0, Acc) -> Acc;
factorial(Number, Acc) -> factorial(Number - 1, Acc * Number).
