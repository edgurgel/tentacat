defmodule Tentacat.Issues.Labels do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List labels on an issue

  ## Example

      Tentacat.Issues.Labels.list "elixir-lang", "elixir", 3970

  More info at: https://developer.github.com/v3/issues/labels/#list-labels-on-an-issue
  """
  @spec list(binary, binary, binary | integer, Client.t) :: Tentacat.response
  def list(owner, repo, issue_id, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/issues/#{issue_id}/labels", client
  end

  @doc """
  Add labels to an issue

  ## Example

      Tentacat.Issues.Labels.list "elixir-lang", "elixir", 3970

  More info at: https://developer.github.com/v3/issues/labels/#add-labels-to-an-issue
  """
  @spec add(binary, binary, binary | integer, [binary], Client.t) :: Tentacat.response
  def add(owner, repo, issue_id, labels, client \\ %Client{}) do
    post "repos/#{owner}/#{repo}/issues/#{issue_id}/labels", client, labels
  end

  @doc """
  Remove a label from an issue

  ## Example

      Tentacat.Issues.Labels.remove "elixir-lang", "elixir", 3970, "Important"

  More info at: https://developer.github.com/v3/issues/labels/#remove-a-label-from-an-issue
  """
  @spec remove(binary, binary, binary | integer, binary, Client.t) :: Tentacat.response
  def remove(owner, repo, issue_id, label, client \\ %Client{}) do
    delete "repos/#{owner}/#{repo}/issues/#{issue_id}/labels/#{label}", client
  end
end