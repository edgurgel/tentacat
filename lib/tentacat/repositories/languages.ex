defmodule Tentacat.Repositories.Languages do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List Languages

  ## Example

      Tentacat.Repositories.Languages.list "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/repos/#list-languages
  """
  @spec list(binary, binary, Client.t) :: Tentacat.response
  def list(owner, repo, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/languages", client
  end
end
