defmodule Tentacat.Teams.Repositories do
  import Tentacat, [:except, :delete, 2]
  alias Tentacat.Client

  @doc """
  List all team repositories

  ## Example

      Tentacat.Teams.Repositories.list 210840
      Tentacat.Teams.Repositories.list 210840, client

  More info at: https://developer.github.com/v3/orgs/teams/#list-team-repos
  """
  @spec list(integer, Client.t) :: Tentacat.response
  def list(team_id, client \\ %Client{}) do
    get "teams/#{team_id}/repos", client
  end
end
