defmodule Dictionary do
  defdelegate start(), to: Dictionary.Impl.WordList
  defdelegate random_word(word_list), to: Dictionary.Impl.WordList
end
