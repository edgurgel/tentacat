defmodule Tentacat.Releases.Assets do
  import Tentacat
  alias Tentacat.Client

  #
  # Public API
  #

  @doc """
  Get all assets for the given release

  ## Example

      Tentacat.Releases.Assets.list(95071, "elixir-lang", "elixir", client)

  More info at: http:\\developer.github.com/v3/repos/releases/#list-assets-for-a-release
  """
  @spec list(integer, binary, binary, Client.t) :: Tentacat.response
  def list(id, owner, repo, client \\ %Client{}) when is_integer(id) do
    get "repos/#{owner}/#{repo}/releases/#{id}/assets", client
  end

  @doc """
  Get a single release asset

  ## Example

      Tentacat.Releases.Assets.find(23, "elixir-lang", "elixir", client)

  More info at: http:\\developer.github.com/v3/repos/releases/#get-a-single-release-asset
  """
  @spec find(integer, binary, binary, Client.t) :: Tentacat.response
  def find(id, owner, repo, client \\ %Client{}) when is_integer(id) do
    get "repos/#{owner}/#{repo}/releases/assets/#{id}", client
  end

  @doc """
  Edit a release asset

  ## Example

      Tentacat.Releases.Assets.edit("my-release.tar.gz", 23, "elixir-lang", "elixir", client, label: "NEW LABEL!")

  ## Options

  * `label` - string

  More info at: http:\\developer.github.com/v3/repos/releases/#edit-a-release-asset
  """
  @spec edit(binary, integer, binary, binary, Client.t, list) :: Tentacat.response
  def edit(name, id, owner, repo, client \\ %Client{}, options \\ []) when is_integer(id) do
    body = Dict.merge(options, name: name)
    patch "repos/#{owner}/#{repo}/releases/assets/#{id}", client, body
  end

  @doc """
  Delete a release asset

  ## Example

      Tentacat.Releases.Assets.delete("23", "elixir-lang", "elixir", client)

  More info at: http:\\developer.github.com/v3/repos/releases/#delete-a-release-asset
  """
  @spec delete(integer, binary, binary, Client.t) :: Tentacat.response
  def delete(id, owner, repo, client \\ %Client{}) when is_integer(id) do
    delete "repos/#{owner}/#{repo}/releases/assets/#{id}", client
  end

end
