defmodule Tentacat.Repositories.Tags do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List Tags

  ## Example

      Tentacat.Repositories.Tags.list "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/repos/#list-tags
  """
  @spec list(binary, binary, Client.t) :: Tentacat.response
  def list(owner, repo, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/tags", client
  end
end
