defmodule Tentacat.Users do
  defmacro __using__(_) do
    import Tentacat.Client.Base
    quote do

      @doc """
      Get a single `user`

      ## Example

          client.user "edgurgel"
          client.user "iurifq"

      More info at: http://developer.github.com/v3/users/#get-a-single-user
      """
      @spec user(binary, Client) :: :jsx.json_term
      def user(user, self) do
        get "users/#{user}", self.auth
      end

      @doc """
      Get the authenticated user passing an `auth` information described at Tentacat.Client.authorization_header

      ## Example

          client.user

      More info at: http://developer.github.com/v3/users/#get-the-authenticated-user
      """
      @spec user(Client) :: :jsx.json_term
      def user(self) do
        get "user", self.auth
      end

      @doc """
      Get all users

      ## Example

          client.users
          client.users 348

      More info at: http://developer.github.com/v3/users/#get-all-users
      """
      @spec users(integer, Client) :: :jsx.json_term
      def users(since, self) do
        get("users", self.auth, [since: since])
      end
      @spec users(Client) :: :jsx.json_term
      def users(self) do
        get "users", self.auth
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

          client.update_user [email: "eduardo@gurgel.me", hireable: false]

      More info at: http://developer.github.com/v3/users/#update-the-authenticated-user
      """
      @spec update_user(Keyword.t, Client) :: :jsx.json_term
      def update_user(options, self) do
        patch("user", self.auth, options)
      end
    end
  end
end
