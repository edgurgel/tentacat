defmodule Octokit.Users do
  import Octokit.Client

  def user(user) do
    get "users/#{user}"
  end
end
