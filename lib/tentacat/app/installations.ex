defmodule Tentacat.App.Installations do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List installations for the authorized app

  ## Example

      Tentacat.App.Installations.list_mine client

  More info at: https://developer.github.com/v3/apps/#find-installations
  """
  @spec list_mine(Client.t) :: Tentacat.response
  def list_mine(client) do
    get "app/installations", client
  end

  @doc """
  Get a specific installation

  ## Example

      Tentacat.App.Installations.find 12, client

  More info at: https://developer.github.com/v3/apps/#get-a-single-installation
  """
  @spec find(integer, Client.t) :: Tentacat.response
  def find(installation_id, client) do
    get "app/installations/#{installation_id}", client
  end

  @doc """
  Get an authorization token for an installation

  ## Example

      Tentacat.App.Installations.token 12, client

  More info at: https://developer.github.com/v3/apps/#create-a-new-installation-token
  """
  @spec token(integer, Client.t) :: Tentacat.response
  def token(installation_id, client) do
    post "app/installations/#{installation_id}/access_tokens", client
  end

end
