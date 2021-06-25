defmodule Tentacat.Issues.Reactions do
  import Tentacat

  alias Tentacat.Client

  @doc """
  List the reactions on a issue.

  ## Example

      Tentacat.Issues.Reactions.list "elixir-lang" , "elixir", "3"

  More info at: https://developer.github.com/v3/reactions/#list-reactions-for-an-issue
  """

  @spec list(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo, issue_id) do
    get("repos/#{owner}/#{repo}/issues/#{issue_id}/reactions", client)
  end

  @doc """
  Create a reaction on an issue.

  Reaction Request body example:

  ```elixir
  %{
    content: "heart"
  }
  ```

  ## Example

  Tentacat.Issues.Reactions.create "elixir-lang", "elixir", "3"

  More info at: https://developer.github.com/v3/reactions/#create-reaction-for-an-issue
  """
  @spec create(Client.t(), binary, binary, binary | integer, Keyword.t() | map) ::
          Tentacat.response()
  def create(client \\ %Client{}, owner, repo, issue_id, body) do
    post("repos/#{owner}/#{repo}/issues/#{issue_id}/reactions", client, body)
  end

  @doc """
  Delete a reaction on an issue.

  ## Example

      Tentacat.Issues.Reactions.delete "elixir-lang", "elixir", "3", "4"

  More info at: https://developer.github.com/v3/reactions/#delete-an-issue-reaction
  """
  @spec delete(Client.t(), binary, binary, binary | integer, binary) ::
          Tentacat.response()
  def delete(client \\ %Client{}, owner, repo, issue_id, reaction_id) do
    delete("repos/#{owner}/#{repo}/issues/#{issue_id}/reactions/#{reaction_id}", client)
  end
end
