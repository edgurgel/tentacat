defmodule Tentacat.Repositories.Projects do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Lists the projects in a repository

  ## Example

      Tentacat.Repositories.Projects.list client, "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/projects/#list-repository-projects
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client, owner, repo) do
    get("repos/#{owner}/#{repo}/projects", client)
  end
end
