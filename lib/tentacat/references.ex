defmodule Tentacat.References do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Get all References

  ## Example

      Tentacat.References.list "elixir-lang", "elixir"
      Tentacat.References.list "elixir-lang", "elixir", client

  More info at: https://developer.github.com/v3/git/refs/#get-all-references
  """
  @spec list(binary, binary, Client.t) :: Tentacat.response
  def list(owner, repo, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/git/refs", client.auth
  end

  @doc """
  Get a Reference

  ## Example

      Tentacat.References.find "elixir-lang", "elixir", "heads/emj-otp-18"
      Tentacat.References.find "elixir-lang", "elixir", "heads/emj-otp-18", client

  More info at: https://developer.github.com/v3/git/refs/#get-a-reference
  """
  @spec find(binary, binary, binary, Client.t) :: Tentacat.response
  def find(owner, repo, ref, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/git/refs/#{ref}", client.auth
  end

  @doc """
  Create a Reference

  Reference body example:

      %{
        "ref" => "refs/heads/emj-otp-18",
        "sha" => "aa218f56b14c9653891f9e74264a383fa43fefbd"
      }

  ## Example

      Tentacat.References.create "elixir-lang", "elixir", ref_body, client

  More info at: https://developer.github.com/v3/git/refs/#create-a-reference
  """
  @spec create(binary, binary, list | map, Client.t) :: Tentacat.response
  def create(owner, repo, body, client) do
    post "repos/#{owner}/#{repo}/git/refs", client.auth, body
  end

  @doc """
  Update a Reference

  Reference body example:

      %{
        "sha"   => "aa218f56b14c9653891f9e74264a383fa43fefbd",
        "force" => true
      }

  ## Example

      Tentacat.References.update "elixir-lang", "elixir", "heads/emj-otp-18", body, client

  More info at: https://developer.github.com/v3/git/refs/#update-a-reference
  """
  @spec update(binary, binary, binary, list | map, Client.t) :: Tentacat.response
  def update(owner, repo, ref, body, client) do
    patch "repos/#{owner}/#{repo}/git/refs/#{ref}", client.auth, body
  end

  @doc """
  Delete a Reference

  ## Example

      Tentacat.References.remove "elixir-lang", "elixir", "heads/emj-otp-18", client
      Tentacat.References.remove "elixir-lang", "elixir", "tags/v1.0.2", client

  More info at: https://developer.github.com/v3/git/refs/#delete-a-reference
  """
  @spec remove(binary, binary, binary, Client.t) :: Tentacat.response
  def remove(owner, repo, ref, client) do
    delete "repos/#{owner}/#{repo}/git/refs/#{ref}", client.auth
  end
end
