defmodule Tentacat.Commits do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List commits on a repository

  ## Example

      Tentacat.Commits.list("elixir-lang", "elixir", client)

  More info at: https://developer.github.com/v3/repos/commits/#list-commits-on-a-repository
  """
  @spec list(binary, binary, Client.t) :: Tentacat.response
  def list(owner, repo, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/commits", client
  end

  @doc """
  Get a single commit

  ## Example

      Tentacat.Commits.find("6dcb09b", "elixir-lang", "elixir", client)

  More info at: http:\\developer.github.com/v3/repos/releases/#get-a-single-commit
  """
  @spec find(any, binary, binary, Client.t) :: Tentacat.response
  def find(sha, owner, repo, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/commits/#{sha}", client
  end

  @doc """
  Compare two commits

  ## Example

      Tentacat.Commits.compare(base, head, "elixir-lang", "elixir", client)

  More info at: https://developer.github.com/v3/repos/commits/#compare-two-commits
  """
  @spec compare(any, any, binary, binary, Client.t) :: Tentacat.response
  def compare(base, head, owner, repo, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/compare/#{base}...#{head}", client
  end
end
