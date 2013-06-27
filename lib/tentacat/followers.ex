defmodule Tentacat.Users.Followers do
  defmacro __using__(_) do

    import Tentacat.Client.Base
    quote do

      @doc """
      List followers for the authenticated user

      ## Example

          client.following

      More info at: http://developer.github.com/v3/users/followers/#list-users-followed-by-another-user
      """
      @spec following(Client.t) :: :jsx.json_term
      def following(self) do
        get "user/following", self.auth
      end

      @doc """
      List users the authenticated user follows

      ## Example

          client.followers

      More info at: http://developer.github.com/v3/users/followers/#list-followers-of-a-user
      """
      @spec followers(Client.t) :: :jsx.json_term
      def followers(self) do
        get "user/followers", self.auth
      end
    end
  end
end
