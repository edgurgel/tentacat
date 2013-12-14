defmodule Tentacat.Users do
  import Tentacat.Client.Base
  alias Tentacat.Client

  @doc """
  Get a single `user`

  ## Example

      Tentacat.Users.find "edgurgel", client
      Tentacat.Users.find "iurifq", client

  More info at: http://developer.github.com/v3/users/#get-a-single-user
  """
  @spec find(binary, Client.t) :: Base.response
  def find(user, client // Client.new) do
    get "users/#{user}", client.auth
  end

  @doc """
  Get the authenticated user passing a `client` with necessary credentials

  ## Example

      Tentacat.Users.me(client)

  More info at: http://developer.github.com/v3/users/#get-the-authenticated-user
  """
  @spec me(Client.t) :: Base.response
  def me(client) do
    get "user", client.auth
  end

  @doc """
  Get all users

  ## Example

      Tentacat.Users.list
      Tentacat.Users.list client

  More info at: http://developer.github.com/v3/users/#get-all-users
  """
  @spec list(Client.t) :: Base.response
  def list(client // Client.new) do
    get "users", client.auth
  end

  @doc """
  Get all users since `since` id

  ## Example

      Tentacat.Users.list_since 348
      Tentacat.Users.list_since 348, client

  More info at: http://developer.github.com/v3/users/#get-all-users
  """
  @spec list_since(integer, Client.t) :: Base.response
  def list_since(since, client // Client.new) do
    get "users", client.auth, [since: since]
  end

  @doc """
  Update the authenticated user

  Possible values for `options`:

  * [name: "name"]
  * [email: "email"]
  * [blog: "blog.com"]
  * [company: "My Company"]
  * [location: "Internet"]
  * [hireable: true]
  * [bio: "Hireable developer"]

  ## Example

      Tentacat.Users.update [email: "eduardo@gurgel.me", hireable: false], client

  More info at: http://developer.github.com/v3/users/#update-the-authenticated-user
  """
  @spec update(Keyword.t, Client.t) :: Base.response
  def update(options, client) do
    patch "user", client.auth, options
  end
end
