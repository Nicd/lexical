defmodule Lexical.RemoteControl.CodeMod.Ast do
  alias Lexical.Document

  @type t :: any()

  def from(%Document{} = document) do
    document
    |> Document.to_string()
    |> from()
  end

  def from(s) when is_binary(s) do
    parse(s)
  end

  defp parse(s) when is_binary(s) do
    ElixirSense.string_to_quoted(s, 1, 6, token_metadata: true)
  end
end
