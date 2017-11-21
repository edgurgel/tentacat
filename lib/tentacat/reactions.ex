defmodule Tentacat.Reactions do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Delete a reaction

  ## Example

      Tentacat.Reactions.delete("elixir-lang", "elixir", client, reaction_id)


  More info at: https://developer.github.com/v3/reactions/#delete-a-reaction
  """

  @spec delete(integer, binary, Client.t) :: Tentacat.response
  def delete(id, owner, repo, client \\ %Client{}) when is_integer(id) do
    delete "repos/#{owner}/#{repo}/releases/#{id}", client
  end
end
