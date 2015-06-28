defmodule Tentacat.Search do
  import Tentacat
  alias Tentacat.Client
  @moduledoc """
  The Search API allows the search of pretty much anything on GitHub
  """

  @doc """
  Search in code files

  ## Example

      Tentacat.Search.code %{q: "language:elixir"}
      Tentacat.Search.code %{q: "language:elixir"}, client

  More info at: https://developer.github.com/v3/search/#search-code
  """
  # @spec list(binary, Client.t) :: Tentacat.response
  def code(params, client \\ %Client{}) do
    get "search/code", client, params, false
  end
end
