defmodule Tentacat.Repositories.Statuses do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List Statuses for a specific Ref

  ## Example

      Tentacat.Repositories.Statuses.list "elixir-lang", "elixir", "a8ce2485b1260245a331f1a56c53ab1b965d6dc5"
      Tentacat.Repositories.Statuses.list "elixir-lang", "elixir", "master", client
      Tentacat.Repositories.Statuses.list "elixir-lang", "elixir", "1.2.4", client

  More info at: https://developer.github.com/v3/repos/statuses/#list-statuses-for-a-specific-ref
  """
  @spec list(binary, binary, binary, Client.t) :: Tentacat.response
  def list(owner, repo, ref, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/commits/#{ref}/statuses", client.auth
  end

  @doc """
  Get the combined Status for a specific Ref

  ## Example

      Tentacat.Repositories.Statuses.find "elixir-lang", "elixir", "a8ce2485b1260245a331f1a56c53ab1b965d6dc5"
      Tentacat.Repositories.Statuses.find "elixir-lang", "elixir", "master", client
      Tentacat.Repositories.Statuses.find "elixir-lang", "elixir", "1.2.4", client

  More info at: https://developer.github.com/v3/repos/statuses/#get-the-combined-status-for-a-specific-ref
  """
  @spec find(binary, binary, binary, Client.t) :: Tentacat.response
  def find(owner, repo, ref, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/commits/#{ref}/status", client.auth
  end

  @doc """
  Create a Status

  Comment body example:
  ```
  %{
     "state": "success",
     "target_url": "https://example.com/build/status",
     "description": "The build succeeded!",
     "context": "continuous-integration/jenkins"
   }
  ```

  ## Example

      Tentacat.Repositories.Statuses.create "elixir-lang", "elixir", 2974, comment_body, client

  More info at: https://developer.github.com/v3/repos/statuses/#create-a-status
  """
  @spec create(binary, binary, binary, list | map, Client.t) :: Tentacat.response
  def create(owner, repo, sha, body, client) do
    post "repos/#{owner}/#{repo}/statuses/#{sha}", client.auth, body
  end
end
