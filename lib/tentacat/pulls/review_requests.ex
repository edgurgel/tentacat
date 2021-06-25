defmodule Tentacat.Pulls.ReviewRequests do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List review requests in a pull request.

  ## Example

      Tentacat.Pulls.ReviewRequests.list "elixir-lang", "elixir", 1
      Tentacat.Pulls.ReviewRequests.list client, "elixir-lang", "elixir", 1

  More info at: https://developer.github.com/v3/pulls/review_requests/#list-review-requests
  """
  @spec list(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo, number) do
    get("repos/#{owner}/#{repo}/pulls/#{number}/requested_reviewers", client)
  end

  @doc """
  Create a review request.

  Review Request body example:

  ```elixir
  %{
    "reviewers" => ["octocat"]
  }
  ```

  ## Example

      Tentacat.Pulls.ReviewRequests.create client, "elixir-lang", "elixir", body

  More info at: https://developer.github.com/v3/pulls/review_requests/#create-a-review-request
  """
  @spec create(Client.t(), binary, binary, binary | integer, list(binary)) :: Tentacat.response()
  def create(client, owner, repo, number, reviewers) do
    post("repos/#{owner}/#{repo}/pulls/#{number}/requested_reviewers", client, %{
      reviewers: reviewers
    })
  end

  @doc """
  Delete a review request.

  ## Example

      Tentacat.Pulls.ReviewRequests.remove client, "elixir-lang", "elixir", 1, ["octocat"]

  More info at: https://developer.github.com/v3/pulls/review_requests/#delete-a-review-request
  """
  @spec remove(Client.t(), binary, binary, binary | integer, list(binary)) :: Tentacat.response()
  def remove(client, owner, repo, number, reviewers) do
    delete("repos/#{owner}/#{repo}/pulls/#{number}/requested_reviewers", client, %{
      reviewers: reviewers
    })
  end
end
