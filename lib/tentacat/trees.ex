defmodule Tentacat.Trees do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Get a Tree.

  ## Example

      Tentacat.Trees.find "elixir-lang", "elixir", "eac64175b71fc598fa0b6e611dea6a58973170e9"
      Tentacat.Trees.find "elixir-lang", "elixir", "eac64175b71fc598fa0b6e611dea6a58973170e9", client

  More info at: https://developer.github.com/v3/git/trees/#get-a-tree
  """
  @spec find(binary, binary, binary, Client.t()) :: Tentacat.response()
  def find(owner, repo, sha, client \\ %Client{}) do
    get("repos/#{owner}/#{repo}/git/trees/#{sha}", client)
  end

  @doc """
  Get a Tree Recursively.

  ## Example

      Tentacat.Trees.find_recursive "elixir-lang", "elixir", "eac64175b71fc598fa0b6e611dea6a58973170e9"
      Tentacat.Trees.find_recursive "elixir-lang", "elixir", "eac64175b71fc598fa0b6e611dea6a58973170e9", client

  More info at: https://developer.github.com/v3/git/trees/#get-a-tree-recursively
  """
  @spec find_recursive(binary, binary, binary, Client.t()) :: Tentacat.response()
  def find_recursive(owner, repo, sha, client \\ %Client{}) do
    get("repos/#{owner}/#{repo}/git/trees/#{sha}", client, [{:recursive, 1}])
  end

  @doc """
  Create a Tree.

  Tree body example:

  ```elixir
  %{
    "base_tree" => "9fb037999f264ba9a7fc6274d15fa3ae2ab98312",
    "tree" => [
      %{
        "path" => "elixir.ex",
        "mode" => "100644",
        "type" => "blob",
        "sha"  => "44b4fc6d56897b048c772eb4087f854f46256132"
      }
    ]
  }
  ```

  ## Example

      Tentacat.Trees.create "elixir-lang", "elixir", body, client

  More info at: https://developer.github.com/v3/git/trees/#create-a-tree
  """
  @spec create(binary, binary, map, Client.t()) :: Tentacat.response()
  def create(owner, repo, body, client) when is_map(body) do
    post("repos/#{owner}/#{repo}/git/trees", client, body)
  end
end
