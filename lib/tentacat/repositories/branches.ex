defmodule Tentacat.Repositories.Branches do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List Branches

  ## Example

      Tentacat.Repositories.Branches.list "elixir-lang", "elixir"
      Tentacat.Repositories.Branches.list "elixir-lang", "elixir", client

  More info at: https://developer.github.com/v3/repos/#list-branches
  """
  @spec list(binary, binary, Client.t) :: Tentacat.response
  def list(owner, repo, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/branches", client.auth
  end

  @doc """
  Get Branch

  ## Example

      Tentacat.Repositories.Branches.find "elixir-lang", "elixir", "feature"
      Tentacat.Repositories.Branches.find "elixir-lang", "elixir", "feature", client

  More info at: https://developer.github.com/v3/repos/#get-branch
  """
  @spec find(binary, binary, binary, Client.t) :: Tentacat.response
  def find(owner, repo, branch, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/branches/#{branch}", client.auth
  end
end
