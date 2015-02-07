defmodule Tentacat.Pulls.Files do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List pull requests files

  ## Example

      Tentacat.Pulls.Files.list "elixir-lang", "elixir", "2974"
      Tentacat.Pulls.Files.list "elixir-lang", "elixir", "2974", client

  More info at: https://developer.github.com/v3/pulls/#list-pull-requests-files
  """
  @spec list(binary, binary, binary | integer, Client.t) :: Tentacat.response
  def list(owner, repo, number, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/pulls/#{number}/files", client.auth
  end
end
