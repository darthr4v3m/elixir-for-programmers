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

  def interact({game, _tally = %{game_state: :lost}}) do
    IO.puts("Sorry, you lost... thre word was #{game.letters |> Enum.join()}")
  end

  def interact({game, tally}) do
    # feedback
    IO.puts(feedback_for(tally))
    # display current word
    IO.puts(current_word(tally))
    # get next guess
    Hangman.make_move(game, get_guess())
    |> interact()
  end

  def feedback_for(tally = %{game_state: :initializing}) do
    "Welcome! I'm thinking of a #{tally.letters |> length} letter word"
  end

  def feedback_for(_tally = %{game_state: :good_guess}), do: "Good guess!"
  def feedback_for(_tally = %{game_state: :bad_guess}), do: "Bad guess!"
  def feedback_for(_tally = %{game_state: :already_used}), do: "Already used that letter!"

  def current_word(tally) do
    [
      "Word so far: ",
      tally.letters |> Enum.join(" "),
      IO.ANSI.green() <> "   turns left: " <> IO.ANSI.reset(),
      tally.turns_left |> to_string,
      IO.ANSI.green() <> "   used so far: " <> IO.ANSI.reset(),
      tally.used |> Enum.join(",")
    ]
  end

  def get_guess() do
    IO.gets("Next letter: ")
    |> String.trim()
    |> String.downcase()
  end
end
