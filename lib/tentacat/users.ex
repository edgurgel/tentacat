defmodule Tentacat.Users do
  import Tentacat.Client

  defdelegate [emails(auth), create(emails, auth), destroy(emails, auth)], to: Tentacat.Users.Emails

  @doc """
  Get a single `user`

  More info at: http://developer.github.com/v3/users/#get-a-single-user
  """
  @spec user(binary) :: :jsx.json_term
  def user(user) do
    get "users/#{user}"
  end

  @doc """
  Get the authenticated user passing an `auth` information described at Tentacat.Client.authorization_header

  More info at: http://developer.github.com/v3/users/#get-the-authenticated-user
  """
  @spec me(Client.auth) :: :jsx.json_term
  def me(auth) do
    get "user", auth
  end

  @doc """
  Get all users

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
  """
  @spec update(Client.auth, Keyword.t) :: :jsx.json_term
  def update(auth, options) do
    patch("user", auth, options)
  end
end
