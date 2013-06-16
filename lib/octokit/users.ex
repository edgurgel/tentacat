defmodule Octokit.Users do
  import Octokit.Client

  def user(user) do
    get "users/#{user}"
  end

  def me(auth) do
    get "user", auth
  end

  def users do
    get "users"
  end
end
