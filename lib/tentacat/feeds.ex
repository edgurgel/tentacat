defmodule Tentacat.Feeds do
  import Tentacat

  @doc """
  GitHub provides several timeline resources in Atom format.

  The Feeds API lists all the feeds available to the authenticating user:

    * Timeline: The GitHub global public timeline
    * User: The public timeline for any user, using URI template
    * Current user public: The public timeline for the authenticated user
    * Current user: The private timeline for the authenticated user
    * Current user actor: The private timeline for activity created by the authenticated user
    * Current user organizations: The private timeline for the organizations
    the authenticated user is a member of.

  Note: Private feeds are only returned when authenticating via Basic Auth
  since current feed URIs use the older, non revokable auth tokens.

  ## Example

      Tentacat.Users.Feeds

  More info at: https://developer.github.com/v3/activity/feeds/
  """
  def feeds(client) do
    get("feeds", client)
  end
end
