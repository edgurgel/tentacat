defmodule Tentacat.Repositories.Projects do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Lists the projects in a repository.

  ## Example

      Tentacat.Repositories.Projects.list client, "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/projects/#list-repository-projects
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client, owner, repo) do
    get("repos/#{owner}/#{repo}/projects", client)
  end

  @doc """
  Create a new project for a repository.

  Possible values for options:

    * %{name: "name of project board"}
    * %{body: "description of the project"}

  ## Example

    Tentacat.Repositories.Projects.create client, "elixir-lang", "elixir", %{name: "tentacat", body: "project board for tentacat"}

  More info at: https://developer.github.com/v3/projects/#create-a-repository-project
  """
  @spec create(Client.t(), binary, binary, map) :: Tentacat.response()
  def create(client, owner, repo, options) when is_map(options) do
    post("repos/#{owner}/#{repo}/projects", client, options)
  end
end
