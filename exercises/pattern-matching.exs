defmodule PatternMatching do
  # Ugly :)
  #  def swap({a,b}) do
  #    c = b;
  #    d = a;
  #    {c, d}
  #  end

  def swap({a, b}), do: {b, a}

  # returns an error on different values, not a boolean
  # def isEqual(a, b), do: ^a = b

  def isEqual(a, a), do: true
  def isEqual(_, _), do: false
end
