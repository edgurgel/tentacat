defmodule Tentacat.Pulls.Comments do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List pull requests comments in a repository

  ## Example

      Tentacat.Pulls.Comments.list_all "elixir-lang", "elixir"
      Tentacat.Pulls.Comments.list_all "elixir-lang", "elixir", client

  More info at: https://developer.github.com/v3/pulls/comments/#list-comments-in-a-repository
  """
  @spec list_all(binary, binary, Client.t) :: Tentacat.response
  def list_all(owner, repo, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/pulls/comments", client
  end

  @doc """
  Filter pull requests comments in a repository. Parameters are `sort`, `dir`, and `since`.

  ## Example

      Tentacat.Pulls.Comments.filter_all "elixir-lang", "elixir", %{sort: "updated", dir: "desc"}
      Tentacat.Pulls.Comments.filter_all "elixir-lang", "elixir", %{sort: "updated", dir: "desc"}, client

  More info at: https://developer.github.com/v3/pulls/comments/#list-comments-in-a-repository
  """
  @spec filter_all(binary, binary, Keyword.t | map, Client.t) :: Tentacat.response
  def filter_all(owner, repo, filters, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/pulls/comments?#{URI.encode_query(filters)}", client
  end

  @doc """
  List comments on a pull request

  ## Example

      Tentacat.Pulls.Comments.list "elixir-lang", "elixir", "2974"
      Tentacat.Pulls.Comments.list "elixir-lang", "elixir", "2974", client

  More info at: https://developer.github.com/v3/pulls/comments/#list-comments-on-a-pull-request
  """
  @spec list(binary, binary, binary | integer, Client.t) :: Tentacat.response
  def list(owner, repo, number, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/pulls/#{number}/comments", client
  end

  @doc """
  Get a single comment for a repository by comment id

  ## Example

      Tentacat.Pulls.Comments.find "elixir-lang", "elixir", "22377723"
      Tentacat.Pulls.Comments.find "elixir-lang", "elixir", "22377723", client

  More info at: https://developer.github.com/v3/pulls/comments/#get-a-single-comment
  """
  @spec find(binary, binary, binary | integer, Client.t) :: Tentacat.response
  def find(owner, repo, comment_id, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/pulls/comments/#{comment_id}", client
  end

  @doc """
  Create a comment for a pull request

  Comment body example:
  ```
  %{
    "body"      => "Nice change",
    "commit_id" => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
    "path"      => "file1.txt",
    "position"  =>  4
  }
  ```

  ## Example

      Tentacat.Pulls.Comments.create "elixir-lang", "elixir", 2974, comment_body, client

  More info at: https://developer.github.com/v3/pulls/comments/#create-a-comment
  """
  @spec create(binary, binary, integer | binary, list | map, Client.t) :: Tentacat.response
  def create(owner, repo, number, body, client) do
    post "repos/#{owner}/#{repo}/pulls/#{number}/comments", client, body
  end

  @doc """
  Edit a comment for a pull request

  ## Example

      Tentacat.Pulls.Comments.update "elixir-lang", "elixir", "22377723", comment_body, client

  More info at: https://developer.github.com/v3/pulls/comments/#edit-a-comment
  """
  @spec update(binary, binary, binary | integer, list, Client.t) :: Tentacat.response
  def update(owner, repo, comment_id, body, client) do
    patch "repos/#{owner}/#{repo}/pulls/comments/#{comment_id}", client, body
  end

  @doc """
  Delete a pull request's comment by it's Id.

  ## Example

      Tentacat.Pulls.Comments.remove "elixir-lang", "elixir", "22377723", client

  More info at: https://developer.github.com/v3/pulls/comments/#delete-a-comment
  """
  @spec remove(binary, binary, binary | integer, Client.t) :: Tentacat.response
  def remove(owner, repo, comment_id, client) do
    delete "repos/#{owner}/#{repo}/pulls/comments/#{comment_id}", client
  end
end
