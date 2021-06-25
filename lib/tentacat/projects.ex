defmodule Tentacat.Projects do
  import Tentacat, [:except, :delete, 2]
  alias Tentacat.Client

  @doc """
  Get a single `project`.

  ## Example

      Tentacat.Projects.find client, 12345

  More info at: https://developer.github.com/v3/projects/#get-a-project
  """
  @spec find(Client.t(), binary) :: Tentacat.response()
  def find(client, id) do
    get("projects/#{id}", client)
  end

  @doc """
  Update the `project`.

  Possible values for `options`:

    * name: "name of project"
    * body: "description of project"
    * state: "open"
    * organization_permission: "read"
    * private: true

  ## Example

      Tentacat.Projects.update client, %{name: "My Board", private: true}

  More info at: https://developer.github.com/v3/projects/#update-a-project
  """
  @spec update(Client.t(), binary, map) :: Tentacat.response()
  def update(client, id, options) when is_map(options) do
    patch("projects/#{id}", client, options)
  end

  @doc """
  Delete a `project`.

  ## Example

      Tentacat.Projects.delete client, 12345

  More info at: https://developer.github.com/v3/projects/#delete-a-project
  """
  @spec delete(Client.t(), binary) :: Tentacat.response()
  def delete(client, id) do
    Tentacat.delete("projects/#{id}", client)
  end
end
