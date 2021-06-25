defmodule Tentacat.Pulls.Files do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List pull requests files.

  ## Example

      Tentacat.Pulls.Files.list "elixir-lang", "elixir", "2974"
      Tentacat.Pulls.Files.list client, "elixir-lang", "elixir", "2974"

  More info at: https://developer.github.com/v3/pulls/#list-pull-requests-files
  """
  @spec list(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo, number) do
    get("repos/#{owner}/#{repo}/pulls/#{number}/files", client)
  end
end
