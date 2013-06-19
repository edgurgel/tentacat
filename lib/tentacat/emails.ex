defmodule Tentacat.Users.Emails do
  import Tentacat.Client

  @doc """
  List email addresses for the authenticated user

  More info at: http://developer.github.com/v3/users/emails/#list-email-addresses-for-a-user
  """
  @spec emails(Client.auth) :: :jsx.json_term
  def emails(auth) do
    get "user/emails", auth
  end

  @doc """
  Add email address(es)

  More info at: http://developer.github.com/v3/users/emails/#add-email-addresses
  """
  @spec create([binary], Client.auth) :: :jsx.json_term
  def create(emails, auth) do
    post "user/emails", auth, emails
  end

  @doc """
  Delete email address(es)

  More info at: http://developer.github.com/v3/users/emails/#delete-email-addresses
  """
  @spec destroy([binary], Client.auth) :: :jsx.json_term
  def destroy(emails, auth) do
    delete "user/emails", auth, emails
  end
end
