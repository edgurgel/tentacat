defmodule Tentacat.Issues.Comments do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List comments on an issue.

  Issue Comments are ordered by ascending ID.

  ## Example

      Tentacat.Issues.Comments.list "elixir-lang", "elixir", 3970

  More info at: https://developer.github.com/v3/issues/comments/#list-comments-on-an-issue
  """
  @spec list(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo, issue_id) do
    get("repos/#{owner}/#{repo}/issues/#{issue_id}/comments", client)
  end

  @doc """
  Filter comments on an issue.

  Parameters are `since`.

  ## Example

      Tentacat.Issues.Comments.filter "elixir-lang", "elixir", 3970, since: "2016-05-04T23:59:59Z"

  More info at: https://developer.github.com/v3/issues/comments/#list-comments-on-an-issue
  """
  @spec filter(Client.t(), binary, binary, binary | integer, Keyword.t() | map) ::
          Tentacat.response()
  def filter(client \\ %Client{}, owner, repo, issue_id, filters) do
    get("repos/#{owner}/#{repo}/issues/#{issue_id}/comments?#{URI.encode_query(filters)}", client)
  end

  @doc """
  List all comments on issues for a repository.

  By default, Issue Comments are ordered by ascending ID.

  ## Example

      Tentacat.Issues.Comments.list_all "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/issues/comments/#list-comments-in-a-repository
  """
  @spec list_all(Client.t(), binary, binary) :: Tentacat.response()
  def list_all(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/issues/comments", client)
  end

  @doc """
  Filter comments on an issue.

  Parameters are `sort`, `direction` and `since`.

  ## Example

      Tentacat.Issues.Comments.filter_all "elixir-lang", "elixir", dir: "desc", sort: "updated"

  More info at: https://developer.github.com/v3/issues/comments/#list-comments-in-a-repository
  """
  @spec filter_all(Client.t(), binary, binary, Keyword.t() | map) :: Tentacat.response()
  def filter_all(client \\ %Client{}, owner, repo, filters) do
    get("repos/#{owner}/#{repo}/issues/comments?#{URI.encode_query(filters)}", client)
  end

  @doc """
  Get a single comment on an issue by its id.

  ## Example

      Tentacat.Issues.Comments.find "elixir-lang", "elixir", 882148

  More info at: https://developer.github.com/v3/issues/comments/#get-a-single-comment
  """
  @spec find(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def find(client \\ %Client{}, owner, repo, comment_id) do
    get("repos/#{owner}/#{repo}/issues/comments/#{comment_id}", client)
  end

  @doc """
  Create a comment on an issue.

  Comment body example:

  ```elixir
  %{
    "body" => "Nice change"
  }
  ```

  ## Example

      Tentacat.Issues.Comments.create "elixir-lang", "elixir", 3970, comment_body

  More info at: https://developer.github.com/v3/issues/comments/#create-a-comment
  """
  @spec create(Client.t(), binary, binary, binary | integer, map) :: Tentacat.response()
  def create(client \\ %Client{}, owner, repo, issue_id, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/issues/#{issue_id}/comments", client, body)
  end

  @doc """
  Update a comment on an issue by id.

  Comment body example:

  ```elixir
  %{
    "body" => "Nice change"
  }
  ```

  ## Example

      Tentacat.Issues.Comments.update "elixir-lang", "elixir", 882148, comment_body

  More info at: https://developer.github.com/v3/issues/comments/#edit-a-comment
  """
  @spec update(Client.t(), binary, binary, binary | integer, map) :: Tentacat.response()
  def update(client \\ %Client{}, owner, repo, comment_id, body) when is_map(body) do
    patch("repos/#{owner}/#{repo}/issues/comments/#{comment_id}", client, body)
  end

  @doc """
  Delete a comment on an issue by id.

  ## Example

      Tentacat.Issues.Comments.delete "elixir-lang", "elixir", 882148

  More info at: https://developer.github.com/v3/issues/comments/#delete-a-comment
  """
  @spec delete(Client.t(), binary, binary, binary | integer, binary | integer) ::
          Tentacat.response()
  def delete(client \\ %Client{}, owner, repo, issue_id, comment_id) do
    delete("repos/#{owner}/#{repo}/issues/#{issue_id}/comments/#{comment_id}", client)
  end
end
