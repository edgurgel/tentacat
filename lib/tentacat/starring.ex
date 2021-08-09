defmodule Tentacat.Users.Starring do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Lists the people that have starred the repository.

  ## Example

      Tentacat.Users.Starring.stargazers client, "edgurgel", "tentacat"

  More info at: https://developer.github.com/v3/activity/starring/#list-stargazers
  """
  @spec stargazers(Client.t(), binary, binary) :: Tentacat.response()
  def stargazers(client, owner, repo) do
    get("repos/#{owner}/#{repo}/stargazers", client)
  end

  @doc """
  List starred repositories for the authenticated user.

  ## Example

      Tentacat.Users.Starring.starred client

  More info at: https://developer.github.com/v3/activity/starring/#list-repositories-being-starred
  """
  @spec starred(Client.t()) :: Tentacat.response()
  def starred(client) do
    get("user/starred", client)
  end

  @doc """
  List starred repositories for given user.

  ## Example

      Tentacat.Users.Starring.starred client, "edgurgel"

  More info at: https://developer.github.com/v3/activity/starring/#list-repositories-being-starred
  """
  @spec starred(Client.t(), binary) :: Tentacat.response()
  def starred(client, user_name) do
    get("users/#{user_name}/starred", client)
  end

  @doc """
  Check if authenticated user is starred given repository.

  ## Example

      Tentacat.Users.Starring.starred? client, "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/activity/starring/#check-if-you-are-starring-a-repository
  """
  @spec starred?(Client.t(), binary, binary) :: boolean | Tentacat.response()
  def starred?(client, owner, repo) do
    starred_check("user/starred/#{owner}/#{repo}", client)
  end

  defp starred_check(starred_api_url, client) do
    case get(starred_api_url, client) do
      {204, _, resp} -> {204, true, resp}
      {404, _, resp} -> {404, false, resp}
      unexpected_response -> unexpected_response
    end
  end

  @doc """
  Star a given repository.

  ## Example

      Tentacat.Users.Starring.star client, "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/activity/starring/#star-a-repository
  """
  @spec star(Client.t(), binary, binary) :: true | Tentacat.response()
  def star(client, owner, repo) do
    star_response(put("user/starred/#{owner}/#{repo}", client))
  end

  @doc """
  Unstar a given repository.

  ## Example

      Tentacat.Users.Starring.unstar client, "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/activity/starring/#unstar-a-repository
  """
  @spec unstar(Client.t(), binary, binary) :: true | Tentacat.response()
  def unstar(client, owner, repo) do
    star_response(delete("user/starred/#{owner}/#{repo}", client))
  end

  defp star_response(response) do
    case response do
      {204, _, resp} -> {204, true, resp}
      unexpected_response -> unexpected_response
    end
  end
end
