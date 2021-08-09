defmodule Tentacat.Repositories.Contents do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Gets the contents of a file or directory in a repository.

  ## Example

      Tentacat.Repositories.Contents.content "elixir-lang", "elixir", "CHANGELOG.md"
      Tentacat.Repositories.Contents.content client, "elixir-lang", "elixir", "CHANGELOG.md"

  More info at: https://developer.github.com/v3/repos/contents/#get-contents
  """
  @spec content(Client.t(), binary, binary) :: Tentacat.response()
  def content(client \\ %Client{}, owner, repo, path) do
    get("repos/#{owner}/#{repo}/contents/#{path}", client)
  end
end
