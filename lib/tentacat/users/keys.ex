defmodule Tentacat.Users.Keys do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List public keys for a user.

  ## Example

      Tentacat.Users.Keys.list "bastos"
      Tentacat.Users.Keys.list client, "bastos"

  More info at: http://developer.github.com/v3/users/keys/#list-public-keys-for-a-user and http://developer.github.com/v3/users/keys/#list-your-public-keys
  """
  @spec list(Client.t(), binary) :: Tentacat.response()
  def list(client \\ %Client{}, user) do
    get("users/#{user}/keys", client)
  end

  @doc """
  List public keys for the authenticated user.

  ## Example

      Tentacat.Users.Keys.list_mine client

  More info at: http://developer.github.com/v3/users/keys/#list-public-keys-for-a-user and http://developer.github.com/v3/users/keys/#list-your-public-keys
  """
  @spec list_mine(Client.t()) :: Tentacat.response()
  def list_mine(client) do
    get("user/keys", client)
  end

  @doc """
  Get a single public key of the authorized user.

  ## Example

      Tentacat.Users.Keys.find 1, client

  More info at: http://developer.github.com/v3/users/keys/#get-a-single-public-key
  """
  @spec find(Client.t(), integer) :: Tentacat.response()
  def find(client, id) do
    get("user/keys/#{id}", client)
  end

  @doc """
  Create a public key on the authorized user.

  ## Example

      Tentacat.Users.Keys.create(client, "title", "ssh-rsa AAA...")

  More info at:http://developer.github.com/v3/users/keys/#create-a-public-key
  """
  @spec create(Client.t(), binary, binary) :: Tentacat.response()
  def create(client, title, key) do
    post("user/keys", client, %{title: title, key: key})
  end

  @doc """
  Update a public key from the authorized user.

  ## Example

      Tentacat.Users.Keys.update(client, 123, "title", "ssh-rsa ...")

  More info at: http://developer.github.com/v3/users/keys/#update-a-public-key
  """
  @spec update(Client.t(), integer, binary, binary) :: Tentacat.response()
  def update(client, id, title, key) do
    patch("user/keys/#{id}", client, %{title: title, key: key})
  end

  @doc """
  Delete a public from the authorized user.

  ## Example

      Tentacat.Users.Keys.remove client, 123

  More info at: http://developer.github.com/v3/users/keys/#delete-a-public-key
  """
  @spec remove(Client.t(), integer) :: any
  def remove(client, id) do
    delete("user/keys/#{id}", client)
  end
end
