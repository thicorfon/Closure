defmodule Closure do
  def inList(_, [])do
    false
  end

  def inList(member, [head|tail]) do
    if member == head do
      true
    else
      inList(member, tail)
    end
  end

  def getDistincts([]) do
    []
  end

  def getDistincts([head|tail])do
    if inList(head,tail) == true do
      getDistincts(tail)
    else
      [head|getDistincts(tail)]
    end
  end

  def symmetric([]) do
    []
  end

  def symmetric([{a,b}|tail]) do
    getDistincts([{a,b}|[{b,a}|symmetric(tail)]])
  end

  def newWays(_,[],_) do
    []
  end

  def newWays({a,b}, [{c,d}|tail], seen) do
    if b == c and inList({a,d},seen) == false and {a,d} != {a,b} and {a,d} != {c,d} do
      [{a,d}|newWays({a,b},tail,seen)]
    else
      if a == d and inList({c,b},seen) == false and {c,b} != {a,b} and {c,b} != {c,d} do
        [{c,b}|newWays({a,b},tail,seen)]
      else
        newWays({a,b},tail,seen)
      end
    end
  end

  def appendList([],list) do
    list
  end

  def appendList([head|tail], list) do
    [head|appendList(tail,list)]
  end

  def transitive_aux(x, seen \\ [])

  def transitive_aux([], _) do
    []
  end

  def transitive_aux([{a,b}|tail], seen) do
      getDistincts([{a,b}|transitive_aux(appendList(newWays({a,b},tail, seen),tail),[{a,b}|seen])])
  end

  def transitive(list) do
    x = transitive_aux(list)
    if x == list do
      list
    else
      transitive(x)
    end
  end

  def symOfTrans(relation) do
    symmetric(transitive(relation))
  end

  def transOfSym(relation) do
    transitive(symmetric(relation))
  end
end
