-module(bool).
-export([b_not/1, b_or/2, b_and/2, b_nand/2]).

%% Pratice code based on learnyousomeerlang.com examples
%% Extended by the examples in evanmiller.org/joy-of-erlang

%% NOT
b_not(true) -> false;
b_not(false) -> true.

%% OR
b_or(false, false) -> false.
b_or(_, _) -> true;

%% AND
b_and(true, true) -> true;
b_and(_, _) -> false;

%% NOR
b_nor(false, false) -> true;
b_nor(_, _) -> false.

%% NAND : the first composition.
b_nand(Exp1, Exp2) -> b_not(b_and(Exp1, Exp2)).
%% May also be seen as
%% b_and(true, true) -> false;
%% b_nand(_, _) -> true.

%% XOR
b_xor(A,A) -> false;
b_xor(_,_) -> true.

