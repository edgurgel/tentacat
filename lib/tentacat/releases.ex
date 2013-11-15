defmodule Tentacat.Releases do
  import Tentacat.Client.Base
  alias Tentacat.Client

  @doc """
  Get all releases from the given repository

  ## Example

      Tentacat.Releases.list("elixir-lang", "elixir", client)

  More info at: http://developer.github.com/v3/repos/releases/#list-releases-for-a-repository
  """
  @spec list(binary, binary, Client.t) :: Base.response
  def list(owner, repo, client // Client.new) do
    get "repos/#{owner}/#{repo}/releases", client.auth
  end

  @doc """
  Get a single release

  ## Example

      Tentacat.Releases.list(9949, "elixir-lang", "elixir", client)

  More info at: http://developer.github.com/v3/repos/releases/#get-a-single-release
  """
  @spec find(integer, binary, binary, Client.t) :: Base.response
  def find(id, owner, repo, client // Client.new) when is_integer(id) do
    get "repos/#{owner}/#{repo}/releases/#{id}", client.auth
  end

  @doc """
  Create a new release from the given tag

  ## Example

      Tentacat.Releases.create("v0.11.0", elixir-lang", "elixir", client)

  More info at: http://developer.github.com/v3/repos/releases/#create-a-release
  """
  @spec create(binary, binary, binary, Client.t, list) :: Base.response
  def create(tag_name, owner, repo, client // Client.new, options // []) when is_binary(tag_name) do
    body = ListDict.merge(options, tag_name: tag_name)
    post "repos/#{owner}/#{repo}/releases", client.auth, body
  end

  @doc """
  Edit an existing release

  ## Options

  * `tag_name` - string
  * `target_commitish` - string
  * `name` - string
  * `body` - string
  * `draft` - boolean
  * `prerelease` - boolean

  ## Example

      Tentacat.Releases.edit(95071, "elixir-lang", "elixir", client)

  More info at: http://developer.github.com/v3/repos/releases/#edit-a-release
  """
  @spec edit(integer, binary, binary, Client.t, list) :: Base.response
  def edit(id, owner, repo, client // Client.new, options // []) when is_integer(id) do
    patch "repos/#{owner}/#{repo}/releases/#{id}", client.auth, options
  end

  @doc """
  Delete a release

  ## Example

      Tentacat.Releases.delete(95071, "elixir-lang", "elixir", client)

  More info at: http://developer.github.com/v3/repos/releases/#delete-a-release
  """
  @spec delete(integer, binary, binary, Client.t) :: Base.response
  def delete(id, owner, repo, client // Client.new) when is_integer(id) do
    delete "repos/#{owner}/#{repo}/releases/#{id}", client.auth
  end
end
