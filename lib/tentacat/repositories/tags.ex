defmodule Tentacat.Repositories.Tags do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List Tags.

  ## Example

      Tentacat.Repositories.Tags.list "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/repos/#list-tags
  """
  @spec list(Client.t(), binary, binary, Keyword.t()) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo, options \\ []) do
    get("repos/#{owner}/#{repo}/tags", client, options)
  end
end
