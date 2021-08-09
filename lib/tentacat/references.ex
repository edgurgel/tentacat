defmodule Tentacat.References do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Get all References.

  ## Example

      Tentacat.References.list "elixir-lang", "elixir"
      Tentacat.References.list client, "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/git/refs/#get-all-references
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/git/refs", client)
  end

  @doc """
  Get a Reference.

  ## Example

      Tentacat.References.find "elixir-lang", "elixir", "heads/emj-otp-18"
      Tentacat.References.find client, "elixir-lang", "elixir", "heads/emj-otp-18"

  More info at: https://developer.github.com/v3/git/refs/#get-a-reference
  """
  @spec find(Client.t(), binary, binary, binary) :: Tentacat.response()
  def find(client \\ %Client{}, owner, repo, ref) do
    get("repos/#{owner}/#{repo}/git/refs/#{ref}", client)
  end

  @doc """
  Create a Reference.

  Reference body example:

  ```elixir
  %{
    "ref" => "refs/heads/emj-otp-18",
    "sha" => "aa218f56b14c9653891f9e74264a383fa43fefbd"
  }
  ```

  ## Example

      Tentacat.References.create client, "elixir-lang", "elixir", ref_body

  More info at: https://developer.github.com/v3/git/refs/#create-a-reference
  """
  @spec create(Client.t(), binary, binary, map) :: Tentacat.response()
  def create(client, owner, repo, body) when is_map(body) do
    post("repos/#{owner}/#{repo}/git/refs", client, body)
  end

  @doc """
  Update a Reference.

  Reference body example:

  ```elixir
  %{
    "sha"   => "aa218f56b14c9653891f9e74264a383fa43fefbd",
    "force" => true
  }
  ```

  ## Example

      Tentacat.References.update client, "elixir-lang", "elixir", "heads/emj-otp-18", body

  More info at: https://developer.github.com/v3/git/refs/#update-a-reference
  """
  @spec update(Client.t(), binary, binary, binary, map) :: Tentacat.response()
  def update(client, owner, repo, ref, body) when is_map(body) do
    patch("repos/#{owner}/#{repo}/git/refs/#{ref}", client, body)
  end

  @doc """
  Delete a Reference.

  ## Example

      Tentacat.References.remove client, "elixir-lang", "elixir", "heads/emj-otp-18"
      Tentacat.References.remove client, "elixir-lang", "elixir", "tags/v1.0.2"

  More info at: https://developer.github.com/v3/git/refs/#delete-a-reference
  """
  @spec remove(Client.t(), binary, binary, binary) :: Tentacat.response()
  def remove(client, owner, repo, ref) do
    delete("repos/#{owner}/#{repo}/git/refs/#{ref}", client)
  end
end
