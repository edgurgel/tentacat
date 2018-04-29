defmodule Tentacat.Issues.Events do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List events on an issue.

  ## Example

      Tentacat.Issues.Events.list "elixir-lang", "elixir", 3970

  More info at: https://developer.github.com/v3/issues/events/#list-events-for-an-issue
  """
  @spec list(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo, issue_id) do
    get("repos/#{owner}/#{repo}/issues/#{issue_id}/events", client)
  end

  @doc """
  List all events on issues for a repository.

  ## Example

      Tentacat.Issues.Events.list_all "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/issues/events/#list-events-for-a-repository
  """
  @spec list_all(Client.t(), binary, binary) :: Tentacat.response()
  def list_all(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/issues/events", client)
  end

  @doc """
  Get a single event on an issue by its id.

  ## Example

      Tentacat.Issues.Events.find "elixir-lang", "elixir", 882148

  More info at: https://developer.github.com/v3/issues/events/#get-a-single-event
  """
  @spec find(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def find(client \\ %Client{}, owner, repo, event_id) do
    get("repos/#{owner}/#{repo}/issues/events/#{event_id}", client)
  end
end
