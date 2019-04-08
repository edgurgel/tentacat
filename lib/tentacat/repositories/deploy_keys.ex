defmodule Tentacat.Repositories.DeployKeys do
  import Tentacat
  alias Tentacat.Client

  @moduledoc """
  The Repository deploy keys API allows repository admins to manage the deploy keys for a repository.
  """

  @doc """
  Get a list of deploy keys for a repository.

  ## Example

      Tentacat.Repositories.DeployKeys.list(client, "elixir-lang", "elixir")

  More info at: https://developer.github.com/v3/repos/keys/#list-deploy-keys
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client, owner, repo) do
    get("repos/#{owner}/#{repo}/keys", client)
  end

  @doc """
  Get a deploy key for a repository by id.

  ## Example

      Tentacat.Repositories.DeployKeys.find(client, "elixir-lang", "elixir", "1234567")

  More info at: https://developer.github.com/v3/repos/keys/#get-a-deploy-key
  """
  @spec find(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def find(client, owner, repo, key_id) do
    get("repos/#{owner}/#{repo}/keys/#{key_id}", client)
  end

end
