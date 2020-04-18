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
%%% fibonacci(N)
%%%     return the Nth number of the fibnocci sequence
%%%------------------------------------------------------------------

-module(tailrec).
-export([reverse/1, sum/1, len/1, average/1,
         higher/1, duplicate/2]).
-export([factorial/1, fibonacci/1]).

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

%% scan a list and returns its igher value
%% FIXME: if all elements in the list are negative the return will be 0
higher(List) -> higher(List, 0).

higher([], Acc) -> Acc;
higher([A | Tail], Acc) when A > Acc -> higher(Tail, A);
higher([_A | Tail], Acc) -> higher(Tail, Acc).

%% Creates a list where all the elements are the same
duplicate(Number, Times) -> duplicate(Number, Times, []).

duplicate(_, 0, List) -> List;
duplicate(Number, Times, List) -> duplicate(Number, Times - 1, [Number|List]).

%% Interface function to factorial/2
factorial(Number) -> factorial(Number, 1).

factorial(0, Acc) -> Acc;
factorial(Number, Acc) -> factorial(Number - 1, Acc * Number).

%% Interface function to fibonacci/3
%% fibonacci/1 receives a number as its argument, this is the nth number in the
%% fibonacci sequence
fibonacci(N) -> fibonacci(1, 1, N).

fibonacci(_N2, _N1, Nth) when Nth < 0 -> undefined;
fibonacci(_N2, N1, 0)                 -> {ok, N1};
fibonacci(_N2, N1, 1)                 -> {ok, N1};
fibonacci(N2, N1, Nth)                -> fibonacci(N2, N1 + N2, Nth - 1).

