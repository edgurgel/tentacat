defmodule Tentacat.Repositories do
  import Tentacat
  alias Tentacat.Client

  @moduledoc """
  The Repository Webhooks API allows repository admins to manage the
  post-receive hooks for a repository.
  """

  @doc """
  List current user's Repositories.

  ## Examples

      Tentacat.Repositories.list_mine(client)
      Tentacat.Repositories.list_mine(client, type: "owner")

  More info at: https://developer.github.com/v3/repos/#list-your-repositories
  """
  @spec list_mine(Client.t(), Keyword.t()) :: Tentacat.response()
  def list_mine(client, params \\ [], options \\ []) do
    get("user/repos", client, params, options)
  end

  @doc """
  List users Repositories.

  ## Example

      Tentacat.Repositories.list_users(client, "steve")

  More info at: https://developer.github.com/v3/repos/#list-user-repositories
  """
  @spec list_users(Client.t(), binary, Keyword.t(), Keyword.t()) :: Tentacat.response()
  def list_users(client \\ %Client{}, owner, params \\ [], options \\ []) do
    get("users/#{owner}/repos", client, params, options)
  end

  @doc """
  List organizations Repositories.

  ## Example

      Tentacat.Repositories.list_orgs(client, "elixir-lang")

  More info at: https://developer.github.com/v3/repos/#list-organization-repositories
  """
  @spec list_orgs(Client.t(), binary, Keyword.t()) :: Tentacat.response()
  def list_orgs(client \\ %Client{}, org, params \\ [], options \\ []) do
    get("orgs/#{org}/repos", client, params, options)
  end

  @doc """
  List all public repositories.

  ## Example

      Tentacat.Repositories.list_public
      Tentacat.Repositories.list_public(client)

  More info at: https://developer.github.com/v3/repos/#list-all-public-repositories
  """
  @spec list_public(Client.t(), Keyword.t(), Keyword.t()) :: Tentacat.response()
  def list_public(client \\ %Client{}, params \\ [], options \\ []) do
    get("repositories", client, params, Keyword.merge([pagination: :none], options))
  end

  @doc """
  Get a repository details.

  ## Example

      Tentacat.Repositories.repo_get("elixir-conspiracy", "pacman")
      Tentacat.Repositories.repo_get(client, "elixir-conspiracy", "pacman")

  More info at: https://developer.github.com/v3/repos/#get
  """
  @spec repo_get(Client.t(), binary, binary, Keyword.t()) :: Tentacat.response()
  def repo_get(client \\ %Client{}, owner, repo, params \\ []) do
    get("repos/#{owner}/#{repo}", client, params)
  end

  @doc """
  Create a new repository for the authenticated user.

  Possible values for `options`:

    * %{description: "Simple Elixir wrapper for the GitHub API"}
    * %{homepage: "http://www.github.com/edgurgel/tentacat"}
    * %{private: false}
    * %{has_issues: true}
    * %{has_wiki: false}
    * %{has_downloads: true}
    * %{team_id: 123}
    * %{auto_init: false}
    * %{gitignore_template: "Haskell"}
    * %{license_template: "mit"}j

  ## Example

      Tentacat.Repositories.create(client, "tentacat", %{private: false})

  More info at: https://developer.github.com/v3/repos/#create
  """
  @spec create(Client.t(), binary, map) :: Tentacat.response()
  def create(client, repo, options \\ %{}) when is_map(options) do
    post("user/repos", client, Map.merge(%{name: repo}, options))
  end

  @spec org_create(Client.t(), binary, binary, list) :: Tentacat.response()
  def org_create(client, org, repo, options \\ %{}) when is_map(options) do
    post("orgs/#{org}/repos", client, Map.merge(%{name: repo}, options))
  end

  @doc """
  Deleting a repository requires admin access.

  If OAuth is used, the delete_repo scope is required.

  ## Example

      Tentacat.Repositories.delete("soudqwiggle", "tentacat", client)

  More info at: https://developer.github.com/v3/repos/#delete-a-repository
  """
  @spec delete(Client.t(), binary, binary) :: Tentacat.response()
  def delete(client, owner, repo) do
    delete("repos/#{owner}/#{repo}", client)
  end
end
