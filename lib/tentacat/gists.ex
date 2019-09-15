defmodule Tentacat.Gists do
  import Tentacat, [:except, :delete, 2]
  alias Tentacat.Client

  @doc """
  Deleting a gist requires admin access. If OAuth is used, the gist scope is required.

  ## Example

      Tentacat.Gists.delete(client, "fe771b85eeeff878d177b0c0f3840afd")

  More info at: https://developer.github.com/v3/gists/#delete-a-gist
  """
  @spec delete(Client.t(), binary) :: Tentacat.response()
  def delete(client, id) do
    Tentacat.delete("gists/#{id}", client)
  end
end
