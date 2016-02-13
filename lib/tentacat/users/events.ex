defmodule Tentacat.Users.Events do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List events performed by a user

  ## Example

      Tentacat.Users.Events.list "bastos", client
      Tentacat.Users.Events.list "bastos"

  More info at: https://developer.github.com/v3/activity/events/#list-events-performed-by-a-user
  """
  @spec list(binary, Client.t) :: Tentacat.response
  def list(user, client \\ %Client{}) do
    get "users/#{user}/events", client
  end

  @doc """
  List public events performed by a user

  ## Example

      Tentacat.Users.Events.list_public "bastos", client
      Tentacat.Users.Events.list_public "bastos"

  More info at: https://developer.github.com/v3/activity/events/#list-public-events-performed-by-a-user
  """
  @spec list_public(binary, Client.t) :: Tentacat.response
  def list_public(user, client \\ %Client{}) do
    get "users/#{user}/events/public", client
  end

  @doc """
  List events for an organization

  ## Example

      Tentacat.Users.Events.list_user_org "bastos", "elixir-lang",  client

  More info at: https://developer.github.com/v3/activity/events/#list-events-for-an-organization
  """
  @spec list_user_org(binary, binary, Client.t) :: Tentacat.response
  def list_user_org(user, org, client) do
    get "users/#{user}/events/orgs/#{org}", client
  end
end
