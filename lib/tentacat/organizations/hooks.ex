defmodule Tentacat.Organizations.Hooks do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List hooks of an organization. The response will differ if the authenticated user is also owner of the organization

  ## Example

      Tentacat.Organizations.Hooks.list "github"
      Tentacat.Organizations.Hooks.list "github", client

  More info at: http://developer.github.com/v3/orgs/hooks/#list-hooks
  """
  @spec list(binary, Client.t) :: Tentacat.response
  def list(organization, client \\ %Client{}) do
    get "orgs/#{organization}/hooks", client
  end

  @doc """
  Get a webhook for an organization by id.

  ## Example

      Tentacat.Organizations.Hooks.find("github", "1234567", client)

  More info at: http://developer.github.com/v3/orgs/hooks/#get-single-hook
  """
  @spec find(binary, binary | integer, Client.t) :: Tentacat.response
  def find(organization, hook_id, client) do
    get "orgs/#{organization}/hooks/#{hook_id}", client
  end

  @doc """
  Create webhook for an organization.

  ## Example

      Tentacat.Organizations.Hooks.create("github", hook_body, client)

  More info at: http://developer.github.com/v3/orgs/hooks/#create-a-hook
  """
  @spec create(binary, list, Client.t) :: Tentacat.response
  def create(organization, body, client) do
    post "orgs/#{organization}/hooks", client, body
  end

  @doc """
    hook_body = %{
      "name" => "web",
      "active" => true,
      "events" => [ "push", "pull_request" ],
      "config" => {
        "url" => "http://example.com/webhook",
        "content_type" => "json"
      }
    }

  ## Example

      Tentacat.Organizations.Hooks.update("github", "1234567", hook_body, client)

  More info at: http://developer.github.com/v3/orgs/hooks/#edit-a-hook
  """
  @spec update(binary, binary | integer, list, Client.t) :: Tentacat.response
  def update(organization, hook_id, body, client) do
    patch "orgs/#{organization}/hooks/#{hook_id}", client, body
  end

  @doc """
  This will trigger a ping event to be sent to the hook.

  ## Example

      Tentacat.Organizations.Hooks.ping("github", "1234567", client)

  More info at: http://developer.github.com/v3/orgs/hooks/#ping-a-hook
  """
  @spec ping(binary, binary | integer, Client.t) :: Tentacat.response
  def ping(organization, hook_id, client) do
    post "orgs/#{organization}/hooks/#{hook_id}/pings", client, ""
  end

  @doc """
  Delete an organization's webhook by it's Id.

  ## Example

      Tentacat.Organizations.Hooks.remove("github", "1234567", client)

  More info at: http://developer.github.com/v3/orgs/hooks/#delete-a-hook
  """
  @spec remove(binary, binary | integer, Client.t) :: Tentacat.response
  def remove(organization, hook_id, client) do
    delete "orgs/#{organization}/hooks/#{hook_id}", client
  end

end
