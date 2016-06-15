defmodule Tentacat.Repositories.Collaborators do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List collaborators for a specific repository

  ## Example
      Tentacat.Repositories.Collaborators.list "elixir-lang", "elixir"
      Tentacat.Repositories.Collaborators.list "elixir-lang", "elixir", client

  More info at: https://developer.github.com/v3/repos/collaborators/#list-collaborators
  """
  @spec list(binary, binary, Client.t) :: Tentacat.response
  def list(owner, repo, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/collaborators", client
  end

  @doc """
  Check if a user is a collaborator

  ## Example
      Tentacat.Repositories.Collaborators.collaborator? "elixir-lang", "elixir", "username"
      Tentacat.Repositories.Collaborators.collaborator? "elixir-lang", "elixir", "username", client

  More info at: https://developer.github.com/v3/repos/collaborators/#check-if-a-user-is-a-collaborator
  """
  @spec collaborator?(binary, binary, binary, Client.t) :: Tentacat.response
  def collaborator?(owner, repo, username, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/collaborators/#{username}", client
  end

  @doc """
  Add user as a collaborator

  ## Example
      Tentacat.Repositories.Collaborators.add "elixir-lang", "elixir", "username", %{}
      Tentacat.Repositories.Collaborators.add "elixir-lang", "elixir", "username", %{ permission: "push" }, client
      Tentacat.Repositories.Collaborators.add "elixir-lang", "elixir", "username", %{}, client

  More info at: https://developer.github.com/v3/repos/collaborators/#add-user-as-a-collaborator
  """
  @spec add(binary, binary, binary, map, Client.t) :: Tentacat.response
  def add(owner, repo, username, body, client \\ %Client{}) do
    put "repos/#{owner}/#{repo}/collaborators/#{username}", client, body
  end

  @doc """
  Remove user as a collaborator

  ## Example
      Tentacat.Repositories.Collaborators.delete "elixir-lang", "elixir", "username"
      Tentacat.Repositories.Collaborators.delete "elixir-lang", "elixir", "username", client

  More info at: https://developer.github.com/v3/repos/collaborators/#remove-user-as-a-collaborator
  """
  @spec delete(binary, binary, binary, Client.t) :: Tentacat.response
  def delete(owner, repo, username, client \\ %Client{}) do
    Tentacat.delete "repos/#{owner}/#{repo}/collaborators/#{username}", client
  end
end
