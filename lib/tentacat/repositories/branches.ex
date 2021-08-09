defmodule Tentacat.Repositories.Branches do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List Branches.

  ## Example

      Tentacat.Repositories.Branches.list "elixir-lang", "elixir"
      Tentacat.Repositories.Branches.list client, "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/repos/#list-branches
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/branches", client)
  end

  @doc """
  Get Branch.

  ## Example

      Tentacat.Repositories.Branches.find "elixir-lang", "elixir", "feature"
      Tentacat.Repositories.Branches.find client, "elixir-lang", "elixir", "feature"

  More info at: https://developer.github.com/v3/repos/#get-branch
  """
  @spec find(Client.t(), binary, binary, binary) :: Tentacat.response()
  def find(client \\ %Client{}, owner, repo, branch) do
    get("repos/#{owner}/#{repo}/branches/#{branch}", client)
  end

  @doc """
  Update Branch Protection.

  Create body example:

  ```elixir
  %{
    "required_status_checks" => %{
      "strict" => true,
      "contexts" => [
        "continuous-integration/travis-ci"
      ]
    },
    "enforce_admins" => true,
    "required_pull_request_reviews" => %{
      "dismissal_restrictions" => %{
        "users" => [
          "octocat"
        ],
        "teams" => [
          "justice-league"
        ]
      },
      "dismiss_stale_reviews" => true,
      "require_code_owner_reviews" => true,
      "required_approving_review_count" => 2
    },
    "restrictions" => %{
      "users" => [
        "octocat"
      ],
      "teams" => [
        "justice-league"
      ]
    }
  }
  ```

  ## Example

      Tentacat.Repositories.Branches.update_protection "elixir-lang", "elixir", "feature", body
      Tentacat.Repositories.Branches.update_protection client, "elixir-lang", "elixir", "feature", body

  More info at: https://developer.github.com/v3/repos/branches/#update-branch-protection
  """
  @spec update_protection(Client.t(), binary, binary, binary, map) :: Tentacat.response()
  def update_protection(client \\ %Client{}, owner, repo, branch, body) when is_map(body) do
    put("repos/#{owner}/#{repo}/branches/#{branch}/protection", client, body)
  end
end
