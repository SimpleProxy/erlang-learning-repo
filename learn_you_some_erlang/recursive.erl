%%%------------------------------------------------------------------
%%% Code inspired in examples from learnyousomeerlang.com
%%%------------------------------------------------------------------
%%% Description module recursive
%%%------------------------------------------------------------------
%%% Just praticing with recursive
%%%------------------------------------------------------------------
%%% len(List)
%%%     return the lenght of a list
%%%------------------------------------------------------------------
%%% reverse(List)
%%%     return the reversed list List
%%%------------------------------------------------------------------
%%% multiply(Num, List)
%%%     retunr a list where all elements of List were multiplyed
%%%     by Num
%%%------------------------------------------------------------------
%%% sum(List)
%%%     return the sum of all the elements contained in the list List
%%%------------------------------------------------------------------
%%% zip(List1, List2)
%%%     return a list of tuples with the corresponding elements of
%%%     each list
%%%------------------------------------------------------------------
%%% factorial(Num)
%%%     return the factorial of Num
%%%------------------------------------------------------------------

-module(recursive).
-export([len/1, sum/1, reverse/1, average/1,
         multiply/2, zip/2, factorial/1, nth/2]).

len([]) -> 0;
len([_|T]) -> 1 + len(T).

sum([]) -> 0;
sum([H|T]) -> H + sum(T).

reverse([Hd|Tl]) -> [reverse(Tl)|Hd].

average([]) -> 0;
average(List) -> sum(List)/len(List).

multiply(List,Number) -> [Element * Number || Element <-  List].

factorial(Number) -> Number * factorial(Number - 1).

zip(List1, List2) -> reverse(zip(List1,List2, [])).

zip([],_, Accumulator) -> Accumulator;
zip(_,[], Accumulator) -> Accumulator;
zip([H1|T1], [H2|T2], Accumulator) -> 
    zip(T1, T2, [{H1, H2}|Accumulator]).

nth(0, [Hd|_Tl]) -> Hd;
nth(Nth, [_Hd|Tl]) -> nth(Nth - 1, Tl).

