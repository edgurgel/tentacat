defmodule Tentacat.Git.Blobs do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Get the Blob content and metadata for a specific sha

  ## Example

      Tentacat.Git.Blobs.get "elixir-lang", "elixir", "7491bda5196f78536e5acc9b7c90a97170e4db0a"

  More info at: https://developer.github.com/v3/git/blobs/#get-a-blob
  """
  @spec get(binary, binary, binary, Client.t) :: Tentacat.response
  def get(owner, repo, sha, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/git/blobs/#{sha}", client
  end

  @doc """
  Create a blob in the repository

  Blob body example:
  ```
  %{
    "content"   => "Content of the blob",
    "encoding"  => "utf-8"
  }
  ```
  ## Example

      Tentacat.Commits.Blobs.create "elixir-lang", "elixir", blob_body

  More info at: https://developer.github.com/v3/git/blobs/#create-a-blob
  """
  @spec create(binary, binary, map | list, Client.t) :: Tentacat.response
  def create(owner, repo, body, client \\ %Client{}) do
    post "repos/#{owner}/#{repo}/git/blobs", client, body
  end
end