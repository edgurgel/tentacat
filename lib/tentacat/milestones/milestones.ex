defmodule Tentacat.Milestones do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List milestones.

  ## Example

      Tentacat.Milestones.list "elixir-lang", "elixir"
      Tentacat.Milestones.list "elixir-lang", "elixir", client

  More info at: https://developer.github.com/v3/issues/milestones/#list-milestones-for-a-repository
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/milestones", client)
  end

  @doc """
  Get a single milestone.

  ## Example

      Tentacat.Milestones.find "elixir-lang", "elixir", "2974"
      Tentacat.Milestones.find "elixir-lang", "elixir", "2974", client

  More info at: https://developer.github.com/v3/issues/milestones/#get-a-single-milestone
  """
  @spec find(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def find(client \\ %Client{}, owner, repo, number) do
    get("repos/#{owner}/#{repo}/milestones/#{number}", client)
  end

  @doc """
  Create a milestone.

  Possible values for `body`:

    * %{"title": "v1.0"}
    * %{"state": "open"}
    * %{"description": "Tracking milestone for version 1.0"}
    * %{"due_on": "2012-10-09T23:39:01Z"}

  ## Example

      Tentacat.Milestones.create "elixir-lang", "elixir", %{"title" => "Issue", "state" => "open"}
      Tentacat.Milestones.create "elixir-lang", "elixir", %{"title" => "Issue", "state" => "closed"}, client

  More info at: https://developer.github.com/v3/issues/milestones/#create-a-milestone
  """
  @spec create(Client.t(), binary, binary, map) :: Tentacat.response()
  def create(client \\ %Client{}, owner, repo, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/milestones", client, body)
  end

  @doc """
  Update a milestone.

  Possible values for `body`:

    * %{"title": "v1.0"}
    * %{"state": "open"}
    * %{"description": "Tracking milestone for version 1.0"}
    * %{"due_on": "2012-10-09T23:39:01Z"}

  ## Example

      Tentacat.Milestones.update "elixir-lang", "elixir", "2974", %{"title" => "edgurgel"}
      Tentacat.Milestones.update "elixir-lang", "elixir", "2974", %{"state" => "closed"}, client

  More info at: https://developer.github.com/v3/issues/milestones/#update-a-milestone
  """
  @spec update(Client.t(), binary, binary, binary | integer, map) :: Tentacat.response()
  def update(client \\ %Client{}, owner, repo, number, body) when is_map(body) do
    patch("repos/#{owner}/#{repo}/milestones/#{number}", client, body)
  end

  @doc """
  Delete a milestone.

  ## Example

      Tentacat.Milestones.delete "elixir-lang", "elixir", "2974"
      Tentacat.Milestones.delete "elixir-lang", "elixir", "2974", client

  More info at: https://developer.github.com/v3/issues/milestones/#delete-a-milestone
  """
  @spec delete(Client.t(), binary, binary, binary | integer) :: Tentacat.response()
  def delete(client \\ %Client{}, owner, repo, number) do
    delete("repos/#{owner}/#{repo}/milestones/#{number}", client)
  end
end
