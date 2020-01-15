-module(recursive).
-export([factorial/1, duplicate/2, len/1, reverse/1,
         sum/1, multiply/2, zip/2]).

%% Sample code from learnyousomeerlang.com
%% Just praticing with recursive and tail recursive functions

len(List) -> len(List, 0).

len([], Counter) -> Counter;
len([_|Tail], Counter) -> len(Tail, Counter + 1).

factorial(Number) -> factorial(Number, 1).

factorial(0, Accumulator) -> Accumulator;
factorial(Number, Accumulator) when Number > 0 ->
    factorial(Number - 1, Number * Accumulator).

duplicate(Number, Counter) -> duplicate(Number, Counter, []).

duplicate(_, 0, List) -> List;
duplicate(Number, Counter, List) -> duplicate(Number, Counter - 1,
                                              [Number|List]).
reverse(List) -> reverse(List, []).

reverse([],RList) -> RList;
reverse([Head|Tail],RList) -> reverse(Tail, [Head|RList]).

sum(List) -> sum(List, 0).

sum([], Number) -> Number;
sum([Head|Tail], Number) -> sum(Tail, Number + Head).

multiply(List,Number) -> [Element * Number || Element <-  List].

zip(List1, List2) -> reverse(zip(List1,List2, [])).

zip([],_, Accumulator) -> Accumulator;
zip(_,[], Accumulator) -> Accumulator;
zip([H1|T1], [H2|T2], Accumulator) -> 
    zip(T1, T2, [{H1, H2}|Accumulator]).


