defmodule Tentacat.Repositories.Branches do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List Branches

  ## Example

      Tentacat.Repositories.Branches.list "elixir-lang", "elixir"
      Tentacat.Repositories.Branches.list client, "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/repos/#list-branches
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/branches", client)
  end

  @doc """
  Get Branch

  ## Example

      Tentacat.Repositories.Branches.find "elixir-lang", "elixir", "feature"
      Tentacat.Repositories.Branches.find client, "elixir-lang", "elixir", "feature"

  More info at: https://developer.github.com/v3/repos/#get-branch
  """
  @spec find(Client.t(), binary, binary, binary) :: Tentacat.response()
  def find(client \\ %Client{}, owner, repo, branch) do
    get("repos/#{owner}/#{repo}/branches/#{branch}", client)
  end
end
