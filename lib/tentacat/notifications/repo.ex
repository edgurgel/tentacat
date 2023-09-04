defmodule Tentacat.Notifications.Repo do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Get list of all notifications in repository for the current user.

  ## Example

      params = %{
        # Show notifications marked as read. Default: false
        "all" => true,

        # Only show notifications in which the user is participating or directly mentioned. Default: false
        "participating" => true,

        # Only show notifications updated after given time. Default: Time.now
        "since" => DateTime.utc_now() |> DateTime.to_iso8601(),

        # Only show notifications updated before given time.
        "before" => DateTime.utc_now() |> DateTime.to_iso8601()
      }
      Tentacat.Notifications.Repo.list("elixir-lang", "elixir", client, params)

  More info at: https://developer.github.com/v3/activity/notifications/#list-your-notifications-in-a-repository
  """
  def list(owner, repo, client, params \\ %{}) do
    get "repos/#{owner}/#{repo}/notifications", client, params
  end

  @doc """
  Mark notifications in repository as read. If will remove them from default view on GitHub.

  ## Example

      params = %{
        # Describes the last point that notifications were checked
        "last_read_at" => DateTime.utc_now() |> DateTime.to_iso8601()
      }
      Tentacat.Notifications.Repo.remove("elixir-lang", "elixir", client, params)

  More info at: https://developer.github.com/v3/activity/notifications/#mark-notifications-as-read-in-a-repository
  """
  def remove(owner, repo, client, params \\ %{}) do
    put "repos/#{owner}/#{repo}/notifications", client, params
  end

end
