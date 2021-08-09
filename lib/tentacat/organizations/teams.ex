defmodule Tentacat.Organizations.Teams do
  import Tentacat, [:except, :delete, 2]
  alias Tentacat.Client

  @doc """
  List all public teams for an organization.

  ## Example

      Tentacat.Organizations.Teams.list "my_org"
      Tentacat.Organizations.Teams.list client, "my_org"

  More info at: https://developer.github.com/v3/orgs/teams/#list-teams
  """
  @spec list(Client.t(), binary) :: Tentacat.response()
  def list(client \\ %Client{}, organization) do
    get("orgs/#{organization}/teams", client)
  end

  @doc """
  Get a team.

  ## Example

      Tentacat.Orgnizations.Teams.find "1485060"
      Tentacat.Orgnizations.Teams.find client, "1485060"

  More info at: https://developer.github.com/v3/orgs/teams/#get-team
  """
  @spec find(Client.t(), integer) :: Tentacat.response()
  def find(client \\ %Client{}, team_id) do
    get("teams/#{team_id}", client)
  end

  @doc """
  Create a team.

  Create body example:

  ```elixir
  %{
    "name" => "my new team",
    "description" => "Team for everyone with commit access",
    "repo_names" => [
      "my_org/secret_repo",
      "my_org/secret_repo2",
    ],
    "privacy" => "closed",
  }
  ```

  ## Example

      Tentacat.Organizations.Teams.create client, "my_org", body

  More info at: https://developer.github.com/v3/orgs/teams/#create-team
  """
  @spec create(Client.t(), binary, map) :: Tentacat.response()
  def create(client, organization, body) do
    post("orgs/#{organization}/teams", client, body)
  end

  @doc """
  Update a team.

  Update body example:

  ```elixir
  %{
    "name": "Super Admins",
    "description": "Team for everyone with commit and admin access",
  }
  ```

  ## Example

      Tentacat.Organizations.Teams.update client, "1485060", body

  More info at: https://developer.github.com/v3/orgs/teams/#edit-team
  """
  @spec update(Client.t(), integer, map) :: Tentacat.response()
  def update(client, team_id, options) do
    patch("teams/#{team_id}", client, options)
  end

  @doc """
  Delete a team.

  ## Example

      Tentacat.Organizations.Teams.delete client, "1485060"

  More info at: https://developer.github.com/v3/orgs/teams/#delete-team
  """
  @spec delete(Client.t(), integer) :: Tentacat.response()
  def delete(client, team_id) do
    Tentacat.delete("teams/#{team_id}", client)
  end
end
