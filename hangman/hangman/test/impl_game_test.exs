defmodule HangmanImplGameTest do
  use ExUnit.Case
  alias Hangman.Impl.Game

  test "new game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "new game returns correct word" do
    game = "batman" |> Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.letters == ["b", "a", "t", "m", "a", "n"]
  end

  test "letters are lower-case ASCII chars" do
    game = Game.new_game()

    assert game.letters |> List.to_charlist() |> List.ascii_printable?()
  end

  test "state doesn't change if a game is won or lost" do
    for state <- [:won, :lost] do
      game = "batman" |> Game.new_game()
      game = Map.put(game, :game_state, state)
      {new_game, _tally} = Game.make_move(game, "x")

      assert new_game == game
    end
  end

  test "a duplicate letter is reported" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "y")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "we record letters used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    {game, _tally} = Game.make_move(game, "y")
    {game, _tally} = Game.make_move(game, "x")
    assert MapSet.equal?(game.used, MapSet.new(["x", "y"]))
  end
end
