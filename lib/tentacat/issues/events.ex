defmodule Tentacat.Issues.Events do
  import Tentacat
  alias Tentacat.Client

  @doc """
  """
  @spec list(binary, binary, binary | integer, Client.t) :: Tentacat.response
  def list(owner, repo, issue_id, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/issues/#{issue_id}/events", client
  end

end
