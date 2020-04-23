-module (c3ex2).
-compile(export_all).

% return a list in the format [1, 2, ..., N]
create(N) -> create (N, []).

create (0, Acc) -> Acc;
create (N, Acc) -> create (N - 1, [N | Acc]).

% return a list in the format [N, ..., 2, 1]
reverse_create (N) -> reverse_create (N + 1, 1, []).

reverse_create (N, N, Acc) -> Acc;
reverse_create (N, M, Acc) -> reverse_create (N, M + 1, [M | Acc]).
