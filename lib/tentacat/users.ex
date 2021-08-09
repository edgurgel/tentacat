defmodule Tentacat.Users do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Get a single `user`.

  ## Example

      Tentacat.Users.find client, "edgurgel"
      Tentacat.Users.find client, "iurifq"

  More info at: http://developer.github.com/v3/users/#get-a-single-user
  """
  @spec find(Client.t(), binary) :: Tentacat.response()
  def find(client \\ %Client{}, user) do
    get("users/#{user}", client)
  end

  @doc """
  Get the authenticated user passing a `client` with necessary credentials.

  ## Example

      Tentacat.Users.me(client)

  More info at: http://developer.github.com/v3/users/#get-the-authenticated-user
  """
  @spec me(Client.t()) :: Tentacat.response()
  def me(client) do
    get("user", client)
  end

  @doc """
  Get all users.

  ## Example

      Tentacat.Users.list
      Tentacat.Users.list client

  More info at: http://developer.github.com/v3/users/#get-all-users
  """
  @spec list(Client.t(), any) :: Tentacat.response()
  def list(client \\ %Client{}, options \\ []) do
    get("users", client, [], Keyword.merge([pagination: :none], options))
  end

  @doc """
  Get all users since `since` id.

  ## Example

      Tentacat.Users.list_since 348
      Tentacat.Users.list_since 348, client

  More info at: http://developer.github.com/v3/users/#get-all-users
  """
  @spec list_since(Client.t(), integer, any) :: Tentacat.response()
  def list_since(client \\ %Client{}, since, options \\ []) do
    get("users", client, [since: since], Keyword.merge([pagination: :none], options))
  end

  @doc """
  Update the authenticated user.

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
  @spec update(Client.t(), Keyword.t()) :: Tentacat.response()
  def update(client, options) do
    patch("user", client, options)
  end
end
