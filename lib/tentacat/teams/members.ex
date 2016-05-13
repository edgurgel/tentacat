defmodule Tentacat.Teams.Members do
  import Tentacat, [:except, :delete, 2]
  alias Tentacat.Client

  @doc """
  List all team members

  ## Example

      Tentacat.Teams.Members.list 210840
      Tentacat.Teams.Members.list 210840, client

  More info at: https://developer.github.com/v3/orgs/teams/#list-team-members
  """
  @spec list(integer, Client.t) :: Tentacat.response
  def list(team_id, client \\ %Client{}) do
    get "teams/#{team_id}/members", client
  end

  @doc """
  Get a team membership

  ## Example

      Tentacat.Teams.Members.find 210840, "username"
      Tentacat.Teams.Members.find 210840, "username", client

  More info at: https://developer.github.com/v3/orgs/teams/#get-team-membership
  """
  @spec find(integer, binary, Client.t) :: Tentacat.response
  def find(team_id, username, client \\ %Client{}) do
    get "teams/#{team_id}/memberships/#{username}", client
  end

  @doc """
  Add a user to a team

  ## Example

      Tentacat.Teams.Members.create 210840, "username", %{}
      Tentacat.Teams.Members.create 210840, "username", %{ role: "maintainer" }, client
      Tentacat.Teams.Members.create 210840, "username", %{}, client

  More info at: https://developer.github.com/v3/orgs/teams/#add-team-membership
  """
  @spec create(integer, binary, map, Client.t) :: Tentacat.response
  def create(team_id, username, body, client \\ %Client{}) do
    put "teams/#{team_id}/memberships/#{username}", client, body
  end

  @doc """
  Remove a user from a team

  ## Example

      Tentacat.Teams.Members.delete 210840, "username"
      Tentacat.Teams.Members.delete 210840, "username", client
  """
  @spec delete(integer, binary, Client.t) :: Tentacat.response
  def delete(team_id, username, client \\ %Client{}) do
    Tentacat.delete "teams/#{team_id}/memberships/#{username}", client
  end
end
