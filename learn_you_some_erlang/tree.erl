%%%--------------------------------------------------------
%%% Code from learnyousomeerlang.com
%%%--------------------------------------------------------
%%% Description module tree
%%%--------------------------------------------------------
%%% empity()
%%%     return a empity node
%%%--------------------------------------------------------
%%% lookup(Key, Tree)
%%%     return the value stored under the key Key inside
%%%     the tree Tree
%%%--------------------------------------------------------
%%% insert(Key, Val, Tree)
%%%     return a new tree, just like Tree, with a new 
%%%     node with the key Key and the value Val
%%%--------------------------------------------------------
%%% has_value(Value, Tree)
%%%     return true case the tree Tree has the value Value
%%%     return false in the nagative case
%%%--------------------------------------------------------

-module(tree).
-export([empity/0, lookup/2, insert/3, hasvalue/2]).

empity() -> {node, "nil"}.

%% Base case, empity node/tree
insert(Key, Val, {node, "nil"}) ->
                  {node, {Key, Val,
                          {node, "nil"}, % Left node
                          {node, "nil"}}}; % Right node

insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}})
  when NewKey < Key ->
    % Left leaf
    % Insertion in the Smaller node
    {node, {Key, Val, 
            insert(NewKey, NewVal, Smaller), 
            Larger}};

insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}})
  when NewKey > Key ->
    % Right leaf
    % Insertion in the Larger node
    {node, {Key, Val,
            Smaller, 
            insert(NewKey, NewVal, Larger)}};

insert(Key, NewVal, {node, {Key, _Val, Smaller, Larger}}) ->
    % When keys are equal
    % In this implementation the node's value is changed
    {node, {Key, NewVal, Smaller, Larger}}.

% Note that this implementation returns a new tree,
% but the VM is smart enough and can handle this in its internals

%% Base case, Key not found
lookup(_Key,{node, "nil"}) -> undefined;
%% Key found
lookup(Key, {node, {Key, Val, _Smaller, _Larger}}) ->
    {ok, Val};
%% Look in the smaller node tree
lookup(Key, {node, {NodeKey, _Val, Smaller, _Larger}})
  when Key < NodeKey ->
    lookup(Key, Smaller);
%% Look in the larger node tree
lookup(Key, {node, {_Key, _Val, _Smaller, Larger}}) ->
    lookup(Key, Larger).

%% hasvalue, is a interface function similar to lookup
%% but instead of searching for a key it searches for a value
%% in the given tree
hasvalue(Val, Tree) ->
    try internal_has_val(Val, Tree) of
        false -> false
    catch
        true -> true
    end.

%% Base case, return false if it reaches a nil node
internal_has_val(_Val, {node, "nil"}) ->
    false;
%% In case the value is found true will immediately be returned
internal_has_val(Val, {node, {_Key, Val,_Smaller, _Larger}}) ->
    throw(true);
%% In case the valeu has not be found yet continues the search
%% in both directions
internal_has_val(Val, {node, {_Key, _Val, Smaller, Larger}}) ->
    internal_has_val(Val, Smaller),
    internal_has_val(Val, Larger).

