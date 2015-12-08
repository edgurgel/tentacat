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

  @doc """
  List all public repositories

  ## Example

      Tentacat.Repositories.list_public
      Tentacat.Repositories.list_public(client)

  More info at: https://developer.github.com/v3/repos/#list-all-public-repositories
  """
  @spec list_public(Client.t) :: Tentacat.response
  def list_public(client \\ %Client{}) do
    get "repositories", client
  end

  @doc """
  Get

  ## Example

      Tentacat.Repositories.repo_get("elixir-conspiracy", "pacman")
      Tentacat.Repositories.repo_get("elixir-conspiracy", "pacman", client)

  More info at: https://developer.github.com/v3/repos/#get
  """
  @spec repo_get(binary, binary, Client.t) :: Tentacat.response
  def repo_get(owner, repo, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}", client
  end

  @doc """
  Create a new repository for the authenticated user.

  Possible values for `options`:

  * [description: "Simple Elixir wrapper for the GitHub API"]
  * [homepage: "http://www.github.com/edgurgel/tentacat"]
  * [private: false]
  * [has_issues: true]
  * [has_wiki: false]
  * [has_downloads: true]
  * [team_id: 123]
  * [auto_init: false]
  * [gitignore_template: "Haskell"]
  * [license_template: "mit"]j

  ## Example

      Tentacat.Repositories.create("tentacat", [private: false], client)

  More info at: https://developer.github.com/v3/repos/#create
  """
  @spec create(binary, Client.t, list) :: Tentacat.response
  def create(repo, client, options \\ []) do
    post "user/repos", client, List.flatten([name: repo], options)
  end

  @spec org_create(binary, binary, Client.t, list) :: Tentacat.response
  def org_create(org, repo, client, options \\ []) do
    post "orgs/#{org}/repos", client, List.flatten([name: repo], options)
  end

  @doc """
  Deleting a repository requires admin access. If OAuth is used, the delete_repo scope is required.

  ## Example

      Tentacat.Repositories.delete("soudqwiggle", "tentacat", client)

  More info at: https://developer.github.com/v3/repos/#delete-a-repository
  """
  @spec delete(binary, binary, Client.t) :: Tentacat.response
  def delete(owner, repo, client) do
    delete "repos/#{owner}/#{repo}", client
  end

end
