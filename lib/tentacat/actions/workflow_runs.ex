defmodule Tentacat.Actions.WorkflowRuns do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List the workflow runs for a repository

  ## Example

  Tentacat.Actions.WorkflowRuns.list(client, "some-user", "some-repo")

  More info at https://developer.github.com/v3/actions/workflow-runs/#list-repository-workflow-runs
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/actions/runs", client)
  end
end
