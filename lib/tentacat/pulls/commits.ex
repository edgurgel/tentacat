defmodule Tentacat.Pulls.Commits do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List commits on a pull request.

  ## Example

      Tentacat.Pulls.Commits.list "elixir-lang", "elixir", "2974"
      Tentacat.Pulls.Commits.list client, "elixir-lang", "elixir", "2974"

  More info at: https://developer.github.com/v3/pulls/#list-commits-on-a-pull-request
  """
  @spec list(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo, number) do
    get("repos/#{owner}/#{repo}/pulls/#{number}/commits", client)
  end
end
