defmodule Tentacat.Hooks do
  import Tentacat
  alias Tentacat.Client

  @moduledoc """
  The Repository Webhooks API allows repository admins to manage the
  post-receive hooks for a repository.
  """

  @doc """
  Get a list of webhooks for a repository.

  ## Example

      Tentacat.Hooks.list(client, "elixir-lang", "elixir")

  More info at: http://developer.github.com/v3/repos/hooks/#list-hooks
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client, owner, repo) do
    get("repos/#{owner}/#{repo}/hooks", client)
  end

  @doc """
  Get a webhook for a repository by id.

  ## Example

      Tentacat.Hooks.find(client, "elixir-lang", "elixir", "1234567")

  More info at: http://developer.github.com/v3/repos/hooks/#get-single-hook
  """
  @spec find(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def find(client, owner, repo, hook_id) do
    get("repos/#{owner}/#{repo}/hooks/#{hook_id}", client)
  end

  @doc """
  Create webhook for a repository.

  ## Example

      Tentacat.Hooks.create(client, "elixir-lang", "elixir", hook_body)

  More info at: http://developer.github.com/v3/repos/hooks/#create-a-hook
  """
  @spec create(Client.t(), binary, binary, map) :: Tentacat.response()
  def create(client, owner, repo, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/hooks", client, body)
  end

  @doc """
  Update a hook.

  Update body example:

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

      Tentacat.Hooks.update(client, "elixir-lang", "elixir", "1234567", hook_body)

  More info at: http://developer.github.com/v3/repos/hooks/#edit-a-hook
  """
  @spec update(Client.t(), binary, binary, binary | integer, map) :: Tentacat.response()
  def update(client, owner, repo, hook_id, body) when is_map(body) do
    patch("repos/#{owner}/#{repo}/hooks/#{hook_id}", client, body)
  end

  @doc """
  This will trigger the hook with the latest push to the current repository if
  the hook is subscribed to push events.

  If the hook is not subscribed to push events, the server will respond with
  204 but no test POST will be generated.

  ## Example

      Tentacat.Hooks.test(client, "elixir-lang", "elixir", "1234567")

  More info at: http://developer.github.com/v3/repos/hooks/#test-a-push-hook
  """
  @spec test(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def test(client, owner, repo, hook_id) do
    post("repos/#{owner}/#{repo}/hooks/#{hook_id}/test", client, "")
  end

  @doc """
  This will trigger a ping event to be sent to the hook.

  ## Example

      Tentacat.Hooks.ping(client, "elixir-lang", "elixir", "1234567")

  More info at: http://developer.github.com/v3/repos/hooks/#ping-a-hook
  """
  @spec ping(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def ping(client, owner, repo, hook_id) do
    post("repos/#{owner}/#{repo}/hooks/#{hook_id}/pings", client, "")
  end

  @doc """
  Delete a repo's webhook by it's Id.

  ## Example

      Tentacat.Hooks.remove(client, "elixir-lang", "elixir", "1234567")

  More info at: http://developer.github.com/v3/repos/hooks/#delete-a-hook
  """
  @spec remove(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def remove(client, owner, repo, hook_id) do
    delete("repos/#{owner}/#{repo}/hooks/#{hook_id}", client)
  end
end
