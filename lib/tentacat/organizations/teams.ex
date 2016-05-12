defmodule Tentacat.Organizations.Teams do
  import Tentacat, [:except, :delete, 2]
  alias Tentacat.Client

  @doc """
  List all public teams for an organization

  ## Example

      Tentacat.Organizations.Teams.list "my_org"
      Tentacat.Organizations.Teams.list "my_org", client

  More info at: https://developer.github.com/v3/orgs/teams/#list-teams
  """
  @spec list(binary, Client.t) :: Tentacat.response
  def list(organization, client \\ %Client{}) do
    get "orgs/#{organization}/teams", client
  end

  @doc """
  Get a team

  ## Example

      Tentacat.Orgnizations.Teams.find "1485060"
      Tentacat.Orgnizations.Teams.find "1485060", client

  More info at: https://developer.github.com/v3/orgs/teams/#get-team
  """
  @spec find(integer, Client.t) :: Tentacat.response
  def find(team_id, client \\ %Client{}) do
    get "teams/#{team_id}", client
  end

  @doc """
  Create a team

  Create body example:

      %{
        "name" => "my new team",
        "description" => "Team for everyone with commit access",
        "repo_names" => [
          "my_org/secret_repo",
          "my_org/secret_repo2",
        ],
        "privacy" => "closed",
      }

  ## Example

      Tentacat.Organizations.Teams.create "my_org", body
      Tentacat.Organizations.Teams.create "my_org", body, client

  More info at: https://developer.github.com/v3/orgs/teams/#create-team
  """
  @spec create(binary, map, Client.t) :: Tentacat.response
  def create(organization, body, client \\ %Client{}) do
    post "orgs/#{organization}/teams", client, body
  end

  @doc """
  Update a team

  Update body example:

      %{
        "name": "Super Admins",
        "description": "Team for everyone with commit and admin access",
      }

  ## Example

      Tentacat.Organizations.Teams.update "1485060", body
      Tentacat.Organizations.Teams.update "1485060", body, client

  More info at: https://developer.github.com/v3/orgs/teams/#edit-team
  """
  @spec update(integer, map, Client.t) :: Tentacat.response
  def update(team_id, options, client \\ %Client{}) do
    patch "teams/#{team_id}", client, options
  end

  @doc """
  Delete a team

  ## Example

      Tentacat.Organizations.Teams.delete "1485060"
      Tentacat.Organizations.Teams.delete "1485060", client

  More info at: https://developer.github.com/v3/orgs/teams/#delete-team
  """
  @spec delete(integer, Client.t) :: Tentacat.response
  def delete(team_id, client \\ %Client{}) do
    Tentacat.delete "teams/#{team_id}", client
  end
end
