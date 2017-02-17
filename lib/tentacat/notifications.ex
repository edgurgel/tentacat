defmodule Tentacat.Notifications do
  import Tentacat
  alias Tentacat.Client

  @moduledoc """
  Notifications API allows to view/subscibe notifications, marking them as read and view/subscibe to threads.
  """

  @doc """
  Get list of all notifications for the current user. Grouped by repository.

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
      Tentacat.Notifications.list(client, params)

  More info at: https://developer.github.com/v3/activity/notifications/#list-your-notifications
  """
  def list(client, params \\ %{}) do
    get "notifications", client, params
  end

  @doc """
  Mark notifications as read. If will remove them from default view on GitHub.

  ## Example

      params = %{
        # Describes the last point that notifications were checked
        "last_read_at" => DateTime.utc_now() |> DateTime.to_iso8601()
      }
      Tentacat.Notifications.remove(client, params)

  More info at: https://developer.github.com/v3/activity/notifications/#mark-as-read
  """
  def remove(client, params \\ %{}) do
    put "notifications", client, params
  end

end
