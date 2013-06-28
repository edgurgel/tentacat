defmodule Tentacat.Users.Keys do
  import Tentacat.Client.Base
  alias Tentacat.Client

  @doc """
  List public keys for a user

  ## Example

      Tentacat.Users.Keys.list "bastos", client
      Tentacat.Users.Keys.list "bastos"

  More info at: http://developer.github.com/v3/users/keys/#list-public-keys-for-a-user and http://developer.github.com/v3/users/keys/#list-your-public-keys
  """
  @spec list(binary, Client.t) :: :jsx.json_term
  def list(user, client // Client.new) do
    get "users/#{user}/keys", client.auth
  end

  @doc """
  List public keys for the authenticated user

  ## Example

      Tentacat.Users.Keys.list_mine client

  More info at: http://developer.github.com/v3/users/keys/#list-public-keys-for-a-user and http://developer.github.com/v3/users/keys/#list-your-public-keys
  """
  @spec list_mine(Client.t) :: :jsx.json_term
  def list_mine(client) do
    get "user/keys", client.auth
  end

  @doc """
  Get a single public key of the authorized user

  ## Example

      Tentacat.Users.Keys.find 1, client

  More info at: http://developer.github.com/v3/users/keys/#get-a-single-public-key
  """
  @spec find(integer, Client.t) :: :jsx.json_term
  def find(id, client) do
    get "user/keys/#{id}", client.auth
  end

  @doc """
  Create a public key on the authorized user

  ## Example

      Tentacat.Users.Keys.create("title", "ssh-rsa AAA...", client)

  More info at:http://developer.github.com/v3/users/keys/#create-a-public-key
  """
  @spec create(binary, binary, Client.t) :: :jsx.json_term
  def create(title, key, client) do
    post "user/keys", client.auth, [title: title, key: key]
  end

  @doc """
  Update a public key from the authorized user

  ## Example

      Tentacat.Users.Keys.update(123, "title", "ssh-rsa ...", client)

  More info at: http://developer.github.com/v3/users/keys/#update-a-public-key
  """
  @spec update(integer, binary, binary, Client.t) :: :jsx.json_term
  def update(id, title, key, client) do
    patch "user/keys/#{id}", client.auth, [title: title, key: key]
  end

  @doc """
  Delete a public from the authorized user

  ## Example

      Tentacat.Users.Keys.remove 123, client

  More info at: http://developer.github.com/v3/users/keys/#delete-a-public-key
  """
  @spec remove(integer, Client.t) :: any
  def remove(id, client) do
    delete "user/keys/#{id}", client.auth
  end
end
