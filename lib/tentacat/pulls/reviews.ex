defmodule Tentacat.Pulls.Reviews do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List reviews on a pull request

  ## Example

      Tentacat.Pulls.Reviews.list "elixir-lang", "elixir", 1
      Tentacat.Pulls.Reviews.list client, "elixir-lang", "elixir", 1

  More info at: https://developer.github.com/v3/pulls/reviews/#list-reviews-on-a-pull-request
  """
  @spec list(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo, number) do
    get("repos/#{owner}/#{repo}/pulls/#{number}/reviews", client)
  end
end
