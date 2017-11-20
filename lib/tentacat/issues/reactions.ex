defmodule Tentacat.Issues.Reactions do
  import Tentacat

  alias Tentacat.Client

  @doc """
  List the reactions on a issue

  ## Example

  Tentacat.Issues.Reactions.list "elixir-lang" , "elixir", "3"

  More info at: https://developer.github.com/v3/reactions/#list-reactions-for-an-issue
  """

  @spec list(binary, binary, binary | integer, Client.t) :: Tentacat.response
  def list(owner, repo, issue_id, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/issues/#{issue_id}/reactions", client
  end

  @doc """
  Create a reaction on an issue

  Reaction Request body example:
      %{ content: "heart" }


  ### Example

  Tentacat.Issues.Reactions.create "elixir-lang", "elixir", "3"

  More info at: https://developer.github.com/v3/reactions/#create-reaction-for-an-issue
  """
  @spec create(binary, binary, binary | integer, Keyword.t | map, Client.t) :: Tentacat.response
  def create(owner, repo, issue_id, body, client \\ %Client{}) do
    post "repos/#{owner}/#{repo}/issues/#{issue_id}/reactions", client, body
  end
end
