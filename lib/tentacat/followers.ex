defmodule Tentacat.Users.Followers do
  import Tentacat.Client.Base
  alias Tentacat.Client

  @doc """
  List followers for the authenticated user

  ## Example

      Tentacat.Users.Followers.following client

  More info at: http://developer.github.com/v3/users/followers/#list-users-followed-by-another-user
  """
  @spec following(Client.t) :: :jsx.json_term
  def following(client) do
    get "user/following", client.auth
  end

  @doc """
  List users the authenticated user follows

  ## Example

      Tentacat.Users.Followers.followers client

  More info at: http://developer.github.com/v3/users/followers/#list-followers-of-a-user
  """
  @spec followers(Client.t) :: :jsx.json_term
  def followers(client) do
    get "user/followers", client.auth
  end
end
