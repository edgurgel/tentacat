defmodule Tentacat.Issues.Comments do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List comments on an issue. Issue Comments are ordered by ascending ID.

  ## Example
  
      Tentacat.Issues.Comments.list "elixir-lang", "elixir", 3970

  More info at: https://developer.github.com/v3/issues/comments/#list-comments-on-an-issue
  """
  @spec list(binary, binary, binary | integer, Client.t) :: Tentacat.response
  def list(owner, repo, issue_id, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/issues/#{issue_id}/comments", client
  end

  @doc """
  List all comments on issues for a repository. By default, Issue Comments are ordered by ascending ID.

  ## Example
  
      Tentacat.Issues.Comments.list_all "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/issues/comments/#list-comments-in-a-repository
  """
  @spec list_all(binary, binary, Client.t) :: Tentacat.response
  def list_all(owner, repo, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/issues/comments", client
  end

  @doc """
  Get a single comment on an issue by its id.

  ## Example
  
      Tentacat.Issues.Comments.find "elixir-lang", "elixir", 882148

  https://developer.github.com/v3/issues/comments/#get-a-single-comment
  """
  @spec find(binary, binary, binary | integer, Client.t) :: Tentacat.response
  def find(owner, repo, comment_id, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/issues/comments/#{comment_id}", client
  end

  @doc """
  Create a comment on an issue.

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

      Tentacat.Issues.Comments.create "elixir-lang", "elixir", 3970, comment_body

  https://developer.github.com/v3/issues/comments/#create-a-comment
  """
  @spec create(binary, binary, binary | integer, list | map, Client.t) :: Tentacat.response
  def create(owner, repo, issue_id, body, client \\ %Client{}) do
    post "repos/#{owner}/#{repo}/issues/#{issue_id}/comments", client, body
  end
  
  @doc """
  Update a comment on an issue by id.

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

      Tentacat.Issues.Comments.update "elixir-lang", "elixir", 882148, comment_body

  https://developer.github.com/v3/issues/comments/#edit-a-comment
  """
  @spec update(binary, binary, binary | integer, binary | integer, list | map, Client.t) :: Tentacat.response
  def update(owner, repo, issue_id, comment_id, body, client \\ %Client{}) do
    patch "repos/#{owner}/#{repo}/issues/#{issue_id}/comments/#{comment_id}", client, body
  end
  
  @doc """
  Delete a comment on an issue by id.

  ## Example

      Tentacat.Issues.Comments.delete "elixir-lang", "elixir", 882148

  https://developer.github.com/v3/issues/comments/#delete-a-comment
  """
  @spec delete(binary, binary, binary | integer, binary | integer, Client.t) :: Tentacat.response
  def delete(owner, repo, issue_id, comment_id, client \\ %Client{}) do
    delete "repos/#{owner}/#{repo}/issues/#{issue_id}/comments/#{comment_id}", client
  end
end
