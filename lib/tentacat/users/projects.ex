defmodule Tentacat.Users.Projects do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Lists the projects for a user

  ## Example

      Tentacat.Organizations.Projects.list client, "achiurizo"

  More info at: https://developer.github.com/v3/projects/#list-organization-projects
  """
  @spec list(Client.t(), binary) :: Tentacat.response()
  def list(client, user) do
    get("users/#{user}/projects", client)
  end
end
