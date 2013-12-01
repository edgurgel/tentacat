defmodule Tentacat.Releases.Assets do
  import Tentacat.Client.Base
  alias Tentacat.Client

  @upload_url "https://uploads.github.com/"

  #
  # Public API
  #

  @doc """
  Get all assets for the given release

  ## Example

      Tentacat.Releases.Assets.list(95071, "elixir-lang", "elixir", client)

  More info at: http://developer.github.com/v3/repos/releases/#list-assets-for-a-release
  """
  @spec list(integer, binary, binary, Client.t) :: Base.response
  def list(id, owner, repo, client // Client.new) when is_integer(id) do
    get "repos/#{owner}/#{repo}/releases/#{id}/assets", client.auth
  end

  @doc """
  Get a single release asset

  ## Example

      Tentacat.Releases.Assets.find(23, "elixir-lang", "elixir", client)

  More info at: http://developer.github.com/v3/repos/releases/#get-a-single-release-asset
  """
  @spec find(integer, binary, binary, Client.t) :: Base.response
  def find(id, owner, repo, client // Client.new) when is_integer(id) do
    get "repos/#{owner}/#{repo}/releases/assets/#{id}", client.auth
  end

  @doc """
  Edit a release asset

  ## Example

      Tentacat.Releases.Assets.edit("my-release.tar.gz", 23, "elixir-lang", "elixir", client, label: "NEW LABEL!")

  ## Options

  * `label` - string

  More info at: http://developer.github.com/v3/repos/releases/#edit-a-release-asset
  """
  @spec edit(binary, integer, binary, binary, Client.t, list) :: Base.response
  def edit(name, id, owner, repo, client // Client.new, options // []) when is_integer(id) do
    body = ListDict.merge(options, name: name)
    patch "repos/#{owner}/#{repo}/releases/assets/#{id}", client.auth, body
  end

  @doc """
  Delete a release asset

  ## Example

      Tentacat.Releases.Assets.delete("23", "elixir-lang", "elixir", client)

  More info at: http://developer.github.com/v3/repos/releases/#delete-a-release-asset
  """
  @spec delete(integer, binary, binary, Client.t) :: Base.response
  def delete(id, owner, repo, client // Client.new) when is_integer(id) do
    delete "repos/#{owner}/#{repo}/releases/assets/#{id}", client.auth
  end

  #
  # Private
  #

  defp upload_url(url), do: @upload_url <> url

  defp upload_header(headers, [content_type: content_type]) do
    headers ++ [{"Content-Type", content_type}]
  end

  defp upload_header(headers, _), do: headers
end
