defmodule Tentacat.Users.Starring do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List starred repositories for the authenticated user

  ## Example

      Tentacat.Users.Starring.starred client

  More info at: https://developer.github.com/v3/activity/starring/#list-repositories-being-starred
  """
  @spec starred(Client.t) :: Tentacat.response
  def starred(client) do
    get "user/starred", client
  end

  @doc """
  List starred repositories for given user

  ## Example

      Tentacat.Users.Starring.starred "edgurgel", client

  More info at: https://developer.github.com/v3/activity/starring/#list-repositories-being-starred
  """
  @spec starred(binary, Client.t) :: Tentacat.response
  def starred(user_name, client) do
    get "users/#{user_name}/starred", client
  end
  
  @doc """
  Check if authenticated user is starred given repository.

  ## Example

      Tentacat.Users.Starring.starred? "elixir-lang", "elixir", client

  More info at: https://developer.github.com/v3/activity/starring/#check-if-you-are-starring-a-repository
  """
  @spec starred?(binary, binary, Client.t) :: boolean | Tentacat.response
  def starred?(owner, repo, client) do
    starred_check("user/starred/#{owner}/#{repo}", client)
  end

  defp starred_check(starred_api_url, client) do
    case get starred_api_url, client do
      { 204, _ } -> true
      { 404, _ } -> false
      unexpected_response -> unexpected_response
    end
  end

  @doc """
  Star a given repository.

  ## Example

      Tentacat.Users.Starring.star "elixir-lang", "elixir", client

  More info at: https://developer.github.com/v3/activity/starring/#star-a-repository
  """
  @spec star(binary, binary, Client.t) :: true | Tentacat.response
  def star(owner, repo, client) do
    star_response put "user/starred/#{owner}/#{repo}", client
  end

  @doc """
  Unstar a given repository.

  ## Example

      Tentacat.Users.Starring.unstar "elixir-lang", "elixir", client

  More info at: https://developer.github.com/v3/activity/starring/#unstar-a-repository
  """
  @spec unstar(binary, binary, Client.t) :: true | Tentacat.response
  def unstar(owner, repo, client) do
    star_response delete "user/starred/#{owner}/#{repo}", client
  end

  defp star_response(response) do
    case response do
      { 204, _ } -> true
      unexpected_response -> unexpected_response
    end
  end
end
