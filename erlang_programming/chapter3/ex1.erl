-module(c3ex1).
% that is not exactily a good practice
-compile(export_all).

%% given a positive N, will return the sum of all integers between 1 and N
sum (N) when N > 0 -> N + sum (N - 1);
sum (_N) -> 0.

%% given two integers (N =< M) will return the sum of the interval between them
sum (N, M) when N > M -> throw(bad_args); % process must terminate abnormally
sum (Min, Min) -> Min; % if there is not a interval
sum (Min, Max) -> sum (Min, Max + 1, 0).

sum (Max, Max, Acc) -> Acc;
sum (Min, Max, Acc) -> sum (Min + 1, Max, Acc + Min).
