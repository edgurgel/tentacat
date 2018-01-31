defmodule Tentacat.Comments.Reactions do
  import Tentacat

  alias Tentacat.Client

  @doc """
  List the reactions on a comment

  ## Example

  Tentacat.Comments.Reactions.list "elixir-lang" , "elixir", "345434"

  More info at: https://developer.github.com/v3/reactions/#list-reactions-for-a-commit-comment
  """
  @spec list(binary, binary, binary | integer, Client.t) :: Tentacat.response
  def list(owner, repo, comment_id, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/comments/#{comment_id}/reactions", client
  end

  @doc """
  Create a reaction on a comment

  Reaction Request body example:
      %{ content: "heart" }

  ### Example

  Tentacat.Comments.Reactions.create "elixir-lang", "elixir", "345434"
  More info at: https://developer.github.com/v3/reactions/#create-reaction-for-a-commit-comment
  """
  @spec create(binary, binary, binary | integer, Keyword.t | map, Client.t) :: Tentacat.response
  def create(owner, repo, comment_id, body, client \\ %Client{}) do
    post "repos/#{owner}/#{repo}/comments/#{comment_id}/reactions", client, body
  end
end
