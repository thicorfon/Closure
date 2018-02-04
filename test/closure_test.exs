defmodule ClosureTest do
  use ExUnit.Case
  doctest Closure

  test "inList_True" do
    assert Closure.inList({3,5}, [{1,2},{3,4},{3,5},{5,3}]) == true
  end

  test "inList_False" do 
  	assert Closure.inList({1,1},[{:a,:b},{5,6},{1,3},{3,1}]) == false
  end

  test "getDistincts_AllDistinct" do
  	x = [{1,1},{2,2},{1,2},{2,1}]
  	assert Closure.getDistincts(x) == x
  end

  test "getDistincts_SomeRepetitions" do
  	x = [{1,1},{2,2},{1,1},{2,2}]
  	assert Enum.sort(Closure.getDistincts(x)) == Enum.sort([{1,1},{2,2}])
  end

  test "getDistincts_AllRepetitions" do
  	x = [{1,1},{1,1},{1,1},{1,1},{1,1}]
  	assert Closure.getDistincts(x) == [{1,1}]
  end

  test "symmetric_Reflexive" do
  	x = [{1,1},{2,2}]
  	assert Closure.symmetric(x) == x
  end

  test "symmetric_NoRepetitions" do
  	x = [{1,1},{1,3},{2,4},{5,6}]
  	assert Enum.sort(Closure.symmetric(x)) == Enum.sort([{1,1},{1,3},{2,4},{5,6},{3,1},{4,2},{6,5}])
  end

  test "symmetric_Complete" do
  	x = [{1,1},{4,2},{1,3},{2,4},{5,6},{9,0},{0,9}]
  	assert Enum.sort(Closure.symmetric(x)) == Enum.sort([{1,1},{1,3},{2,4},{5,6},{3,1},{4,2},{6,5},{9,0},{0,9}])
  end

  test "newWays_NoNewWay" do
  	x = [{1,2},{3,4},{5,4}]
  	assert Closure.newWays({1,2}, x,[]) == []
  end

  test "newWays_StraightAndBackWays" do
  	x = [{1,2},{3,4},{4,5}]
  	assert Enum.sort(Closure.newWays({2,4},x,[])) == Enum.sort([{1,4},{2,5}])
  end

  test "newWays_Loop" do
  	x = [{1,2},{3,1},{2,3}]
  	assert Enum.sort(Closure.newWays(hd(x),tl(x),[])) == Enum.sort([{1,3},{3,2}])
  end

  test "appendList_ManyElements" do
  	x = [{1,1},{2,2},{3,3},{4,4}]
  	y = [{5,5},{6,6},{7,7}]
  	assert Closure.appendList(y,x) == [{5,5},{6,6},{7,7},{1,1},{2,2},{3,3},{4,4}]
  end

  test "transitive_Simple" do
  	x = [{1,2},{2,3},{3,4},{3,5}]
  	assert Enum.sort(Closure.transitive(x)) == Enum.sort([{1,2},{2,3},{3,4},{3,5},{1,3},{1,4},{1,5},{2,4},{2,5}])
  end

  test "transitive_Backwards" do
  	x = [{2,3},{1,2},{3,4}]
  	assert Enum.sort(Closure.transitive(x)) == Enum.sort([{1,3},{2,3},{1,2},{1,4},{2,4},{3,4}])
  end

  test "transitive_Loop" do
  	x = [{1,2},{3,1},{2,3}]
  	assert Enum.sort(Closure.transitive(x)) == Enum.sort([{1,1},{1,2},{1,3},{2,1},{2,2},{2,3},{3,1},{3,2},{3,3}])
  end

  test "symOfTrans" do
  	x = [{1,2},{2,3},{3,4},{4,4},{4,5},{5,6},{6,4}]
  	assert Enum.sort(Closure.symOfTrans(x)) == Enum.sort([	{1,2},{1,3},{1,4},{1,5},{1,6},
  														  	{2,1},{2,3},{2,4},{2,5},{2,6},
  														  	{3,1},{3,2},{3,4},{3,5},{3,6},
  														  	{4,1},{4,2},{4,3},{4,4},{4,5},{4,6},
  														  	{5,1},{5,2},{5,3},{5,4},{5,5},{5,6},
  														  	{6,1},{6,2},{6,3},{6,4},{6,5},{6,6}])
  end

  test "transOfSym" do
  	x = [{1,2},{2,3},{3,4},{4,4},{4,5},{5,6},{6,4}]
  	assert Enum.sort(Closure.transOfSym(x)) == Enum.sort([	{1,1},{1,2},{1,3},{1,4},{1,5},{1,6},
  														  	{2,1},{2,2},{2,3},{2,4},{2,5},{2,6},
  														  	{3,1},{3,2},{3,3},{3,4},{3,5},{3,6},
  														  	{4,1},{4,2},{4,3},{4,4},{4,5},{4,6},
  														  	{5,1},{5,2},{5,3},{5,4},{5,5},{5,6},
  														  	{6,1},{6,2},{6,3},{6,4},{6,5},{6,6}])
  end 

 end
