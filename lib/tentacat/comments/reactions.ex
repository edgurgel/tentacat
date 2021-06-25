defmodule Tentacat.Comments.Reactions do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List the reactions on a comment.

  ## Example

      Tentacat.Comments.Reactions.list "elixir-lang" , "elixir", "345434"

  More info at: https://developer.github.com/v3/reactions/#list-reactions-for-a-commit-comment
  """
  @spec list(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo, comment_id) do
    get("repos/#{owner}/#{repo}/comments/#{comment_id}/reactions", client)
  end

  @doc """
  Create a reaction on a comment

  Reaction Request body example:

  ```elixir
  %{
    content: "heart"
  }
  ```

  ## Example

  Tentacat.Comments.Reactions.create "elixir-lang", "elixir", "345434"

  More info at: https://developer.github.com/v3/reactions/#create-reaction-for-a-commit-comment
  """
  @spec create(Client.t(), binary, binary, binary | integer, map) :: Tentacat.response()
  def create(client \\ %Client{}, owner, repo, comment_id, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/comments/#{comment_id}/reactions", client, body)
  end
end
