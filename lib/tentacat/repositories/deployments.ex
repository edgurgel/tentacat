defmodule Tentacat.Repositories.Deployments do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List Deployments.

  ## Example

      Tentacat.Repositories.Deployments.list "elixir-lang", "elixir"
      Tentacat.Repositories.Deployments.list client, "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/repos/deployments/#list-deployments
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/deployments", client)
  end

  @doc """
  Create a Deployment.

  Deployment body example:

  ```elixir
  %{
    "ref": "topic-branch",
    "payload": "{\"user\":\"atmos\",\"room_id\":123456}",
    "description": "Deploying my sweet branch"
  }
  ```

  ## Example

      Tentacat.Repositories.Deployments.create client, "elixir-lang", "elixir", deployment_body

  More info at: https://developer.github.com/v3/repos/deployments/#create-a-deployment
  """
  @spec create(Client.t(), binary, binary, map) :: Tentacat.response()
  def create(client, owner, repo, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/deployments", client, body)
  end

  @doc """
  List a Deployment's Statuses.

  ## Example

      Tentacat.Repositories.Deployments.list_statuses "elixir-lang", "elixir", "1"
      Tentacat.Repositories.Deployments.list_statuses client, "elixir-lang", "elixir", "1"

  More info at: https://developer.github.com/v3/repos/deployments/#list-deployment-statuses
  """
  @spec list_statuses(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def list_statuses(client \\ %Client{}, owner, repo, id) do
    get("repos/#{owner}/#{repo}/deployments/#{id}/statuses", client)
  end

  @doc """
  Create a Deployment Status.

  Status body example:

  ```elixir
  %{
    "state": "success",
    "target_url": "https://example.com/deployment/1/output",
    "description": "Deployment finished successfully."
  }
  ```

  ## Example

      Tentacat.Repositories.Deployments.create_status client, "elixir-lang", "elixir", "1", status_body

  More info at: https://developer.github.com/v3/repos/deployments/#create-a-deployment-status
  """
  @spec create_status(Client.t(), binary, binary, binary, map) :: Tentacat.response()
  def create_status(client, owner, repo, id, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/deployments/#{id}/statuses", client, body)
  end
end
