defmodule Tentacat.Issues do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List repository issues.

  ## Example

      Tentacat.Issues.list "elixir-lang", "elixir"
      Tentacat.Issues.list client, "elixir-lang", "elixir"

  More info at: https://docs.github.com/en/free-pro-team@latest/rest/reference/issues#list-repository-issues
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/issues", client)
  end

  @doc """
  Filter repository issues.

  ## Example

      Tentacat.Issues.filter "elixir-lang", "elixir", %{state: "open"}
      Tentacat.Issues.filter client, "elixir-lang", "elixir", %{state: "open"}

  More info at: https://docs.github.com/en/free-pro-team@latest/rest/reference/issues#list-repository-issues
  """
  @spec filter(Client.t(), binary, binary, map) :: Tentacat.response()
  def filter(client \\ %Client{}, owner, repo, filters) do
    get("repos/#{owner}/#{repo}/issues?#{URI.encode_query(filters)}", client)
  end

  @doc """
  Get an issue.

  ## Example

      Tentacat.Issues.find "elixir-lang", "elixir", "2974"
      Tentacat.Issues.find client, "elixir-lang", "elixir", "2974"

  More info at: https://docs.github.com/en/free-pro-team@latest/rest/reference/issues#get-an-issue
  """
  @spec find(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def find(client \\ %Client{}, owner, repo, number) do
    get("repos/#{owner}/#{repo}/issues/#{number}", client)
  end

  @doc """
  Create an issue.

  Possible values for `body`:

    * %{title: "title of issue"} (required)
    * %{body: "body of issue"}
    * %{assignee: "username"}
    * %{milestone: 4}
    * %{labels: ["bug", "frontend"]}

  ## Example

      Tentacat.Issues.create "elixir-lang", "elixir", %{"title" => "Issue", "body" => "Details"}
      Tentacat.Issues.create client, "elixir-lang", "elixir", %{"title" => "Issue", "body" => "Details"}

  More info at: https://docs.github.com/en/free-pro-team@latest/rest/reference/issues#create-an-issue
  """
  @spec create(Client.t(), binary, binary, map) :: Tentacat.response()
  def create(client \\ %Client{}, owner, repo, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/issues", client, body)
  end

  @doc """
  Update an issue.

  Possible values for `body`:

    * %{title: "title of issue"}
    * %{body: "body of issue"}
    * %{assignee: "username"}
    * %{state: "closed"}
    * %{milestone: 4}
    * %{labels: ["bug", "frontend"]}

  ## Example

      Tentacat.Issues.update "elixir-lang", "elixir", "2974", %{"assignee" => "edgurgel"}
      Tentacat.Issues.update client, "elixir-lang", "elixir", "2974", %{"state" => "closed"}

  More info at: https://docs.github.com/en/free-pro-team@latest/rest/reference/issues#update-an-issue
  """
  @spec update(Client.t(), binary, binary, binary | integer, map) :: Tentacat.response()
  def update(client \\ %Client{}, owner, repo, number, body) when is_map(body) do
    patch("repos/#{owner}/#{repo}/issues/#{number}", client, body)
  end
end
