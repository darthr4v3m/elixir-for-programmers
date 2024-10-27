defmodule Cache do
  def start do
    Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
  end

  def get_state(pid) do
    Agent.get(pid, fn state -> state end)
  end

  def add(pid, key, value) do
    Agent.update(pid, fn state -> Map.put(state, key, value) end)
  end

  def get_value(pid, key) do
    Agent.get(pid, fn state -> Map.get(state, key) end)
  end
end
