defmodule Tentacat.Commits do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List commits on a repository

  ## Example

      Tentacat.Commits.list(client, "elixir-lang", "elixir")

  More info at: https://developer.github.com/v3/repos/commits/#list-commits-on-a-repository
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/commits", client)
  end

  @doc """
  Filter commits on a repository. Parameters are `sha`, `path`, `author`, `since`, `until`.

  ## Example

      Tentacat.Commits.filter(client, "elixir-lang", "elixir", %{sha: "my-branch"})

  More info at: https://developer.github.com/v3/repos/commits/#list-commits-on-a-repository
  """
  @spec filter(Client.t(), binary, binary, Keyword.t() | map) :: Tentacat.response()
  def filter(client \\ %Client{}, owner, repo, filters) do
    get("repos/#{owner}/#{repo}/commits?#{URI.encode_query(filters)}", client)
  end

  @doc """
  Get a single commit

  ## Example

      Tentacat.Commits.find(client, "6dcb09b", "elixir-lang", "elixir")

  More info at: http:\\developer.github.com/v3/repos/releases/#get-a-single-commit
  """
  @spec find(Client.t(), any, binary, binary) :: Tentacat.response()
  def find(client \\ %Client{}, sha, owner, repo) do
    get("repos/#{owner}/#{repo}/commits/#{sha}", client)
  end

  @doc """
  Compare two commits

  ## Example

      Tentacat.Commits.compare(client, base, head, "elixir-lang", "elixir")

  More info at: https://developer.github.com/v3/repos/commits/#compare-two-commits
  """
  @spec compare(Client.t(), any, any, binary, binary) :: Tentacat.response()
  def compare(client \\ %Client{}, base, head, owner, repo) do
    get("repos/#{owner}/#{repo}/compare/#{base}...#{head}", client)
  end
end
