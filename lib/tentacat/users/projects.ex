defmodule Tentacat.Users.Projects do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Lists the projects for a user.

  ## Example

      Tentacat.Organizations.Projects.list client, "achiurizo"

  More info at: https://developer.github.com/v3/projects/#list-organization-projects
  """
  @spec list(Client.t(), binary) :: Tentacat.response()
  def list(client, user) do
    get("users/#{user}/projects", client)
  end

  @doc """
  Create a new project for the authenticated user via passing a `client` with necessary credentials.

  Possible values for options:

    * [name: "name of project board"]
    * [body: "description of the project"]

  ## Example

    Tentacat.Users.Projects.create client, name: "tentacat", body: "project board for tentacat"

  More info at: https://developer.github.com/v3/projects/#create-a-user-project
  """
  @spec create(Client.t(), list) :: Tentacat.response()
  def create(client, options) do
    post("user/projects", client, options)
  end
end
