defmodule Tentacat.Users.Followers do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List followers for the authenticated user.

  ## Example

      Tentacat.Users.Followers.following client

  More info at: http://developer.github.com/v3/users/followers/#list-users-followed-by-another-user
  """
  @spec following(Client.t()) :: Tentacat.response()
  def following(client) when is_map(client) do
    following(client, [])
  end

  def following(client, options) when is_map(client) and is_list(options) do
    get("user/following", client, [], options)
  end

  @doc """
  List followers for given user.

  ## Example

      Tentacat.Users.Followers.following client, "edgurgel"

  More info at: http://developer.github.com/v3/users/followers/#list-users-followed-by-another-user
  """
  def following(client, user_name) when is_binary(user_name) and is_map(client) do
    following(client, user_name, [])
  end

  def following(client, user_name, options)
      when is_binary(user_name) and is_map(client) and is_list(options) do
    get("users/#{user_name}/following", client, [], options)
  end

  @doc """
  List users the authenticated user follows.

  ## Example

      Tentacat.Users.Followers.followers client

  More info at: http://developer.github.com/v3/users/followers/#list-followers-of-a-user
  """
  @spec followers(Client.t()) :: Tentacat.response()
  def followers(client) do
    get("user/followers", client)
  end

  @doc """
  List users the given user follows.

  ## Example

      Tentacat.Users.Followers.followers client, "edgurgel"

  More info at: http://developer.github.com/v3/users/followers/#list-followers-of-a-user
  """
  def followers(client, user_name) do
    get("users/#{user_name}/followers", client)
  end

  @doc """
  Check if authenticated user follows given user.

  ## Example

      Tentacat.Users.Followers.following? client, "edgurgel"

  More info at: https://developer.github.com/v3/users/followers/#check-if-you-are-following-a-user
  """
  def following?(client, target_user) do
    following_check("user/following/#{target_user}", client)
  end

  @doc """
  Check if given user follows another given user.

  ## Example

      Tentacat.Users.Followers.following? client, "edgurgel", "iurifq"

  More info at: https://developer.github.com/v3/users/followers/#check-if-one-user-follows-another
  """
  def following?(client, user_name, target_user) do
    following_check("users/#{user_name}/following/#{target_user}", client)
  end

  defp following_check(following_api_url, client) do
    case get(following_api_url, client) do
      {204, _, resp} -> {204, true, resp}
      {404, _, resp} -> {404, false, resp}
      unexpected_response -> unexpected_response
    end
  end

  @doc """
  Follow given user.

  ## Example

      Tentacat.Users.Followers.follow client, "edgurgel"

  More info at: https://developer.github.com/v3/users/followers/#follow-a-user
  """
  def follow(client, target_user) do
    follow_response(put("user/following/#{target_user}", client))
  end

  @doc """
  Unfollow given user.

  ## Example

      Tentacat.Users.Followers.unfollow client, "edgurgel"

  More info at: https://developer.github.com/v3/users/followers/#unfollow-a-user
  """
  def unfollow(client, target_user) do
    follow_response(delete("user/following/#{target_user}", client))
  end

  defp follow_response(response) do
    case response do
      {204, _, resp} -> {204, true, resp}
      unexpected_response -> unexpected_response
    end
  end
end
