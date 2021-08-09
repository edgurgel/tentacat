defmodule Tentacat.Organizations.Hooks do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List hooks of an organization.

  The response will differ if the authenticated user is also owner of the
  organization

  ## Example

      Tentacat.Organizations.Hooks.list "github"
      Tentacat.Organizations.Hooks.list client, "github"

  More info at: http://developer.github.com/v3/orgs/hooks/#list-hooks
  """
  @spec list(Client.t(), binary) :: Tentacat.response()
  def list(client \\ %Client{}, organization) do
    get("orgs/#{organization}/hooks", client)
  end

  @doc """
  Get a webhook for an organization by id.

  ## Example

      Tentacat.Organizations.Hooks.find(client, "github", "1234567")

  More info at: http://developer.github.com/v3/orgs/hooks/#get-single-hook
  """
  @spec find(Client.t(), binary, binary | integer) :: Tentacat.response()
  def find(client, organization, hook_id) do
    get("orgs/#{organization}/hooks/#{hook_id}", client)
  end

  @doc """
  Create webhook for an organization.

  ## Example

      Tentacat.Organizations.Hooks.create(client, "github", hook_body)

  More info at: http://developer.github.com/v3/orgs/hooks/#create-a-hook
  """
  @spec create(Client.t(), binary, list) :: Tentacat.response()
  def create(client, organization, body) when is_map(body) do
    post("orgs/#{organization}/hooks", client, body)
  end

  @doc """
  Update organization.

  Sample body content:

  ```elixir
  hook_body = %{
    "name" => "web",
    "active" => true,
    "events" => [ "push", "pull_request" ],
    "config" => {
      "url" => "http://example.com/webhook",
      "content_type" => "json"
    }
  }
  ```

  ## Example

      Tentacat.Organizations.Hooks.update(client, "github", "1234567", hook_body)

  More info at: http://developer.github.com/v3/orgs/hooks/#edit-a-hook
  """
  @spec update(Client.t(), binary, binary | integer, map) :: Tentacat.response()
  def update(client, organization, hook_id, body) when is_map(body) do
    patch("orgs/#{organization}/hooks/#{hook_id}", client, body)
  end

  @doc """
  This will trigger a ping event to be sent to the hook.

  ## Example

      Tentacat.Organizations.Hooks.ping(client, "github", "1234567")

  More info at: http://developer.github.com/v3/orgs/hooks/#ping-a-hook
  """
  @spec ping(Client.t(), binary, binary | integer) :: Tentacat.response()
  def ping(client, organization, hook_id) do
    post("orgs/#{organization}/hooks/#{hook_id}/pings", client, "")
  end

  @doc """
  Delete an organization's webhook by it's Id.

  ## Example

      Tentacat.Organizations.Hooks.remove(client, "github", "1234567")

  More info at: http://developer.github.com/v3/orgs/hooks/#delete-a-hook
  """
  @spec remove(Client.t(), binary, binary | integer) :: Tentacat.response()
  def remove(client, organization, hook_id) do
    delete("orgs/#{organization}/hooks/#{hook_id}", client)
  end
end
