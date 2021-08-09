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
      Tentacat.Gists.list_users("steve")

  More info at: https://developer.github.com/v3/gists/#list-a-users-gists
  """
  @spec list_users(Client.t(), binary, Keyword.t(), Keyword.t()) :: Tentacat.response()
  def list_users(client \\ %Client{}, owner, params \\ [], options \\ []) do
    get("users/#{owner}/gists", client, params, options)
  end

  @doc """
  List all public gists.

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
  List starred gists.

  ## Example

      Tentacat.Gists.list_starred(client)

  More info at: https://developer.github.com/v3/gists/#list-starred-gists
  """
  @spec list_starred(Client.t(), Keyword.t(), Keyword.t()) :: Tentacat.response()
  def list_starred(client, params \\ [], options \\ []) do
    get("gists/starred", client, params, Keyword.merge([pagination: :none], options))
  end

  @doc """
  Get a single gist.

  ## Example

      Tentacat.Gists.gist_get("fe771b85eeeff878d177b0c0f3840afd")
      Tentacat.Gists.gist_get(client, "fe771b85eeeff878d177b0c0f3840afd")

  More info at: https://developer.github.com/v3/gists/#get-a-single-gist
  """
  @spec gist_get(Client.t(), binary) :: Tentacat.response()
  def gist_get(client \\ %Client{}, gist_id) do
    get("gists/#{gist_id}", client)
  end

  @doc """
  Get a specific revision of a gist.

  ## Example

      Tentacat.Gists.get_revision("fe771b85eeeff878d177b0c0f3840afd", "0ba06a873509677ab40b8ed5575f249a55c6fc41")
      Tentacat.Gists.get_revision(client, "fe771b85eeeff878d177b0c0f3840afd", "0ba06a873509677ab40b8ed5575f249a55c6fc41")

  More info at: https://developer.github.com/v3/gists/#get-a-specific-revision-of-a-gist
  """
  @spec get_revision(Client.t(), binary, binary) :: Tentacat.response()
  def get_revision(client \\ %Client{}, gist_id, sha) do
    get("gists/#{gist_id}/#{sha}", client)
  end

  @doc """
  Create a new gist for the authenticated user.

  Gist body example:

  ```elixir
  %{
    "files" => %{
      "hello.rb" => %{"content" => "puts 'Hello World'"},
      "hello.py" => %{"content" => "print 'Hello World'"}
    },
    "description" => "Hello World Examples",
    "public" => false
  }
  ```

  ## Example

      Tentacat.Gists.create(client, body)

  More info at: https://developer.github.com/v3/gists/#create-a-gist
  """
  @spec create(Client.t(), map) :: Tentacat.response()
  def create(client, body) when is_map(body) do
    post("gists", client, body)
  end

  @doc """
  Edit a gist.

  Gist body example:

  ```elixir
  %{
    "description" => "Hello World Examples",
    "files" => %{
      "hello_world_ruby.txt" => %{
        "content" => "Run `ruby hello.rb` or `python hello.py` to print Hello World",
        "filename" => "hello.md"
      },
      "hello_world_python.txt" => nil,
      "new_file.txt" => %{
        "content" => "This is a new placeholder file."
      }
    }
  }
  ```

  ## Example

      Tentacat.Gists.edit(client, "fe771b85eeeff878d177b0c0f3840afd", body)

  More info at: https://developer.github.com/v3/gists/#edit-a-gist
  """
  @spec edit(Client.t(), binary, map) :: Tentacat.response()
  def edit(client, gist_id, body) when is_map(body) do
    patch("gists/#{gist_id}", client, body)
  end

  @doc """
  List forks.

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
  Fork a gist.

  ## Example

      Tentacat.Gists.fork(client, "fe771b85eeeff878d177b0c0f3840afd")

  More info: https://developer.github.com/v3/gists/#fork-a-gist
  """
  @spec fork(Client.t(), binary) :: Tentacat.response()
  def fork(client, gist_id) do
    post("gists/#{gist_id}/forks", client, %{})
  end

  @doc """
  Star a gist.

  ## Example

      Tentacat.Gists.star(client, "fe771b85eeeff878d177b0c0f3840afd")

  More info: https://developer.github.com/v3/gists/#star-a-gist
  """
  @spec star(Client.t(), binary) :: Tentacat.response()
  def star(client, gist_id) do
    put("gists/#{gist_id}/star", client)
  end

  @doc """
  Unstar a gist.

  ## Example

      Tentacat.Gists.unstar(client, "fe771b85eeeff878d177b0c0f3840afd")

  More info: https://developer.github.com/v3/gists/#unstar-a-gist
  """
  @spec unstar(Client.t(), binary) :: Tentacat.response()
  def unstar(client, gist_id) do
    Tentacat.delete("gists/#{gist_id}/star", client)
  end

  @doc """
  Check if a gist is starred.

  ## Example

      Tentacat.Gists.check_if_starred(client, "")

  More info: https://developer.github.com/v3/gists/#check-if-a-gist-is-starred
  """
  @spec check_if_starred(Client.t(), binary) :: Tentacat.response()
  def check_if_starred(client, gist_id) do
    get("gists/#{gist_id}/star", client)
  end

  @doc """
  List gist commits.

  ## Example

      Tentacat.Gists.list_commits("fe771b85eeeff878d177b0c0f3840afd")
      Tentacat.Gists.list_commits(client, "fe771b85eeeff878d177b0c0f3840afd")

  More info at: https://developer.github.com/v3/gists/#list-gist-commits
  """
  @spec list_commits(Client.t(), binary) :: Tentacat.response()
  def list_commits(client \\ %Client{}, gist_id) do
    get("gists/#{gist_id}/commits", client)
  end

  @doc """
  Deleting a gist requires admin access.

  If OAuth is used, the gist scope is required.

  ## Example

      Tentacat.Gists.delete(client, "fe771b85eeeff878d177b0c0f3840afd")

  More info at: https://developer.github.com/v3/gists/#delete-a-gist
  """
  @spec delete(Client.t(), binary) :: Tentacat.response()
  def delete(client, gist_id) do
    Tentacat.delete("gists/#{gist_id}", client)
  end
end
