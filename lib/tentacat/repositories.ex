defmodule Tentacat.Repositories do
  import Tentacat
  alias Tentacat.Client
  @moduledoc """
  The Repository Webhooks API allows repository admins to manage the post-receive hooks for a repository.
  """

  @doc """
  List current user's Repositories.


  ## Example

      Tentacat.Repositories.list_mine(client)

  More info at: https://developer.github.com/v3/repos/#list-your-repositories
  """
  @spec list_mine(Client.t) :: Tentacat.response
  def list_mine(client) do
    get "user/repos", client
  end

  @doc """
  List users Repositories.

  ## Example

      Tentacat.Repositories.list_users("steve", client)

  More info at: https://developer.github.com/v3/repos/#list-user-repositories
  """
  @spec list_users(binary, Client.t) :: Tentacat.response
  def list_users(owner, client \\ %Client{}) do
    get "users/#{owner}/repos", client
  end

  @doc """
  List organizations Repositories.

  ## Example

      Tentacat.Repositories.list_orgs("elixir-lang", client)

  More info at: https://developer.github.com/v3/repos/#list-organization-repositories
  """
  @spec list_orgs(binary, Client.t) :: Tentacat.response
  def list_orgs(org, client \\ %Client{}) do
    get "orgs/#{org}/repos", client
  end


end
