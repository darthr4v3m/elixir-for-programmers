defmodule B1Web.HangmanView do
  use B1Web, :view

  def continue_or_try_again(conn, status) when status in [:won, :lost] do
    button("Try again", to: Routes.hangman_path(conn, :new))
  end

  def continue_or_try_again(conn, _) do
    form_for(conn, Routes.hangman_path(conn, :update), [as: "make_move", method: :put], fn f ->
      [text_input(f, :guess), " ", submit("Make next guess")]
    end)
  end

  @status_fields %{
    initializing: {"initializing", "🤔 Guess the word, a letter at a time"},
    good_guess: {"good-guess", "✅ Good guess!"},
    bad_guess: {"bad-guess", "🎈 Sorry, that's a bad guess"},
    won: {"won", "🎉 You won!"},
    lost: {"lost", "👋 Sorry, you lost"},
    already_used: {"already-used", "🙂‍↔️ You already used that letter"}
  }

  def move_status(status) do
    {class, msg} = @status_fields[status]
    "<div class='status #{class}'>#{msg}</div>"
  end

  def figure_for(0) do
    ~s{
    ┌───┐
    │   │
    O   │
   /|\\  │
   / \\  │
        │
  ══════╧══
  }
  end

  def figure_for(1) do
    ~s{
    ┌───┐
    │   │
    O   │
   /|\\  │
   /    │
        │
  ══════╧══
  }
  end

  def figure_for(2) do
    ~s{
  ┌───┐
  │   │
  O   │
 /|\\  │
      │
      │
══════╧══
}
  end

  def figure_for(3) do
    ~s{
  ┌───┐
  │   │
  O   │
 /|   │
      │
      │
══════╧══
}
  end

  def figure_for(4) do
    ~s{
  ┌───┐
  │   │
  O   │
  |   │
      │
      │
══════╧══
}
  end

  def figure_for(5) do
    ~s{
  ┌───┐
  │   │
  O   │
      │
      │
      │
══════╧══
}
  end

  def figure_for(6) do
    ~s{
  ┌───┐
  │   │
      │
      │
      │
      │
══════╧══
}
  end

  def figure_for(7) do
    ~s{
  ┌───┐
      │
      │
      │
      │
      │
══════╧══
}
  end
end
