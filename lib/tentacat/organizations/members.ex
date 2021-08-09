defmodule Tentacat.Organizations.Members do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List members of a `organization`.

  The response will differ if the authenticated user is also owner of the
  organization.

  ## Example

      Tentacat.Organizations.Members.list "github"
      Tentacat.Organizations.Members.list client, "github"

  More info at: http://developer.github.com/v3/orgs/members/#members-list
  """
  @spec list(Client.t(), binary) :: Tentacat.response()
  def list(client \\ %Client{}, organization) do
    get("orgs/#{organization}/members", client)
  end

  @doc """
  Check if a `user` is, publicly or privately, a member of the `organization`.

  Possible responses: 204, 404 or 302.

  ## Example

      Tentacat.Organizations.Members.member? "github", "mojombo"
      Tentacat.Organizations.Members.member? client, "github", "mojombo"

  More info at: http://developer.github.com/v3/orgs/members/#check-membership
  """
  @spec member?(Client.t(), binary, binary) :: Tentacat.response()
  def member?(client \\ %Client{}, organization, user) do
    get("orgs/#{organization}/members/#{user}", client)
  end

  @doc """
  Remove a member `user` from an `organization`.

  ## Example

      Tentacat.Organizations.Members.remove client, "github", "mojombo"

  More info at: http://developer.github.com/v3/orgs/members/#remove-organization-membership
  """
  @spec remove(Client.t(), binary, binary) :: Tentacat.response()
  def remove(client, organization, user) do
    delete("orgs/#{organization}/memberships/#{user}", client)
  end

  @doc """
  List of publicized members of an `organization`.

  ## Example

      Tentacat.Organizations.Members.public_list "github"
      Tentacat.Organizations.Members.public_list client, "github"

  More info at: http://developer.github.com/v3/orgs/members/#public-members-list
  """
  @spec public_list(Client.t(), binary) :: Tentacat.response()
  def public_list(client \\ %Client{}, organization) do
    get("orgs/#{organization}/public_members", client)
  end

  @doc """
  Check if a `user` is a public member of the `organization`.

  Possible responses: 204 or 404.

  ## Example

      Tentacat.Organizations.Members.public_member? "github", "mojombo"
      Tentacat.Organizations.Members.public_member? client, "github", "mojombo"

  More info at: http://developer.github.com/v3/orgs/members/#public-members-list
  """
  @spec public_member?(Client.t(), binary, binary) :: Tentacat.response()
  def public_member?(client \\ %Client{}, organization, user) do
    get("orgs/#{organization}/public_members/#{user}", client)
  end

  @doc """
  Publicize a `user`'s membership on an `organization`.

  ## Example

      Tentacat.Organizations.Members.publicize "github", "mojombo"

  More info at: http://developer.github.com/v3/orgs/members/#publicize-a-users-membership
  """
  @spec publicize(Client.t(), binary, binary) :: Tentacat.response()
  def publicize(client, organization, user) do
    put("orgs/#{organization}/public_members/#{user}", client)
  end

  @doc """
  Conceal a `user`'s membership on an `organization`.

  ## Example

      Tentacat.Organizations.Members.conceal "github", "mojombo"

  More info at: http://developer.github.com/v3/orgs/members/#conceal-a-users-membership
  """
  @spec conceal(Client.t(), binary, binary) :: Tentacat.response()
  def conceal(client, organization, user) do
    delete("orgs/#{organization}/public_members/#{user}", client)
  end
end
