defmodule Tentacat.Commits.Comments do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List commit comments in a repository.

  ## Example

      Tentacat.Commits.Comments.list_all "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/repos/comments/#list-commit-comments-for-a-repository
  """
  @spec list_all(Client.t(), binary, binary) :: Tentacat.response()
  def list_all(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/comments", client)
  end

  @doc """
  List commit comments for a commit.

  ## Example

      Tentacat.Commits.Comments.list "elixir-lang", "elixir", "7491bda5196f78536e5acc9b7c90a97170e4db0a"

  More info at: https://developer.github.com/v3/repos/comments/#list-comments-for-a-single-commit
  """
  @spec list(Client.t(), binary, binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo, ref) do
    get("repos/#{owner}/#{repo}/commits/#{ref}/comments", client)
  end

  @doc """
  Create a comment for a commit.

  Comment body example:

  ```elixir
  %{
    "body"      => "Nice change",
    "path"      => "file1.txt",
    "position"  => 4,
    "line"      => null
  }
  ```

  ## Example

      Tentacat.Commits.Comments.create "elixir-lang", "elixir", "7491bda5196f78536e5acc9b7c90a97170e4db0a", comment_body

  More info at: https://developer.github.com/v3/repos/comments/#create-a-commit-comment
  """
  @spec create(Client.t(), binary, binary, binary, map) :: Tentacat.response()
  def create(client \\ %Client{}, owner, repo, sha, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/commits/#{sha}/comments", client, body)
  end

  @doc """
  Find a comment for a commit.

  ## Example

      Tentacat.Commits.Comments.find "elixir-lang", "elixir", 1

  More info at: https://developer.github.com/v3/repos/comments/#get-a-single-commit-comment
  """
  @spec find(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def find(client \\ %Client{}, owner, repo, id) do
    get("repos/#{owner}/#{repo}/comments/#{id}", client)
  end

  @doc """
  Update a comment for a commit.

  Comment body example:

  ```elixir
  %{
    "body" => "Nice change",
  }
  ```

  ## Example

      Tentacat.Commits.Comments.update "elixir-lang", "elixir", 1

  More info at: https://developer.github.com/v3/repos/comments/#update-a-commit-comment
  """
  @spec update(Client.t(), binary, binary, binary | integer, map) :: Tentacat.response()
  def update(client \\ %Client{}, owner, repo, id, body) when is_map(body) do
    patch("repos/#{owner}/#{repo}/comments/#{id}", client, body)
  end

  @doc """
  Delete a comment for a commit

  ## Example

      Tentacat.Commits.Comments.delete "elixir-lang", "elixir", 1

  More info at: https://developer.github.com/v3/repos/comments/#delete-a-commit-comment
  """
  @spec delete(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def delete(client \\ %Client{}, owner, repo, id) do
    delete("repos/#{owner}/#{repo}/comments/#{id}", client)
  end
end
