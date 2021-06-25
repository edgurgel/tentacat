defmodule Tentacat.Issues.Labels do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List labels on an issue.

  ## Example

      Tentacat.Issues.Labels.list "elixir-lang", "elixir", 3970

  More info at: https://developer.github.com/v3/issues/labels/#list-labels-on-an-issue
  """
  @spec list(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo, issue_id) do
    get("repos/#{owner}/#{repo}/issues/#{issue_id}/labels", client)
  end

  @doc """
  Add labels to an issue.

  ## Example

      Tentacat.Issues.Labels.list "elixir-lang", "elixir", 3970

  More info at: https://developer.github.com/v3/issues/labels/#add-labels-to-an-issue
  """
  @spec add(Client.t(), binary, binary, binary | integer, [binary]) :: Tentacat.response()
  def add(client \\ %Client{}, owner, repo, issue_id, labels) do
    post("repos/#{owner}/#{repo}/issues/#{issue_id}/labels", client, labels)
  end

  @doc """
  Remove a label from an issue.

  ## Example

      Tentacat.Issues.Labels.remove "elixir-lang", "elixir", 3970, "Important"

  More info at: https://developer.github.com/v3/issues/labels/#remove-a-label-from-an-issue
  """
  @spec remove(Client.t(), binary, binary, binary | integer, binary) :: Tentacat.response()
  def remove(client \\ %Client{}, owner, repo, issue_id, label) do
    delete("repos/#{owner}/#{repo}/issues/#{issue_id}/labels/#{label}", client)
  end
end
