defmodule TextClient.Impl.Player do
  @typep game :: Hangman.game()
  @typep tally :: Hangman.tally()
  @typep state :: {game, tally}

  @spec start() :: :ok
  def start() do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    interact({game, tally})
  end

  @spec interact(state) :: :ok

  def interact({_game, _tally = %{game_state: :won}}) do
    IO.puts("Congrats, you won!")
  end

  def interact({_game, tally = %{game_state: :lost}}) do
    IO.puts("Sorry, you lost... thre word was #{tally.letters |> Enum.join()}")
  end

  def interact(state) do
    IO.puts(feedback_for(state.tally))
    # feedback
    # display current word
    # get next guess
    # make move
    # interact()
  end

  def feedback_for(tally = %{game_state: :initializing}) do
    "Welcome! I'm thinking of a #{tally.letters |> length} letter word"
  end

  def feedback_for(_tally = %{game_state: :good_guess}), do: "Good guess!"
  def feedback_for(_tally = %{game_state: :bad_guess}), do: "Bad guess!"
  def feedback_for(_tally = %{game_state: :already_used}), do: "Already used that letter!"

  # :initializing :good_guess | :bad_guess | :already_used
end
