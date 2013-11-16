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

  # Uncomment when R17 has been released. The upload endpoint requires SNI to function.
  # Here is the commit in Erlang where SNI was added:
  #   https://github.com/erlang/otp/commit/bc8b6bf58c96f8d5a07146ddea145f71fe8c8956
  #
  # @doc """
  # Upload a release asset
  #
  # ## Example
  #
  #     Tentacat.Releases.Assets.upload("my-release.tar.gz", 23, "elixir-lang", "elixir", client)
  #
  # ## Options
  #
  # * `label` - string
  #
  # More info at: http://developer.github.com/v3/repos/releases/#upload-a-release-asset
  # """
  # @spec upload(binary, integer, binary, Client.t, list) :: Base.response
  # def upload(asset, id, owner, repo, client // Client.new, options // []) when is_integer(id) do
  #   # This needs to be a stream but HTTPotion needs to be updated to support streaming request/responses.
  #   contents     = File.read!(asset)
  #   label        = options[:label] || Path.basename(asset)
  #   content_type = options[:content_type] || "application/zip"
  #   url          = upload_url("repos/#{owner}/#{repo}/releases/#{id}/assets?name=#{URI.encode(label)}")
  #   headers      = authorization_header(client.auth) |> upload_header(content_type: content_type)
  #   IO.inspect url
  #   IO.inspect headers
  #   raw_request(:post, url, contents, headers)
  # end

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
