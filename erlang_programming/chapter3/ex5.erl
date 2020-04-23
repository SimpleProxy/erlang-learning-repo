-module (c3ex5).
-compile (export_all).

%% given a list of ints and an int (N), will return a list of ints
%% with all ints smaller than the int (N)
filter (Lst, N) -> filter (Lst, N, []).

filter ([Hd | _Tail], Hd, Acc) -> lists:reverse([Hd | Acc]);
filter ([Hd | Tail], N, Acc) when N > Hd -> filter (Tail, N, [Hd | Acc]);
filter ([_Hd | Tail], N, Acc) -> filter (Tail, N, Acc).

%% given a list, int will reverse the order of its elements
%% 
reverse (List) -> reverse (List, []).

reverse ([], Acc) -> Acc;
reverse ([Hd | Tl], Acc) -> reverse (Tl, [Hd | Acc]).

%% takes a list of lists and concatenate them
concatenate (ListOfLists) -> concatenate (ListOfLists, []).

% no more work to do, return the accumulator
% import to note that this case must be the first one
% otherwise the return will be wrong
concatenate ([], Acc) -> reverse (Acc);
% first iteration (?)
concatenate ([Hd | Tl], []) -> concatenate (Tl, reverse (Hd));

concatenate ([Head | Tail], Acc) ->
    case Head of
        []          ->  concatenate (Tail, Acc);
        [Hd | Tl]   ->  concatenate ([Tl | Tail], [Hd | Acc])
    end.
