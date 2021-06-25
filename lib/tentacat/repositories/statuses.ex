defmodule Tentacat.Repositories.Statuses do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List Statuses for a specific Ref.

  ## Example

      Tentacat.Repositories.Statuses.list "elixir-lang", "elixir", "a8ce2485b1260245a331f1a56c53ab1b965d6dc5"
      Tentacat.Repositories.Statuses.list client, "elixir-lang", "elixir", "master"
      Tentacat.Repositories.Statuses.list client, "elixir-lang", "elixir", "1.2.4"

  More info at: https://developer.github.com/v3/repos/statuses/#list-statuses-for-a-specific-ref
  """
  @spec list(Client.t(), binary, binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo, ref) do
    get("repos/#{owner}/#{repo}/commits/#{ref}/statuses", client)
  end

  @doc """
  Get the combined Status for a specific Ref.

  ## Example

      Tentacat.Repositories.Statuses.find "elixir-lang", "elixir", "a8ce2485b1260245a331f1a56c53ab1b965d6dc5"
      Tentacat.Repositories.Statuses.find client, "elixir-lang", "elixir", "master"
      Tentacat.Repositories.Statuses.find client, "elixir-lang", "elixir", "1.2.4"

  More info at: https://developer.github.com/v3/repos/statuses/#get-the-combined-status-for-a-specific-ref
  """
  @spec find(Client.t(), binary, binary, binary) :: Tentacat.response()
  def find(client \\ %Client{}, owner, repo, ref) do
    get("repos/#{owner}/#{repo}/commits/#{ref}/status", client)
  end

  @doc """
  Create a Status.

  Comment body example:

  ```elixir
  %{
     "state": "success",
     "target_url": "https://example.com/build/status",
     "description": "The build succeeded!",
     "context": "continuous-integration/jenkins"
   }
  ```

  ## Example

      Tentacat.Repositories.Statuses.create client, "elixir-lang", "elixir", 2974, comment_body

  More info at: https://developer.github.com/v3/repos/statuses/#create-a-status
  """
  @spec create(Client.t(), binary, binary, binary, map) :: Tentacat.response()
  def create(client, owner, repo, sha, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/statuses/#{sha}", client, body)
  end
end
