defmodule Tentacat.Issues.Comments.Reactions do
  import Tentacat

  alias Tentacat.Client

  @doc """
  List the reactions on an issue comment

  ## Example

  Tentacat.Issues.Comments.Reactions.list "elixir-lang" , "elixir", "3"

  More info at: https://developer.github.com/v3/reactions/#list-reactions-for-an-issue-comment
  """

  @spec list(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo, comment_id) do
    get("repos/#{owner}/#{repo}/issues/comments/#{comment_id}/reactions", client)
  end

  @doc """
  Create a reaction on an issue comment

  Reaction Request body example:
      %{ content: "heart" }


  ### Example

  Tentacat.Issues.Comments.Reactions.create "elixir-lang", "elixir", "3", %{ content: "heart" }, client

  More info at: https://developer.github.com/v3/reactions/#create-reaction-for-an-issue-comment
  """
  @spec create(Client.t(), binary, binary, binary | integer, Keyword.t() | map) ::
          Tentacat.response()
  def create(client \\ %Client{}, owner, repo, comment_id, body) do
    post("repos/#{owner}/#{repo}/issues/comments/#{comment_id}/reactions", client, body)
  end
end
