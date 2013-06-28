defmodule Tentacat.Users.Emails do
  import Tentacat.Client.Base
  alias Tentacat.Client

  @doc """
  List email addresses for the authenticated user

  ## Example

      Tentacat.Users.Emails.list client

  More info at: http://developer.github.com/v3/users/emails/#list-email-addresses-for-a-user
  """
  @spec list(Client.t) :: :jsx.json_term
  def list(client) do
    get "user/emails", client.auth
  end

  @doc """
  Add email address(es)

  ## Example

      Tentacat.Users.Emails.create ["ed@gurgel.me"], client

  More info at: http://developer.github.com/v3/users/emails/#add-email-addresses
  """
  @spec create([binary], Client.t) :: :jsx.json_term
  def create(emails, client) do
    post "user/emails", client.auth, emails
  end

  @doc """
  Delete email address(es)

  ## Example

      Tentacat.Users.Emails.remove ["ed@gurgel.me"], client

  More info at: http://developer.github.com/v3/users/emails/#delete-email-addresses
  """
  @spec remove([binary], Client.t) :: :jsx.json_term
  def remove(emails, client) do
    delete "user/emails", client.auth, emails
  end
end
