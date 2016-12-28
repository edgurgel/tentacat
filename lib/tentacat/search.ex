defmodule Tentacat.Search do
  import Tentacat
  alias Tentacat.Client
  @moduledoc """
  The Search API allows the search of pretty much anything on GitHub
  """

  @doc """
  Search in code files

  ## Example

      Tentacat.Search.code %{q: "code language:elixir repo:edgurgel/tentacat", sort: "url"}
      Tentacat.Search.code %{q: "code language:elixir repo:edgurgel/tentacat", sort: "url"}, client, [pagination: :none]

  More info at: https://developer.github.com/v3/search/#search-code
  """
  @spec code(map, Client.t, [atom]) :: Tentacat.response
  def code(params, client \\ %Client{}, options \\ []) do
    get "search/code", client, params, options
  end

  @doc """
  Searches for users

  ## Example

      Tentacat.Search.users %{q: "users language:elixir", sort: "followers"}
      Tentacat.Search.users %{q: "users language:elixir", sort: "followers"}, client, [pagination: :none]

  More info at: https://developer.github.com/v3/search/#search-users
  """
  @spec users(map, Client.t, [atom]) :: Tentacat.response
  def users(params, client \\ %Client{}, options \\ []) do
    get "search/users", client, params, options
  end

  @doc """
  Searches for repositories

  ## Example

      Tentacat.Search.repositories %{q: "elixir-lang language:elixir", sort: "stars"}
      Tentacat.Search.repositories %{q: "elixir-lang language:elixir", sort: "stars"}, client
      Tentacat.Search.repositories %{q: "elixir-lang language:elixir", sort: "stars"}, client, [pagination: :none]

  More info at: https://developer.github.com/v3/search/#search-repositories
  """
  @spec repositories(map, Client.t, [atom]) :: Tentacat.response
  def repositories(params, client \\ %Client{}, options \\ [] ) do
    get "search/repositories", client, params, options
  end
end
