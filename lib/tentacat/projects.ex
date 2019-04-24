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

  @doc """
  Update the `project`

  Possible values for `options`:

  * [name: "name of project"]
  * [body: "description of project"]
  * [state: "open"]
  * [organization_permission: "read"]
  * [private: true]

  ## Example

      Tentcat.Projects.update client, [name: "My Board", private: true]

  More info at: https://developer.github.com/v3/projects/#update-a-project
  """
  @spec update(Client.t(), binary, Keyword.t()) :: Tentcat.response()
  def update(client, id, options) do
    patch("projects/#{id}", client, options)
  end


end
