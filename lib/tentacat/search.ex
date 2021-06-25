defmodule Tentacat.Search do
  import Tentacat
  alias Tentacat.Client

  @moduledoc """
  The Search API allows the search of pretty much anything on GitHub.
  """

  @doc """
  Search in code files.

  ## Example

      Tentacat.Search.code %{q: "code language:elixir repo:edgurgel/tentacat", sort: "url"}
      Tentacat.Search.code client, %{q: "code language:elixir repo:edgurgel/tentacat", sort: "url"}

  More info at: https://developer.github.com/v3/search/#search-code
  """
  @spec code(Client.t(), any, Keyword.t()) :: Tentacat.response()
  def code(client \\ %Client{}, params, options \\ []) do
    get("search/code", client, params, options)
  end

  @doc """
  Searches for users.

  ## Example

      Tentacat.Search.users %{q: "users language:elixir", sort: "followers"}
      Tentacat.Search.users client, %{q: "users language:elixir", sort: "followers"}

  More info at: https://developer.github.com/v3/search/#search-users
  """
  @spec users(Client.t(), any, Keyword.t()) :: Tentacat.response()
  def users(client \\ %Client{}, params, options \\ []) do
    get("search/users", client, params, options)
  end

  @doc """
  Searches for repositories.

  ## Example

      Tentacat.Search.repositories %{q: "elixir-lang language:elixir", sort: "stars"}
      Tentacat.Search.repositories client, %{q: "elixir-lang language:elixir", sort: "stars"}

  More info at: https://developer.github.com/v3/search/#search-repositories
  """
  @spec repositories(Client.t(), any, Keyword.t()) :: Tentacat.response()
  def repositories(client \\ %Client{}, params, options \\ []) do
    get("search/repositories", client, params, options)
  end

  @doc """
  Search in issues and pull requests.

  ## Example

      Tentacat.Search.issues %{q: "repo:edgurgel/tentacat is:merged", sort: "comments"}
      Tentacat.Search.issues client, %{q: "repo:edgurgel/tentacat is:merged", sort: "created"}

  More info at: https://developer.github.com/v3/search/#search-issues
  """
  @spec issues(Client.t(), any, Keyword.t()) :: Tentacat.response()
  def issues(client \\ %Client{}, params, options \\ []) do
    get("search/issues", client, params, options)
  end
end
