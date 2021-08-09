defmodule Tentacat.Repositories.Labels do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List labels on a repository.

  ## Example

      Tentacat.Repositories.Labels.list "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/issues/labels/#list-all-labels-for-this-repository
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/labels", client)
  end

  @doc """
  Find a label on a repository.

  ## Example

      Tentacat.Repositories.Labels.find "elixir-lang", "elixir", "WIP"

  More info at: https://developer.github.com/v3/issues/labels/#get-a-single-label
  """
  @spec find(Client.t(), binary, binary, binary) :: Tentacat.response()
  def find(client \\ %Client{}, owner, repo, name) do
    get("repos/#{owner}/#{repo}/labels/#{name}", client)
  end

  @doc """
  Creates a new label on a repository.

  Possible values for `body`:

    * %{name: "name of label"} (required)
    * %{color: "color of label"} (required)

  ## Example

      Tentacat.Repositories.Labels.create "elixir-lang", "elixir", %{name: "Important", color: "f29513"}

  More info at: https://developer.github.com/v3/issues/labels/#create-a-label
  """
  @spec create(Client.t(), binary, binary, map) :: Tentacat.response()
  def create(client \\ %Client{}, owner, repo, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/labels", client, body)
  end

  @doc """
  Update a label on a repository.

  Possible values for `body`:

    * %{name: "name of label"} (required)
    * %{color: "color of label"} (required)

  ## Example

      Tentacat.Repositories.Labels.update "elixir-lang", "elixir", "Important", %{color: "000000"}

  More info at: https://developer.github.com/v3/issues/labels/#update-a-label
  """
  @spec update(Client.t(), binary, binary, binary, map) :: Tentacat.response()
  def update(client \\ %Client{}, owner, repo, name, body) when is_map(body) do
    patch("repos/#{owner}/#{repo}/labels/#{name}", client, body)
  end

  @doc """
  Delete a label on a repository.

  ## Example

      Tentacat.Repositories.Labels.delete "elixir-lang", "elixir", "Important"

  More info at: https://developer.github.com/v3/issues/labels/#delete-a-label
  """
  @spec delete(Client.t(), binary, binary, binary) :: Tentacat.response()
  def delete(client \\ %Client{}, owner, repo, name) do
    delete("repos/#{owner}/#{repo}/labels/#{name}", client)
  end
end
