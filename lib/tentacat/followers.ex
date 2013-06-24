defmodule Tentacat.Users.Followers do
  import Tentacat.Client

  @doc """
  List followers for the authenticated user

  ## Example

      Tentacat.Users.Followers.following(access_token: "91898192219")

  More info at: http://developer.github.com/v3/users/followers/#list-users-followed-by-another-user
  """
  @spec following(Client.auth) :: :jsx.json_term
  def following(auth) do
    get "user/following", auth
  end

  @doc """
  List users the authenticated user follows

  ## Example

      Tentacat.Users.Followers.followers(access_token: "91898192219")

  More info at: http://developer.github.com/v3/users/followers/#list-followers-of-a-user
  """
  @spec followers(Client.auth) :: :jsx.json_term
  def followers(auth) do
    get "user/followers", auth
  end
end
