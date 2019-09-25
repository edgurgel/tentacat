defmodule Tentacat.Gists do
  import Tentacat, [:except, :delete, 2]
  alias Tentacat.Client

  @doc """
  List current user's gists.

  ## Examples

      Tentacat.Gists.list_mine(client)

  More info at: https://developer.github.com/v3/gists/#list-a-users-gists
  """
  @spec list_mine(Client.t(), Keyword.t()) :: Tentacat.response()
  def list_mine(client, params \\ [], options \\ []) do
    get("gists", client, params, options)
  end

  @doc """
  List users gists.

  ## Example

      Tentacat.Gists.list_users(client, "steve")

  More info at: https://developer.github.com/v3/gists/#list-a-users-gists
  """
  @spec list_users(Client.t(), binary, Keyword.t(), Keyword.t()) :: Tentacat.response()
  def list_users(client \\ %Client{}, owner, params \\ [], options \\ []) do
    get("users/#{owner}/gists", client, params, options)
  end

  @doc """
  List all public gists

  ## Example

      Tentacat.Gists.list_public
      Tentacat.Gists.list_public(client)

  More info at: https://developer.github.com/v3/gists/#list-all-public-gists
  """
  @spec list_public(Client.t(), Keyword.t(), Keyword.t()) :: Tentacat.response()
  def list_public(client \\ %Client{}, params \\ [], options \\ []) do
    get("gists/public", client, params, Keyword.merge([pagination: :none], options))
  end

  @doc """
  List starred gists

  ## Example

      Tentacat.Gists.list_starred
      Tentacat.Gists.list_starred(client)

  More info at: https://developer.github.com/v3/gists/#list-starred-gists
  """
  @spec list_starred(Client.t(), Keyword.t(), Keyword.t()) :: Tentacat.response()
  def list_starred(client, params \\ [], options \\ []) do
    get("gists/starred", client, params, Keyword.merge([pagination: :none], options))
  end

  @doc """
  Get

  ## Example

      Tentacat.Gists.gist_get("fe771b85eeeff878d177b0c0f3840afd")
      Tentacat.Gists.gist_get(client, "fe771b85eeeff878d177b0c0f3840afd")

  More info at: https://developer.github.com/v3/gists/#get
  """
  @spec gist_get(Client.t(), binary) :: Tentacat.response()
  def gist_get(client \\ %Client{}, gist_id) do
    get("gists/#{gist_id}", client)
  end

  @doc """
  Get a specific revision of a gist

  ## Example

      Tentacat.Gists.gist_get("fe771b85eeeff878d177b0c0f3840afd")
      Tentacat.Gists.gist_get(client, "fe771b85eeeff878d177b0c0f3840afd")

  More info at: https://developer.github.com/v3/gists/#get-a-specific-revision-of-a-gist
  """
  @spec get_revision(Client.t(), binary, binary) :: Tentacat.response()
  def get_revision(client \\ %Client{}, gist_id, sha) do
    get("gists/#{gist_id}/#{sha}", client)
  end

  @doc """
  Create a new gist for the authenticated user.

  Possible values for `options`:

  * [files: "Simple Elixir wrapper for the GitHub API"]
  * [description: "http://www.github.com/edgurgel/tentacat"]
  * [public: false]

  ## Example

      Tentacat.Gists.create(client, "tentacat", private: false)

  More info at: https://developer.github.com/v3/gists/#create-a-gist
  """
  @spec create(Client.t(), binary, list) :: Tentacat.response()
  def create(client, gist, options \\ []) do
    post("gists", client, List.flatten([name: gist], options))
  end

  @doc """
  List forks

  ## Example

      Tentacat.Gists.list_forks("fe771b85eeeff878d177b0c0f3840afd")
      Tentacat.Gists.list_forks(client, "fe771b85eeeff878d177b0c0f3840afd")

  More info at: https://developer.github.com/v3/gists/#list-gist-forks
  """
  @spec list_forks(Client.t(), binary, Keyword.t()) :: Tentacat.response()
  def list_forks(client \\ %Client{}, gist_id, params \\ []) do
    get("gists/#{gist_id}/forks", client, params)
  end

  @doc """
  Deleting a gist requires admin access. If OAuth is used, the gist scope is required.

  ## Example

      Tentacat.Gists.delete(client, "fe771b85eeeff878d177b0c0f3840afd")

  More info at: https://developer.github.com/v3/gists/#delete-a-gist
  """
  @spec delete(Client.t(), binary) :: Tentacat.response()
  def delete(client, id) do
    Tentacat.delete("gists/#{id}", client)
  end
end
