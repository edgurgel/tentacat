defmodule Tentacat.Teams.Repositories do
  import Tentacat, [:except, :delete, 2]
  alias Tentacat.Client

  @doc """
  List all team repositories

  ## Example

      Tentacat.Teams.Repositories.list 210840
      Tentacat.Teams.Repositories.list client, 210840

  More info at: https://developer.github.com/v3/orgs/teams/#list-team-repos
  """
  @spec list(Client.t(), integer) :: Tentacat.response()
  def list(client \\ %Client{}, team_id) do
    get("teams/#{team_id}/repos", client)
  end
end
