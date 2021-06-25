defmodule Tentacat.Reactions do
  alias Tentacat.Client

  @doc """
  Delete a reaction.

  ## Example

      Tentacat.Reactions.delete(client, reaction_id)


  More info at: https://developer.github.com/v3/reactions/#delete-a-reaction
  """

  @spec delete(Client.t(), integer) :: Tentacat.response()
  def delete(client \\ %Client{}, id) when is_integer(id) do
    Tentacat.delete("reactions/#{id}", client)
  end
end
