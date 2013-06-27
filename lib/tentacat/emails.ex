defmodule Tentacat.Users.Emails do
  defmacro __using__(_) do
    import Tentacat.Client.Base
    quote do
      @doc """
      List email addresses for the authenticated user

      ## Example

          client.emails

      More info at: http://developer.github.com/v3/users/emails/#list-email-addresses-for-a-user
      """
      @spec emails(Client) :: :jsx.json_term
      def emails(self) do
        get "user/emails", self.auth
      end

      @doc """
      Add email address(es)

      ## Example

          client.create_emails ["ed@gurgel.me"]

      More info at: http://developer.github.com/v3/users/emails/#add-email-addresses
      """
      @spec create_emails([binary], Client) :: :jsx.json_term
      def create_emails(emails, self) do
        post "user/emails", self.auth, emails
      end

      @doc """
      Delete email address(es)

      ## Example

          client.remove_email ["ed@gurgel.me"]

      More info at: http://developer.github.com/v3/users/emails/#delete-email-addresses
      """
      @spec remove_email([binary], Client) :: :jsx.json_term
      def remove_email(emails, self) do
        delete "user/emails", self.auth, emails
      end
    end
  end
end
