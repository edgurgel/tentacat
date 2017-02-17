defmodule Tentacat.Notifications.Thread do
  import Tentacat
  alias Tentacat.Client

  @doc """
  View a single thread.

  ## Example

      Tentacat.Notifications.Thread.list(6736758, client)

  More info at: https://developer.github.com/v3/activity/notifications/#view-a-single-thread
  """
  def list(id, client) do
    get "notifications/threads/#{id}", client
  end

  @doc """
  Mark a thread as read.

  ## Example

      Tentacat.Notifications.Thread.remove(6736758, client)

  More info at: https://developer.github.com/v3/activity/notifications/#mark-a-thread-as-read
  """
  def remove(id, client) do
    patch "notifications/threads/#{id}", client
  end

  @doc """
  Checks if user is subscibed to thread.

  ## Example

      Tentacat.Notifications.Thread.subscription(6736758, client)

  More info at: https://developer.github.com/v3/activity/notifications/#get-a-thread-subscription
  """
  def subscription(id, client) do
    get "notifications/threads/#{id}/subscription", client
  end

  @doc """
  Allow user to subscibe/unsubscribe to thread.

  ## Example
      params = %{
        # Determines if notifications should be received from this thread.
        "subscribed" => true,

        # Determines if all notifications should be blocked from this thread.
        "igored" => true,

      }
      Tentacat.Notifications.Thread.subscribe(6736758, client, params)

  More info at: https://developer.github.com/v3/activity/notifications/#set-a-thread-subscription
  """
  def subscribe(id, client, params \\ %{}) do
    put "notifications/threads/#{id}/subscription", client, params
  end

  @doc """
  Allow to delete thread subscription
  More info at: https://developer.github.com/v3/activity/notifications/#delete-a-thread-subscription
  """
  def delete(id, client) do
    Tentacat.delete "notifications/threads/#{id}/subscription", client
  end

end
