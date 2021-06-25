defmodule Tentacat.Organizations do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List all public organizations for a user.

  ## Example

      Tentacat.Organizations.list "edgurgel"
      Tentacat.Organizations.list client, "edgurgel"

  More info at: http://developer.github.com/v3/orgs/#list-user-organizations
  """
  @spec list(Client.t(), binary) :: Tentacat.response()
  def list(client \\ %Client{}, user) do
    get("users/#{user}/orgs", client)
  end

  @doc """
  List public and private organizations for the authenticated user.

  ## Example

      Tentacat.Organizations.list_mine client

  More info at: http://developer.github.com/v3/orgs/#list-user-organizations
  """
  @spec list_mine(Client.t()) :: Tentacat.response()
  def list_mine(client) do
    get("user/orgs", client)
  end

  @doc """
  Get an organization.

  ## Example

      Tentacat.Orgnizations.find "Codeminer42"
      Tentacat.Orgnizations.find client, "Codeminer42"

  More info at: http://developer.github.com/v3/orgs/#get-an-organization
  """
  @spec find(Client.t(), binary) :: Tentacat.response()
  def find(client \\ %Client{}, org) do
    get("orgs/#{org}", client)
  end

  @doc """
  Update an organization.

  Possible values for `options`:

    * [billing_email: "billing email"]
    * [company: "Company42"]
    * [email: "public email"]
    * [location: "Brazil"]
    * [name: "company42"]

  ## Example

      Tentacat.Organizations.update(client, "codeminer42", [email: "public@codeminer42.com", location: "São Paulo"])

  More info at: http://developer.github.com/v3/orgs/#edit-an-organization
  """
  @spec update(Client.t(), binary, list) :: Tentacat.response()
  def update(client, org, options) do
    patch("orgs/#{org}", client, options)
  end
end
