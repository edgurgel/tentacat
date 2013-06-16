defmodule Octokit.Users do
  import Octokit.Client

  @doc """
  Get a single `user`

  More info at: http://developer.github.com/v3/users/#get-a-single-user
  """
  @spec user(binary) :: :jsx.json_term
  def user(user) do
    get "users/#{user}"
  end

  @doc """
  Get the authenticated user passing an `auth` information described at Octokit.Client.authorization_header

  More info at: http://developer.github.com/v3/users/#get-the-authenticated-user
  """
  @spec me([user: binary, password: binary] | [access_token: binary]) :: :jsx.json_term
  def me(auth) do
    get "user", auth
  end

  @doc """
  Get all users

  More info at: http://developer.github.com/v3/users/#get-all-users
  """
  @spec users :: :jsx.json_term
  def users do
    get "users"
  end
end
