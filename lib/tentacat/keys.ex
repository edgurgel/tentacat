defmodule Tentacat.Users.Keys do
  defmacro __using__(_) do
    import Tentacat.Client.Base
    quote do

      @doc """
      List public keys for a user or for the authenticated user

      ## Example

          client.keys "bastos"
          client.keys

      More info at: http://developer.github.com/v3/users/keys/#list-public-keys-for-a-user and http://developer.github.com/v3/users/keys/#list-your-public-keys
      """
      @spec keys(binary, Client) :: :jsx.json_term
      def keys(user, self) do
        get "users/#{user}/keys", self.auth
      end

      @spec keys(Client) :: :jsx.json_term
      def keys(self) do
        get "user/keys", self.auth
      end

      @doc """
      Get a single public key of the authorized user

      ## Example

          client.key 1

      More info at: http://developer.github.com/v3/users/keys/#get-a-single-public-key
      """
      @spec key(integer, Client) :: :jsx.json_term
      def key(id, self) do
        get "user/keys/#{id}", self.auth
      end

      @doc """
      Create a public key on the authorized user

      ## Example

          client.create_key("title", "ssh-rsa AAA...")

      More info at:http://developer.github.com/v3/users/keys/#create-a-public-key
      """
      @spec create_key(binary, binary, Client) :: :jsx.json_term
      def create_key(title, key, self) do
        post "user/keys", self.auth, [title: title, key: key]
      end

      @doc """
      Update a public key from the authorized user

      ## Example

          client.update_key(123, "title", "ssh-rsa ...")

      More info at: http://developer.github.com/v3/users/keys/#update-a-public-key
      """
      @spec update_key(integer, binary, binary, Client) :: :jsx.json_term
      def update_key(id, title, key, self) do
        patch "user/keys/#{id}", self.auth, [title: title, key: key]
      end

      @doc """
      Delete a public from the authorized user

      ## Example

          client.remove_key 123

      More info at: http://developer.github.com/v3/users/keys/#delete-a-public-key
      """
      @spec remove_key(integer, Client) :: any
      def remove_key(id, self) do
        delete "user/keys/#{id}", self.auth
      end
    end
  end
end
