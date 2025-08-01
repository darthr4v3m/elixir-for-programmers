defmodule B2Web.Live.Game do

  use B2Web, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div>
      <h1>Welcome to the Hangman Game!</h1>
      <p>Game is under construction.</p>
    </div>
    """
  end
end
