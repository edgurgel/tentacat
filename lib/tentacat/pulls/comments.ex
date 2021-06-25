defmodule Tentacat.Pulls.Comments do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List pull requests comments in a repository.

  ## Example

      Tentacat.Pulls.Comments.list_all "elixir-lang", "elixir"
      Tentacat.Pulls.Comments.list_all client, "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/pulls/comments/#list-comments-in-a-repository
  """
  @spec list_all(Client.t(), binary, binary) :: Tentacat.response()
  def list_all(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/pulls/comments", client)
  end

  @doc """
  Filter pull requests comments in a repository. Parameters are `sort`, `dir`, and `since`..

  ## Example

      Tentacat.Pulls.Comments.filter_all "elixir-lang", "elixir", %{sort: "updated", dir: "desc"}
      Tentacat.Pulls.Comments.filter_all client, "elixir-lang", "elixir", %{sort: "updated", dir: "desc"}

  More info at: https://developer.github.com/v3/pulls/comments/#list-comments-in-a-repository
  """
  @spec filter_all(Client.t(), binary, binary, Keyword.t() | map) :: Tentacat.response()
  def filter_all(client \\ %Client{}, owner, repo, filters) do
    get("repos/#{owner}/#{repo}/pulls/comments?#{URI.encode_query(filters)}", client)
  end

  @doc """
  List comments on a pull request.

  ## Example

      Tentacat.Pulls.Comments.list "elixir-lang", "elixir", "2974"
      Tentacat.Pulls.Comments.list client, "elixir-lang", "elixir", "2974"

  More info at: https://developer.github.com/v3/pulls/comments/#list-comments-on-a-pull-request
  """
  @spec list(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo, number) do
    get("repos/#{owner}/#{repo}/pulls/#{number}/comments", client)
  end

  @doc """
  Get a single comment for a repository by comment id.

  ## Example

      Tentacat.Pulls.Comments.find "elixir-lang", "elixir", "22377723"
      Tentacat.Pulls.Comments.find client, "elixir-lang", "elixir", "22377723"

  More info at: https://developer.github.com/v3/pulls/comments/#get-a-single-comment
  """
  @spec find(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def find(client \\ %Client{}, owner, repo, comment_id) do
    get("repos/#{owner}/#{repo}/pulls/comments/#{comment_id}", client)
  end

  @doc """
  Create a comment for a pull request.

  Comment body example:

  ```elixir
  %{
    "body"      => "Nice change",
    "commit_id" => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
    "path"      => "file1.txt",
    "position"  =>  4
  }
  ```

  ## Example

      Tentacat.Pulls.Comments.create client, "elixir-lang", "elixir", 2974, comment_body

  More info at: https://developer.github.com/v3/pulls/comments/#create-a-comment
  """
  @spec create(Client.t(), binary, binary, integer | binary, map) :: Tentacat.response()
  def create(client, owner, repo, number, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/pulls/#{number}/comments", client, body)
  end

  @doc """
  Edit a comment for a pull request.

  ## Example

      Tentacat.Pulls.Comments.update client, "elixir-lang", "elixir", "22377723", comment_body

  More info at: https://developer.github.com/v3/pulls/comments/#edit-a-comment
  """
  @spec update(Client.t(), binary, binary, binary | integer, map) :: Tentacat.response()
  def update(client, owner, repo, comment_id, body) when is_map(body) do
    patch("repos/#{owner}/#{repo}/pulls/comments/#{comment_id}", client, body)
  end

  @doc """
  Delete a pull request's comment by it's Id.

  ## Example

      Tentacat.Pulls.Comments.remove client, "elixir-lang", "elixir", "22377723"

  More info at: https://developer.github.com/v3/pulls/comments/#delete-a-comment
  """
  @spec remove(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def remove(client, owner, repo, comment_id) do
    delete("repos/#{owner}/#{repo}/pulls/comments/#{comment_id}", client)
  end
end
