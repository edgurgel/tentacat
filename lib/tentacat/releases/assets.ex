defmodule Tentacat.Releases.Assets do
  import Tentacat
  alias Tentacat.Client

  #
  # Public API
  #

  @doc """
  Get all assets for the given release.

  ## Example

      Tentacat.Releases.Assets.list(95071, "elixir-lang", "elixir", client)

  More info at: http:\\developer.github.com/v3/repos/releases/#list-assets-for-a-release
  """
  @spec list(Client.t(), integer, binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, id, owner, repo) when is_integer(id) do
    get("repos/#{owner}/#{repo}/releases/#{id}/assets", client)
  end

  @doc """
  Get a single release asset.

  ## Example

      Tentacat.Releases.Assets.find(23, "elixir-lang", "elixir", client)

  More info at: http:\\developer.github.com/v3/repos/releases/#get-a-single-release-asset
  """
  @spec find(Client.t(), integer, binary, binary) :: Tentacat.response()
  def find(client \\ %Client{}, id, owner, repo) when is_integer(id) do
    get("repos/#{owner}/#{repo}/releases/assets/#{id}", client)
  end

  @doc """
  Edit a release asset.

  ## Example

      Tentacat.Releases.Assets.edit(client, "my-release.tar.gz", 23, "elixir-lang", "elixir", label: "NEW LABEL!")

  ## Options

    * `label` - string

  More info at: http:\\developer.github.com/v3/repos/releases/#edit-a-release-asset
  """
  @spec edit(Client.t(), binary, integer, binary, binary, list) :: Tentacat.response()
  def edit(client, name, id, owner, repo, options \\ []) when is_integer(id) do
    body = Keyword.merge(options, name: name)
    patch("repos/#{owner}/#{repo}/releases/assets/#{id}", client, body)
  end

  @doc """
  Delete a release asset.

  ## Example

      Tentacat.Releases.Assets.delete(client, "23", "elixir-lang", "elixir")

  More info at: http:\\developer.github.com/v3/repos/releases/#delete-a-release-asset
  """
  @spec delete(Client.t(), integer, binary, binary) :: Tentacat.response()
  def delete(client, id, owner, repo) when is_integer(id) do
    delete("repos/#{owner}/#{repo}/releases/assets/#{id}", client)
  end
end
