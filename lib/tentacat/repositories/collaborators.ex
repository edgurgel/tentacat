defmodule Tentacat.Repositories.Collaborators do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List collaborators for a specific repository.

  ## Example

      Tentacat.Repositories.Collaborators.list "elixir-lang", "elixir"
      Tentacat.Repositories.Collaborators.list client, "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/repos/collaborators/#list-collaborators
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/collaborators", client)
  end

  @doc """
  Check if a user is a collaborator.

  ## Example

      Tentacat.Repositories.Collaborators.collaborator? "elixir-lang", "elixir", "username"
      Tentacat.Repositories.Collaborators.collaborator? client, "elixir-lang", "elixir", "username"

  More info at: https://developer.github.com/v3/repos/collaborators/#check-if-a-user-is-a-collaborator
  """
  @spec collaborator?(Client.t(), binary, binary, binary) :: Tentacat.response()
  def collaborator?(client \\ %Client{}, owner, repo, username) do
    get("repos/#{owner}/#{repo}/collaborators/#{username}", client)
  end

  @doc """
  Returns the permission level of a collaborator.

  ## Example

      Tentacat.Repositories.Collaborators.permission "elixir-lang", "elixir", "username"
      Tentacat.Repositories.Collaborators.permission client, "elixir-lang", "elixir", "username"

  More info at: https://developer.github.com/v3/repos/collaborators/#review-a-users-permission-level
  """
  @spec permission(Client.t(), binary, binary, binary) :: Tentacat.response()
  def permission(client \\ %Client{}, owner, repo, username) do
    get("repos/#{owner}/#{repo}/collaborators/#{username}/permission", client)
  end

  @doc """
  Add user as a collaborator.

  ## Example

      Tentacat.Repositories.Collaborators.add "elixir-lang", "elixir", "username", %{}
      Tentacat.Repositories.Collaborators.add client, "elixir-lang", "elixir", "username", %{ permission: "push" }
      Tentacat.Repositories.Collaborators.add client, "elixir-lang", "elixir", "username", %{}

  More info at: https://developer.github.com/v3/repos/collaborators/#add-user-as-a-collaborator
  """
  @spec add(Client.t(), binary, binary, binary, map) :: Tentacat.response()
  def add(client \\ %Client{}, owner, repo, username, body) do
    put("repos/#{owner}/#{repo}/collaborators/#{username}", client, body)
  end

  @doc """
  Remove user as a collaborator.

  ## Example

      Tentacat.Repositories.Collaborators.delete "elixir-lang", "elixir", "username"
      Tentacat.Repositories.Collaborators.delete client, "elixir-lang", "elixir", "username"

  More info at: https://developer.github.com/v3/repos/collaborators/#remove-user-as-a-collaborator
  """
  @spec delete(Client.t(), binary, binary, binary) :: Tentacat.response()
  def delete(client \\ %Client{}, owner, repo, username) do
    Tentacat.delete("repos/#{owner}/#{repo}/collaborators/#{username}", client)
  end
end
