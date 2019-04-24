defmodule Tentacat.Projects do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Get a single `project`

  ## Example

      Tentacat.Projects.find client, 12345

  More info at: https://developer.github.com/v3/projects/#get-a-project
  """
  @spec find(Client.t(), binary) :: Tentacat.response()
  def find(client \\ %Client{}, id) do
    get("projects/#{id}", client)
  end


end
