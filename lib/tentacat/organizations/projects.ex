defmodule Tentacat.Organizations.Projects do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Lists the projects in an organization

  ## Example

      Tentacat.Organizations.Projects.list client, "elixir"

  More info at: https://developer.github.com/v3/projects/#list-organization-projects
  """
  @spec list(Client.t(), binary) :: Tentacat.response()
  def list(client, organization) do
    get("orgs/#{organization}/projects", client)
  end
end
