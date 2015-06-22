defmodule Tentacat.Repositories.Deployments do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List Deployments

  ## Example

      Tentacat.Repositories.Deployments.list "elixir-lang", "elixir"
      Tentacat.Repositories.Deployments.list "elixir-lang", "elixir", client

  More info at: https://developer.github.com/v3/repos/deployments/#list-deployments
  """
  @spec list(binary, binary, Client.t) :: Tentacat.response
  def list(owner, repo, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/deployments", client
  end

  @doc """
  Create a Deployment

  Deployment body example:
  ```
  %{
    "ref": "topic-branch",
    "payload": "{\"user\":\"atmos\",\"room_id\":123456}",
    "description": "Deploying my sweet branch"
  }
  ```

  ## Example

      Tentacat.Repositories.Deployments.create "elixir-lang", "elixir", deployment_body, client

  More info at: https://developer.github.com/v3/repos/deployments/#create-a-deployment
  """
  @spec create(binary, binary, list | map, Client.t) :: Tentacat.response
  def create(owner, repo, body, client ) do
    post "repos/#{owner}/#{repo}/deployments", client, body
  end

  @doc """
  List a Deployment's Statuses

  ## Example

      Tentacat.Repositories.Deployments.list_statuses "elixir-lang", "elixir", "1"
      Tentacat.Repositories.Deployments.list_statuses "elixir-lang", "elixir", "1", client

  More info at: https://developer.github.com/v3/repos/deployments/#list-deployment-statuses
  """
  @spec list_statuses(binary, binary, binary | integer, Client.t) :: Tentacat.response
  def list_statuses(owner, repo, id, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/deployments/#{id}/statuses", client
  end

  @doc """
  Create a Deployment Status

  Status body example:
  ```
  %{
    "state": "success",
    "target_url": "https://example.com/deployment/1/output",
    "description": "Deployment finished successfully."
  }
  ```

  ## Example

      Tentacat.Repositories.Deployments.create_status "elixir-lang", "elixir", "1", status_body, client

  More info at: https://developer.github.com/v3/repos/deployments/#create-a-deployment-status
  """
  @spec create_status(binary, binary, binary, list | map, Client.t) :: Tentacat.response
  def create_status(owner, repo, id, body, client) do
    post "repos/#{owner}/#{repo}/deployments/#{id}/statuses", client, body
  end
end
