defmodule Tentacat.Search do
  import Tentacat
  alias Tentacat.Client
  @moduledoc """
  The Search API allows the search of pretty much anything on GitHub
  """

  @doc """
  Search in code files

  ## Example

      Tentacat.Search.code "language:elixir"
      Tentacat.Search.code "language:elixir", client

  More info at: https://developer.github.com/v3/search/#search-code
  """
  @spec list(binary, Client.t) :: Tentacat.response
  def code(q, client \\ %Client{}) do
    get "search/code?q=#{q}", client
  end

  @doc """
  Search in code files sorted by a custom identifier and a specified order

  ## Example

      Tentacat.Search.code "language:elixir", "indexed", "asc"
      Tentacat.Search.code "language:elixir", "indexed", "asc", client

  More info at: https://developer.github.com/v3/search/#search-code
  """
  @spec list(binary, binary, binary, Client.t) :: Tentacat.response
  def code(q, sort, order, client \\ %Client{}) do
    get "search/code?q=#{q}&sort=#{sort}&order=#{order}", client
  end
end
