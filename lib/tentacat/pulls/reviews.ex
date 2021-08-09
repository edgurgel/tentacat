defmodule Tentacat.Pulls.Reviews do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List reviews on a pull request.

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
  Create a new review on a pull request.

  ## Example

      body = %{
        "commit_id"=> "ecdd80bb57125d7ba9641ffaa4d7d2c19d3f3091",
        "body"=> "This is close to perfect! Please address the suggested inline change.",
        "event"=> "REQUEST_CHANGES",
        "comments"=> [
          %{
            "path"=> "file.md",
            "position"=> 6,
            "body"=> "Please add more information here, and fix this typo."
          }
        ]
      }

      Tentacat.Pulls.Reviews.create "elixir-lang", "elixir", 1, body
      Tentacat.Pulls.Reviews.create client, "elixir-lang", "elixir", 1, body

  More info at: https://developer.github.com/v3/pulls/reviews/#create-a-pull-request-review
  """
  @spec create(Client.t(), binary, binary, binary | integer, map()) :: Tentacat.response()
  def create(client \\ %Client{}, owner, repo, number, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/pulls/#{number}/reviews", client, body)
  end
end
