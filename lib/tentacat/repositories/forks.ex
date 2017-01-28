defmodule Tentacat.Repositories.Forks do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List forks of a repository

  ## Example

      Tentacat.Repositories.Forks.list "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/repos/forks/
  """
  @spec list(binary, binary, Client.t) :: Tentacat.response
  def list(owner, repo, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/forks", client
  end

  @doc """
  Creates a new fork of a repository

  ## Example

      Tentacat.Repositories.Forks.create "elixir-lang", "elixir", "tinfoil", %{}
      Tentacat.Repositories.Forks.create "elixir-lang", "elixir", "tinfoil", %{organization: "tinfoil"}

  More info at: https://developer.github.com/v3/issues/labels/#create-a-label
  """
  @spec create(binary, binary, list | map, Client.t) :: Tentacat.response
  def create(owner, repo, body, client \\ %Client{}) do
    post "repos/#{owner}/#{repo}/forks", client, body
  end
end
