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

  @doc """
  Create a new review

  Review body example:

      %{
        "commit_id" => "7491bda5196f78536e5acc9b7c90a97170e4db0a",
        "body"      => "Nice change",
        "event"     => "APPROVE",
        "comments"  => [
          %{
            "body"     => "Good addition!"
            "path"     => "file1.txt",
            "position" => 4,
          }
        ]
      }

  ## Example

      Tentacat.Pulls.Reviews.list "elixir-lang", "elixir", 1, body
      Tentacat.Pulls.Reviews.list client, "elixir-lang", "elixir", 1, body

  More info at: https://developer.github.com/v3/pulls/reviews/#create-a-pull-request-review
  """
  @spec create(Client.t(), binary, binary, binary | integer, map()) :: Tentacat.response()
  def create(client \\ %Client{}, owner, repo, number, body) do
    post("repos/#{owner}/#{repo}/pulls/#{number}/reviews", client, body)
  end
end
