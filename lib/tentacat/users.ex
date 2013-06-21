defmodule Tentacat.Users do
  import Tentacat.Client

  defdelegate [ emails(auth) ], to: Tentacat.Users.Emails
  defdelegate [ keys(user_or_auth), key(id, auth) ], to: Tentacat.Users.Keys
  defdelegate [ followers(auth) ], to: Tentacat.Users.Followers

  @doc """
  Get a single `user`

  ## Example

      Tentacat.Users.user("edgurgel")
      Tentacat.Users.user("iurifq")

  More info at: http://developer.github.com/v3/users/#get-a-single-user
  """
  @spec user(binary) :: :jsx.json_term
  def user(user) do
    get "users/#{user}"
  end

  @doc """
  Get the authenticated user passing an `auth` information described at Tentacat.Client.authorization_header

  ## Example

      Tentacat.Users.me(access_token: "91898192219")

  More info at: http://developer.github.com/v3/users/#get-the-authenticated-user
  """
  @spec me(Client.auth) :: :jsx.json_term
  def me(auth) do
    get "user", auth
  end

  @doc """
  Get all users

  ## Example

      Tentacat.Users.users
      Tentacat.Users.users(348)

  More info at: http://developer.github.com/v3/users/#get-all-users
  """
  @spec users :: :jsx.json_term
  def users(since // nil) do
    if since, do: get("users", nil, [since: since]),
    else: get "users"
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

      Tentacat.Users.update([user: "user", password: "pass"], email: "eduardo@gurgel.me", hireable: false)

  More info at: http://developer.github.com/v3/users/#update-the-authenticated-user
  """
  @spec update(Client.auth, Keyword.t) :: :jsx.json_term
  def update(auth, options) do
    patch("user", auth, options)
  end
end
