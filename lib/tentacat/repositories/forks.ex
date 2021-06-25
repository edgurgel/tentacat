defmodule Tentacat.Repositories.Forks do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List forks of a repository.

  ## Example

      Tentacat.Repositories.Forks.list "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/repos/forks/
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/forks", client)
  end

  @doc """
  Creates a new fork of a repository.

  ## Example

      Tentacat.Repositories.Forks.create "elixir-lang", "elixir", "tinfoil", %{}
      Tentacat.Repositories.Forks.create "elixir-lang", "elixir", "tinfoil", %{organization: "tinfoil"}

  More info at: https://developer.github.com/v3/repos/forks/#create-a-fork
  """
  @spec create(Client.t(), binary, binary, map) :: Tentacat.response()
  def create(client \\ %Client{}, owner, repo, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/forks", client, body)
  end
end
