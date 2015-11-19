defmodule Tentacat.Issues do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List issues

  ## Example

      Tentacat.Issues.list "elixir-lang", "elixir"
      Tentacat.Issues.list "elixir-lang", "elixir", client

  More info at: https://developer.github.com/v3/issues/#list-issues
  """
  @spec list(binary, binary, Client.t) :: Tentacat.response
  def list(owner, repo, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/issues", client
  end

@doc """
  Filter issues

  ## Example

      Tentacat.Issues.list "elixir-lang", "elixir", %{state: "open"}
      Tentacat.Issues.list "elixir-lang", "elixir", %{state: "open"}, client

  More info at: https://developer.github.com/v3/pulls/#parameters
  """
  @spec filter(binary, binary, map, Client.t) :: Tentacat.response
  def filter(owner, repo, filters, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/issues?#{URI.encode_query(filters)}", client
  end

  @doc """
  Get a single issue

  ## Example

      Tentacat.Issues.find "elixir-lang", "elixir", "2974"
      Tentacat.Issues.find "elixir-lang", "elixir", "2974", client

  More info at: https://developer.github.com/v3/pulls/#get-a-single-issue
  """
  @spec find(binary, binary, binary | integer, Client.t) :: Tentacat.response
  def find(owner, repo, number, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/issues/#{number}", client
  end
end
