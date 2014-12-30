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
    get "user/starred", client.auth
  end

  @doc """
  List starred repositories for given user

  ## Example

      Tentacat.Users.Starring.starred "edgurgel", client

  More info at: https://developer.github.com/v3/activity/starring/#list-repositories-being-starred
  """
  @spec starred(binary, Client.t) :: Tentacat.response
  def starred(user_name, client) do
    get "users/#{user_name}/starred", client.auth
  end
end
