defmodule Tentacat.Organizations.Projects do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Lists the projects in an organization.

  ## Example

      Tentacat.Organizations.Projects.list client, "elixir"

  More info at: https://developer.github.com/v3/projects/#list-organization-projects
  """
  @spec list(Client.t(), binary) :: Tentacat.response()
  def list(client, organization) do
    get("orgs/#{organization}/projects", client)
  end

  @doc """
  Create a new project for an organization.

  Possible values for options:

    * %{name: "name of project board"}
    * %{body: "description of the project"}

  ## Example

    Tentacat.Organizations.Projects.create client, "elixir-lang", %{ name: "tentacat", body: "project board for tentacat"}

  More info at: https://developer.github.com/v3/projects/#create-an-organization-project
  """
  @spec create(Client.t(), binary, map) :: Tentacat.response()
  def create(client, organization, options) when is_map(options) do
    post("orgs/#{organization}/projects", client, options)
  end
end
