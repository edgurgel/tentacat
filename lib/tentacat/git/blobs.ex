defmodule Tentacat.Git.Blobs do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Get the Blob content and metadata for a specific file SHA.

  ## Example

      Tentacat.Git.Blobs.get "elixir-lang", "elixir", "7491bda5196f78536e5acc9b7c90a97170e4db0a"

  More info at: https://developer.github.com/v3/git/blobs/#get-a-blob
  """
  @spec get(Client.t(), binary, binary, binary) :: Tentacat.response()
  def get(client \\ %Client{}, owner, repo, sha) do
    get("repos/#{owner}/#{repo}/git/blobs/#{sha}", client)
  end

  @doc """
  Create a blob in the repository.

  Blob body example:

  ```elixir
  %{
    "content"   => "Content of the blob",
    "encoding"  => "utf-8"
  }
  ```
  ## Example

      Tentacat.Commits.Blobs.create "elixir-lang", "elixir", blob_body

  More info at: https://developer.github.com/v3/git/blobs/#create-a-blob
  """
  @spec create(Client.t(), binary, binary, map) :: Tentacat.response()
  def create(client \\ %Client{}, owner, repo, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/git/blobs", client, body)
  end
end
