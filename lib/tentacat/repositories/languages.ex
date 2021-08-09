defmodule Tentacat.Repositories.Languages do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List Languages.

  ## Example

      Tentacat.Repositories.Languages.list "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/repos/#list-languages
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/languages", client)
  end
end
