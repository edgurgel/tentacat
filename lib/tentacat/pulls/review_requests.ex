defmodule Tentacat.Pulls.ReviewRequests do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List review requests in a pull request

  ## Example

      Tentacat.Pulls.ReviewRequests.list "elixir-lang", "elixir", 1
      Tentacat.Pulls.ReviewRequests.list "elixir-lang", "elixir", 1, client

  More info at: https://developer.github.com/v3/pulls/review_requests/#list-review-requests
  """
  @spec list(binary, binary, binary | integer, Client.t) :: Tentacat.response
  def list(owner, repo, number, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/pulls/#{number}/requested_reviewers", client
  end

  @doc """
  Create a review request

  Review Request body example:

      ["octocat"]

  ## Example

      Tentacat.Pulls.ReviewRequests.create "elixir-lang", "elixir", body, client

  More info at: https://developer.github.com/v3/pulls/review_requests/#create-a-review-request
  """
  @spec create(binary, binary, binary | integer, list(binary), Client.t) :: Tentacat.response
  def create(owner, repo, number, reviewers, client) do
    post "repos/#{owner}/#{repo}/pulls/#{number}/requested_reviewers", client, %{reviewers: reviewers}
  end

  @doc """
  Delete a review request.

  ## Example

      Tentacat.Pulls.ReviewRequests.remove "elixir-lang", "elixir", 1, ["octocat"], client

  More info at: https://developer.github.com/v3/pulls/review_requests/#delete-a-review-request
  """
  @spec remove(binary, binary, binary | integer, list(binary), Client.t) :: Tentacat.response
  def remove(owner, repo, number, reviewers, client) do
    delete "repos/#{owner}/#{repo}/pulls/#{number}/requested_reviewers", client, %{reviewers: reviewers}
  end
end
