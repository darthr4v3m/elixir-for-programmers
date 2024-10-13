defmodule Procs do
  def hello() do
    receive do
      msg ->
        IO.puts("Hello #{inspect(msg)}")
    end

    hello()
  end

  def hello(count) do
    receive do
      {:crash, reason} ->
        exit(reason)

      :reset ->
        hello(0)

      {:quit} ->
        IO.puts("Bye bye 👋")

      {:add, n} ->
        hello(count + n)

      msg ->
        IO.puts("#{count}: Hello #{inspect(msg)}")
        hello(count)
    end

    hello()
  end
end
