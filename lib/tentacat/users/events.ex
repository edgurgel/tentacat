defmodule Tentacat.Users.Events do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List events performed by a user

  ## Example

      Tentacat.Users.Events.list "bastos"
      Tentacat.Users.Events.list client, "bastos"

  More info at: https://developer.github.com/v3/activity/events/#list-events-performed-by-a-user
  """
  @spec list(Client.t(), binary) :: Tentacat.response()
  def list(client \\ %Client{}, user) do
    get("users/#{user}/events", client)
  end

  @doc """
  List events performed by a user since last check represented by e_tag

  ## Example

      Tentacat.Users.Events.list client, "bastos"
      Tentacat.Users.Events.list client, "bastos", "2a97f8e2fba8b548ae56bce4074f25cc00674f213963d2f8cf579b8a3"

  More info at: https://developer.github.com/v3/activity/events/#list-events-performed-by-a-user
  """

  def list(client, user, e_tag) do
    get("users/#{user}/events", client, [], [], [{"If-None-Match", "\"#{e_tag}\""}])
  end

  @doc """
  List public events performed by a user

  ## Example

      Tentacat.Users.Events.list_public "bastos"
      Tentacat.Users.Events.list_public client, "bastos"

  More info at: https://developer.github.com/v3/activity/events/#list-public-events-performed-by-a-user
  """
  @spec list_public(Client.t(), binary) :: Tentacat.response()
  def list_public(client \\ %Client{}, user) do
    get("users/#{user}/events/public", client)
  end

  @doc """
  List public events performed by a user since last check represented by e_tag

  ## Example

      Tentacat.Users.Events.list_public client, "bastos"
      Tentacat.Users.Events.list_public client, "bastos", "2a97f8e2fba8b548ae56bce4074f25cc00674f213963d2f8cf579b8a3"

  More info at: https://developer.github.com/v3/activity/events/#list-public-events-performed-by-a-user
  """
  @spec list_public(Client.t(), binary, binary) :: Tentacat.response()
  def list_public(client, user, e_tag) do
    get("users/#{user}/events/public", client, [], [], [{"If-None-Match", "\"#{e_tag}\""}])
  end

  @doc """
  List events for an organization

  ## Example

      Tentacat.Users.Events.list_user_org client, "bastos", "elixir-lang"

  More info at: https://developer.github.com/v3/activity/events/#list-events-for-an-organization
  """
  @spec list_user_org(Client.t(), binary, binary) :: Tentacat.response()
  def list_user_org(client, user, org) do
    get("users/#{user}/events/orgs/#{org}", client)
  end

  @doc """
  List public events that a user has received

  ## Example

      Tentacat.Users.Events.list_received_public client, "bastos"

  More info at: https://developer.github.com/v3/activity/events/#list-public-events-that-a-user-has-received
  """
  @spec list_received_public(Client.t(), binary) :: Tentacat.response()
  def list_received_public(client \\ %Client{}, user) do
    get("users/#{user}/received_events/public", client)
  end
end
