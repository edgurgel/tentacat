defmodule Tentacat.Pulls.Commits do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List commits on a pull request

  ## Example

      Tentacat.Pulls.Commits.list "elixir-lang", "elixir", "2974"
      Tentacat.Pulls.Commits.list "elixir-lang", "elixir", "2974", client

  More info at: https://developer.github.com/v3/pulls/#list-commits-on-a-pull-request
  """
  @spec list(binary, binary, binary | integer, Client.t) :: Tentacat.response
  def list(owner, repo, number, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/pulls/#{number}/commits", client
  end
end
