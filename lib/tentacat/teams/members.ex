defmodule Tentacat.Teams.Members do
  import Tentacat, [:except, :delete, 2]
  alias Tentacat.Client

  @doc """
  List all team members.

  ## Example

      Tentacat.Teams.Members.list 210840
      Tentacat.Teams.Members.list client, 210840

  More info at: https://developer.github.com/v3/orgs/teams/#list-team-members
  """
  @spec list(Client.t(), integer) :: Tentacat.response()
  def list(client \\ %Client{}, team_id) do
    get("teams/#{team_id}/members", client)
  end

  @doc """
  Get a team membership.

  ## Example

      Tentacat.Teams.Members.find 210840, "username"
      Tentacat.Teams.Members.find client, 210840, "username"

  More info at: https://developer.github.com/v3/orgs/teams/#get-team-membership
  """
  @spec find(Client.t(), integer, binary) :: Tentacat.response()
  def find(client \\ %Client{}, team_id, username) do
    get("teams/#{team_id}/memberships/#{username}", client)
  end

  @doc """
  Add a user to a team.

  ## Example

      Tentacat.Teams.Members.create client, 210840, "username", %{ role: "maintainer" }
      Tentacat.Teams.Members.create client, 210840, "username", %{}

  More info at: https://developer.github.com/v3/orgs/teams/#add-team-membership
  """
  @spec create(Client.t(), integer, binary, map) :: Tentacat.response()
  def create(client, team_id, username, body) do
    put("teams/#{team_id}/memberships/#{username}", client, body)
  end

  @doc """
  Remove a user from a team.

  ## Example

      Tentacat.Teams.Members.delete client, 210840, "username"
  """
  @spec delete(Client.t(), integer, binary) :: Tentacat.response()
  def delete(client, team_id, username) do
    Tentacat.delete("teams/#{team_id}/memberships/#{username}", client)
  end
end
