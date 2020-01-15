-module(tree).
-export([empity/0, lookup/2, insert/3]).

%% Sample code from learnyousomeerlang.com
%% Changed some things here and there
%% And added comments for my better understanding

empity() -> {node, "nil"}.

insert(Key, Val, {node, "nil"}) ->
    % Base case, empity node/tree
                  {node, {Key, Val, {node, "nil"}, {node, "nil"}}};
insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}})
  when NewKey < Key ->
    % Left leaf
    % Insertion in the Smaller node
    {node, {Key, Val, insert(NewKey, NewVal, Smaller), Larger}};
insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}})
  when NewKey > Key ->
    % Right leaf
    % Insertion in the Larger node
    {node, {Key, Val, Smaller, insert(NewKey, NewVal, Larger)}};
insert(Key, NewVal, {node, {Key, _, Smaller, Larger}}) ->
    % When keys are equal
    % In this implementation the node's value is changed
    {node, {Key, NewVal, Smaller, Larger}}.

% Note that this implementation returns a new tree,
% but the VM is smart enough and can handle this in its internals

lookup(_,{node, "nil"}) -> undefined;
lookup(Key, {node, {Key, Val, _, _}}) -> {ok, Val};
lookup(Key, {node, {NodeKey, _, Smaller, _}}) when Key < NodeKey ->
    % Look in the smaller node tree
    lookup(Key, Smaller);
lookup(Key, {node, {_, _, _, Larger}}) ->
    % Look in the larger node tree
    lookup(Key, Larger).
