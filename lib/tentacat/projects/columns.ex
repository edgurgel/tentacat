defmodule Tentacat.Projects.Columns do
  import Tentacat, [:except, :delete, 2]
  alias Tentacat.Client

  @doc """
  List project columns

  ## Example

      Tentacat.Projects.Columns.list 1234
      Tentacat.Projects.Columns.list client, 1234

  More info at: https://developer.github.com/v3/projects/columns/#list-project-columns
  """
  @spec list(Client.t(), binary) :: Tentacat.response()
  def list(client \\ %Client{}, project_id) do
    get("projects/#{project_id}/columns", client)
  end
end
