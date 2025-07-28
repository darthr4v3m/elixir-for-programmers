defmodule MemoryWeb.Live.MemoryDisplay do

  use MemoryWeb, :live_view

  def mount(_params, _session, socket) do
    Process.send_after(self(), :tick, 1000)
    socket = assign(socket, :time, :erlang.time())
    {:ok, socket}
  end

  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, 1000)
    socket = assign(socket, :time, :erlang.time())
    {:noreply, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Welcome to the <%= elem(assigns.time, 0) %>:<%= elem(assigns.time, 1) %>:<%= elem(assigns.time, 2) %>!</h1>
    """
  end
end
