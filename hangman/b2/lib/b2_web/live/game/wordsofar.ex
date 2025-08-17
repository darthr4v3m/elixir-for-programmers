defmodule B2Web.Live.Game.WordSoFar do

  use B2Web, :live_component

  @states %{
    already_used: "You have already used this letter",
    good_guess: "Good guess!",
    bad_guess: "That isn't in the word",
    initializing: "Type or click a letter your first guess 🤔",
    won: "You won! 🏆",
    lost: "You lost! 🏳️",
  }

  def mount(socket) do
    {:ok, socket}
  end

  defp state_name(state) do
    @states[state] || "Unknown state"
  end

  def render(assigns) do
    ~L"""
    <div class ="word-so-far">
      <div class ="game-state">
        <%= state_name(@tally.game_state) %>
      </div>
      <div class ="letters">
        <%= for letter <- @tally.letters do %>
          <div class="one-letter <%= if letter != "_", do: "correct" %>">
            <%= letter %>
          </div>
        <% end %>
    </div>
    """
  end

end
