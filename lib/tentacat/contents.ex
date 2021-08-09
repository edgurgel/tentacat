defmodule Tentacat.Contents do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Get the contents of README.md.

  ## Example

      Tentacat.Contents.readme "elixir-lang", "elixir"
      Tentacat.Contents.readme client, "elixir-lang", "elixir"

  More info at: https://developer.github.com/v3/repos/contents/#get-the-readme
  """
  @spec readme(Client.t(), binary, binary) :: Tentacat.response()
  def readme(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/readme", client)
  end

  @doc """
  Get the contents of a file or directory in a repository.

  ## Example

      Tentacat.Contents.find "elixir-lang", "elixir", "lib"
      Tentacat.Contents.find client, "elixir-lang", "elixir", "lib"

  More info at: https://developer.github.com/v3/repos/contents/#get-contents
  """
  @spec find(Client.t(), binary, binary, binary) :: Tentacat.response()
  def find(client \\ %Client{}, owner, repo, path) do
    get("repos/#{owner}/#{repo}/contents/#{path}", client)
  end

  @doc """
  Get the contents of a file or directory in a repository for a provided reference.

  ## Example

      Tentacat.Contents.find_in "elixir-lang", "elixir", "lib", "ref-name"
      Tentacat.Contents.find_in client, "elixir-lang", "elixir", "lib", "ref-name"

  More info at: https://developer.github.com/v3/repos/contents/#get-contents
  """
  @spec find_in(Client.t(), binary, binary, binary, binary) :: Tentacat.response()
  def find_in(client \\ %Client{}, owner, repo, path, ref) do
    get("repos/#{owner}/#{repo}/contents/#{path}", client, [{:ref, ref}])
  end

  @doc """
  Create a file.

  Create body example:

  ```elixir
  %{
    "message" => "my commit message",
    "committer" => %{
      "name"  =>  "Grigory Starinkin",
      "email" =>  "starinkin@gmail.com"
    },
    "content" => "bXkgbmV3IGZpbGUgY29udGVudHM=",
    "branch"  => "cool-feature"
  }
  ```

  ## Example

      Tentacat.Contents.create client, "elixir-lang", "elixir", "lib/elixir.ex", body

  More info at: https://developer.github.com/v3/repos/contents/#create-a-file
  """
  @spec create(Client.t(), binary, binary, binary, map) :: Tentacat.response()
  def create(client, owner, repo, path, body) when is_map(body) do
    put("repos/#{owner}/#{repo}/contents/#{path}", client, body)
  end

  @doc """
  Update a file.

  Update body example:

  ```elixir
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
  ```

  ## Example

      Tentacat.Contents.update client, "elixir-lang", "elixir", "lib/elixir.ex", body

  More info at: https://developer.github.com/v3/repos/contents/#update-a-file
  """
  @spec update(Client.t(), binary, binary, binary, map) :: Tentacat.response()
  def update(client, owner, repo, path, body) when is_map(body) do
    put("repos/#{owner}/#{repo}/contents/#{path}", client, body)
  end

  @doc """
  Deletes a file in a repository.

  Delete body example:

  ```elixir
  %{
    "message" => "my commit message",
    "committer" => %{
      "name"  => "Grigory Starinkin",
      "email" => "starinkin@gmail.com"
    },
    "sha"    => "329688480d39049927147c162b9d2deaf885005f",
    "branch" => "cool-feature"
  }
  ```

  ## Example

      Tentacat.Contents.remove client, "elixir-lang", "elixir", "lib/elixir.ex", body

  More info at: https://developer.github.com/v3/repos/contents/#delete-a-file
  """
  @spec remove(Client.t(), binary, binary, binary, map) :: Tentacat.response()
  def remove(client, owner, repo, path, body) when is_map(body) do
    delete("repos/#{owner}/#{repo}/contents/#{path}", client, body)
  end
end
