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
      Tentacat.Search.code %{q: "code language:elixir repo:edgurgel/tentacat", sort: "url"}, client

  More info at: https://developer.github.com/v3/search/#search-code
  """
  # @spec list(binary, Client.t) :: Tentacat.response
  def code(params, client \\ %Client{}) do
    get "search/code", client, params
  end
end
