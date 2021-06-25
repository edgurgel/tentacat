defmodule Tentacat.Repositories.Contributors do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List contributors for a specific repository.

  ## Example

      Tentacat.Repositories.Contributors.list "elixir-lang", "elixir"
      Tentacat.Repositories.Contributors.list client, "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/repos/#list-contributors
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/contributors", client)
  end
end
