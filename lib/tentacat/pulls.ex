defmodule Tentacat.Pulls do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List pull requests.

  ## Example

      Tentacat.Pulls.list "elixir-lang", "elixir"
      Tentacat.Pulls.list client, "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/pulls/#list-pull-requests
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/pulls", client)
  end

  @doc """
  Filter pull requests.

  ## Example

      Tentacat.Pulls.filter "elixir-lang", "elixir", %{state: "open"}
      Tentacat.Pulls.filter client, "elixir-lang", "elixir", %{state: "open"}

  More info at: https://developer.github.com/v3/pulls/#parameters
  """
  @spec filter(Client.t(), binary, binary, map) :: Tentacat.response()
  def filter(client \\ %Client{}, owner, repo, filters) do
    get("repos/#{owner}/#{repo}/pulls?#{URI.encode_query(filters)}", client)
  end

  @doc """
  Get a single pull request.

  ## Example

      Tentacat.Pulls.find "elixir-lang", "elixir", "2974"
      Tentacat.Pulls.find client, "elixir-lang", "elixir", "2974"

  More info at: https://developer.github.com/v3/pulls/#get-a-single-pull-request
  """
  @spec find(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def find(client \\ %Client{}, owner, repo, number) do
    get("repos/#{owner}/#{repo}/pulls/#{number}", client)
  end

  @doc """
  Create a pull request.

  Pull Request body example:

  ```elixir
  %{
    "title" => "Amazing new feature",
    "body"  => "Please pull this in!",
    "head"  => "octocat:new-feature",
    "base"  => "master"
   }
  ```

  Alternative input (using an existing issue):

  ```elixir
  %{
    "issue" => "5",
    "head"  => "octocat:new-feature",
    "base"  => "master"
   }
  ```

  ## Example

      Tentacat.Pulls.create client, "elixir-lang", "elixir", body

  More info at: https://developer.github.com/v3/pulls/#create-a-pull-request
  """
  @spec create(Client.t(), binary, binary, map) :: Tentacat.response()
  def create(client, owner, repo, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/pulls", client, body)
  end

  @doc """
  Update a pull request.

  Pull Request body example:

  ```elixir
  %{
    "title" => "new title",
    "body"  => "updated body",
    "state" => "open"
   }
  ```

  ## Example

      Tentacat.Pulls.update client, "elixir-lang", "elixir", "2974", body

  More info at: https://developer.github.com/v3/pulls/#update-a-pull-request
  """
  @spec update(Client.t(), binary, binary, binary | integer, map) :: Tentacat.response()
  def update(client, owner, repo, number, body) when is_map(body) do
    patch("repos/#{owner}/#{repo}/pulls/#{number}", client, body)
  end

  @doc """
  Merge a pull request (Merge Button).

  Pull Request Merge body example:

  ```elixir
  %{
    "commit_message" => "not the default commit_message",
    "sha"  => "8e50d79f2ba0d665b9966908cbf22c6f463228d6"
   }
  ```

  ## Example

      Tentacat.Pulls.merge client, "elixir-lang", "elixir", "4876", body

  More info at: https://developer.github.com/v3/pulls/#merge-a-pull-request-merge-button
  """
  @spec merge(Client.t(), binary, binary, binary | integer, map) :: Tentacat.response()
  def merge(client, owner, repo, number, body) when is_map(body) do
    put("repos/#{owner}/#{repo}/pulls/#{number}/merge", client, body)
  end

  @doc """
  Get if a pull request has been merged.

  ## Example

      Tentacat.Pulls.has_been_merged client, "elixir-lang", "elixir", "4876"

  More info at: https://developer.github.com/v3/pulls/#get-if-a-pull-request-has-been-merged
  """
  @spec has_been_merged(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def has_been_merged(client, owner, repo, number) do
    get("repos/#{owner}/#{repo}/pulls/#{number}/merge", client)
  end
end
