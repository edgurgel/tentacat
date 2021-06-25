defmodule Tentacat.Users.Emails do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List email addresses for the authenticated user.

  ## Example

      Tentacat.Users.Emails.list client

  More info at: http://developer.github.com/v3/users/emails/#list-email-addresses-for-a-user
  """
  @spec list(Client.t()) :: Tentacat.response()
  def list(client) do
    get("user/emails", client)
  end

  @doc """
  Add email address(es).

  ## Example

      Tentacat.Users.Emails.create client, ["ed@gurgel.me"]

  More info at: http://developer.github.com/v3/users/emails/#add-email-addresses
  """
  @spec create(Client.t(), [binary]) :: Tentacat.response()
  def create(client, emails) do
    post("user/emails", client, %{emails: emails})
  end

  @doc """
  Delete email address(es).

  ## Example

      Tentacat.Users.Emails.remove client, ["ed@gurgel.me"]

  More info at: http://developer.github.com/v3/users/emails/#delete-email-addresses
  """
  @spec remove(Client.t(), [binary]) :: Tentacat.response()
  def remove(client, emails) do
    delete("user/emails", client, emails)
  end
end
