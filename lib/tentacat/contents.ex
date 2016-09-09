defmodule Tentacat.Contents do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Get the contents of a file or directory in a repository.

  ## Example

  Tentacat.Contents.readme "elixir-lang", "elixir", "ref-name"
  Tentacat.Contents.readme "elixir-lang", "elixir", "ref-name", client

  More info at: https://developer.github.com/v3/repos/contents/#get-the-readme
  """
  @spec find(binary, binary, binary, Client.t) :: Tentacat.response
  def readme(owner, repo, ref, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/readme", client, [{:ref, ref}]
  end

  @doc """
  Get the contents of a file or directory in a repository.

  ## Example

      Tentacat.Contents.find "elixir-lang", "elixir", "lib"
      Tentacat.Contents.find "elixir-lang", "elixir", "lib", client

  More info at: https://developer.github.com/v3/repos/contents/#get-contents
  """
  @spec find(binary, binary, binary, Client.t) :: Tentacat.response
  def find(owner, repo, path, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/contents/#{path}", client
  end

  @doc """
  Get the contents of a file or directory in a repository for a provided reference

  ## Example

      Tentacat.Contents.find_in "elixir-lang", "elixir", "lib", "ref-name"
      Tentacat.Contents.find_in "elixir-lang", "elixir", "lib", "ref-name", client

  More info at: https://developer.github.com/v3/repos/contents/#get-contents
  """
  @spec find_in(binary, binary, binary, binary, Client.t) :: Tentacat.response
  def find_in(owner, repo, path, ref, client \\ %Client{}) do
    get "repos/#{owner}/#{repo}/contents/#{path}", client, [{:ref, ref}]
  end

  @doc """
  Create a file

  Create body example:

      %{
        "message" => "my commit message",
        "committer" => %{
          "name"  =>  "Grigory Starinkin",
          "email" =>  "starinkin@gmail.com"
        },
        "content" => "bXkgbmV3IGZpbGUgY29udGVudHM=",
        "branch"  => "cool-feature"
      }

  ## Example

      Tentacat.Contents.create "elixir-lang", "elixir", "lib/elixir.ex", body, client

  More info at: https://developer.github.com/v3/repos/contents/#create-a-file
  """
  @spec create(binary, binary, binary, list | map, Client.t) :: Tentacat.response
  def create(owner, repo, path, body, client) do
    put "repos/#{owner}/#{repo}/contents/#{path}", client, body
  end

  @doc """
  Update a file

  Update body example:

      %{
        "message" => "my commit message",
        "committer" => %{
          "name"  => "Grigory Starinkin",
          "email" => "starinkin@gmail.com"
        },
        "content" => "bXkgdXBkYXRlZCBmaWxlIGNvbnRlbnRz",
        "sha"     => "329688480d39049927147c162b9d2deaf885005f",
        "branch"  => "cool-feature"
      }

  ## Example

      Tentacat.Contents.update "elixir-lang", "elixir", "lib/elixir.ex", body, client

  More info at: https://developer.github.com/v3/repos/contents/#update-a-file
  """
  @spec update(binary, binary, binary, list | map, Client.t) :: Tentacat.response
  def update(owner, repo, path, body, client) do
    put "repos/#{owner}/#{repo}/contents/#{path}", client, body
  end

  @doc """
  Deletes a file in a repository

  Delete body example:

      %{
        "message" => "my commit message",
        "committer" => %{
          "name"  => "Grigory Starinkin",
          "email" => "starinkin@gmail.com"
        },
        "sha"    => "329688480d39049927147c162b9d2deaf885005f",
        "branch" => "cool-feature"
      }

  ## Example

      Tentacat.Contents.remove "elixir-lang", "elixir", "lib/elixir.ex", body, client

  More info at: https://developer.github.com/v3/repos/contents/#delete-a-file
  """
  @spec remove(binary, binary, binary, list | map, Client.t) :: Tentacat.response
  def remove(owner, repo, path, body, client) do
    delete "repos/#{owner}/#{repo}/contents/#{path}", client, body
  end
end
