defmodule Tentacat.Actions.Artifacts do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List the artifacts for a repository

  ## Example

  Tentacat.Actions.Artifacts.list "elixir-lang" , "elixir"

  More info at https://developer.github.com/v3/actions/artifacts/#list-artifacts-for-a-repository
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/actions/artifacts", client)
  end

  @doc """
  List artifacts for a specific workflow run

  ### Example

  Tentacat.Actions.Artifacts.list "elixir-lang", "elixir", "345434"
  More info at: https://developer.github.com/v3/actions/artifacts/#list-workflow-run-artifacts
  """
  @spec list_for_run(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def list_for_run(client \\ %Client{}, owner, repo, run_id) do
    get("repos/#{owner}/#{repo}/actions/runs/#{run_id}/artifacts", client)
  end
end
