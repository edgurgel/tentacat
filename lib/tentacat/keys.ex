defmodule Tentacat.Users.Keys do
  import Tentacat.Client

  @doc """
  List public keys for a user or for the authenticated user

  ## Example

      Tentacat.Users.Keys.keys("bastos")
      Tentacat.Users.Keys.keys([access_token: "2983982"])
      Tentacat.Users.Keys.keys([user: "iurifq", password: "98921"])

  More info at: http://developer.github.com/v3/users/keys/#list-public-keys-for-a-user and http://developer.github.com/v3/users/keys/#list-your-public-keys
  """
  @spec keys(binary | Client.auth) :: :jsx.json_term
  def keys(user) when is_binary(user) do
    get "users/#{user}/keys"
  end

  def keys(auth) when is_list(auth) do
    get "user/keys", auth
  end

  @doc """
  Get a single public key of the authorized user

  ## Example

      Tentacat.Users.Keys.key(1, [access_token: "2983925"])

  More info at: http://developer.github.com/v3/users/keys/#get-a-single-public-key
  """
  @spec key(integer, Client.auth) :: :jsx.json_term
  def key(id, auth) when is_integer(id) do
    get "user/keys/#{id}", auth
  end

  @doc """
  Create a public key on the authorized user

  ## Example

      Tentacat.Users.Keys.create("title", "ssh-rsa AAA...", [access_token: "938492c"])

  More info at:http://developer.github.com/v3/users/keys/#create-a-public-key
  """
  @spec create(binary, binary, Client.auth) :: :jsx.json_term
  def create(title, key, auth) do
    post "user/keys", auth, [title: title, key: key]
  end

  @doc """
  Update a public key from the authorized user

  ## Example

      Tentacat.Users.Keys.update(123, "title", "ssh-rsa ...", [user: "alissonsales", password: "pass"])

  More info at: http://developer.github.com/v3/users/keys/#update-a-public-key
  """
  @spec update(integer, binary, binary, Client.auth) :: :jsx.json_term
  def update(id, title, key, auth) do
    patch "user/keys/#{id}", auth, [title: title, key: key]
  end

  @doc """
  Delete a public from the authorized user

  ## Example

      Tentacat.Users.Keys.destroy(123, [access_token: "9218923"])

  More info at: http://developer.github.com/v3/users/keys/#delete-a-public-key
  """
  @spec destroy(integer, Client.auth) :: any
  def destroy(id, auth) do
    delete "user/keys/#{id}", auth
  end


end
