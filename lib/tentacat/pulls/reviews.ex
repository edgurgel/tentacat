defmodule Tentacat.Pulls.Reviews do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List reviews on a pull request

  ## Example

      Tentacat.Pulls.Reviews.list "elixir-lang", "elixir", 1
      Tentacat.Pulls.Reviews.list "elixir-lang", "elixir", 1, client

  More info at: https://developer.github.com/v3/pulls/reviews/#list-reviews-on-a-pull-request
  """
  @spec list(binary, binary, binary | integer, Client.t) :: Tentacat.response
  def list(owner, repo, number, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/pulls/#{number}/reviews", client
  end
end
