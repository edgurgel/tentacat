defmodule Tentacat.Releases do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Get all releases from the given repository.

  ## Example

      Tentacat.Releases.list(client, "elixir-lang", "elixir")

  More info at: http://developer.github.com/v3/repos/releases/#list-releases-for-a-repository
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/releases", client)
  end

  @doc """
  Get a single release.

  ## Example

      Tentacat.Releases.find(client, 9949, "elixir-lang", "elixir")

  More info at: http://developer.github.com/v3/repos/releases/#get-a-single-release
  """
  @spec find(Client.t(), any, binary, binary) :: Tentacat.response()
  def find(client \\ %Client{}, id, owner, repo) do
    get("repos/#{owner}/#{repo}/releases/#{id}", client)
  end

  @doc """
  Get the latest release.

  ## Example

      Tentacat.Releases.latest(client, "elixir-lang", "elixir")

  More info at: http://developer.github.com/v3/repos/releases/#get-the-latest-release

  """
  @spec latest(Client.t(), binary, binary) :: Tentacat.response()
  def latest(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/releases/latest", client)
  end

  @doc """
  Create a new release from the given tag.

  ## Example

      Tentacat.Releases.create(client, "v0.11.0", elixir-lang", "elixir")

  More info at: http://developer.github.com/v3/repos/releases/#create-a-release
  """
  @spec create(Client.t(), binary, binary, binary, map) :: Tentacat.response()
  def create(client \\ %Client{}, tag_name, owner, repo, options \\ %{})
      when is_map(options) and
             is_binary(tag_name) do
    body = Map.merge(options, %{tag_name: tag_name})
    post("repos/#{owner}/#{repo}/releases", client, body)
  end

  @doc """
  Edit an existing release.

  ## Options

    * `tag_name` - string
    * `target_commitish` - string
    * `name` - string
    * `body` - string
    * `draft` - boolean
    * `prerelease` - boolean

  ## Example

      Tentacat.Releases.edit(client, 95071, "elixir-lang", "elixir")

  More info at: http://developer.github.com/v3/repos/releases/#edit-a-release
  """
  @spec edit(Client.t(), integer, binary, binary, map) :: Tentacat.response()
  def edit(client \\ %Client{}, id, owner, repo, options \\ %{})
      when is_integer(id) and is_map(options) do
    patch("repos/#{owner}/#{repo}/releases/#{id}", client, options)
  end

  @doc """
  Delete a release.

  ## Example

      Tentacat.Releases.delete(client, 95071, "elixir-lang", "elixir")

  More info at: http://developer.github.com/v3/repos/releases/#delete-a-release
  """
  @spec delete(Client.t(), integer, binary, binary) :: Tentacat.response()
  def delete(client \\ %Client{}, id, owner, repo) when is_integer(id) do
    delete("repos/#{owner}/#{repo}/releases/#{id}", client)
  end
end
