defmodule Tentacat.Commits do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List commits on a repository.

  ## Example

      Tentacat.Commits.list(client, "elixir-lang", "elixir")

  More info at: https://developer.github.com/v3/repos/commits/#list-commits-on-a-repository
  """
  @spec list(Client.t(), binary, binary) :: Tentacat.response()
  def list(client \\ %Client{}, owner, repo) do
    get("repos/#{owner}/#{repo}/commits", client)
  end

  @doc """
  Filter commits on a repository. Parameters are `sha`, `path`, `author`, `since`, `until`.

  ## Example

      Tentacat.Commits.filter(client, "elixir-lang", "elixir", %{sha: "my-branch"})

  More info at: https://developer.github.com/v3/repos/commits/#list-commits-on-a-repository
  """
  @spec filter(Client.t(), binary, binary, Keyword.t() | map) :: Tentacat.response()
  def filter(client \\ %Client{}, owner, repo, filters) do
    get("repos/#{owner}/#{repo}/commits?#{URI.encode_query(filters)}", client)
  end

  @doc """
  Get a single commit.

  ## Example

      Tentacat.Commits.find(client, "6dcb09b", "elixir-lang", "elixir")

  More info at: https://developer.github.com/v3/repos/commits/#get-a-commit
  """
  @spec find(Client.t(), any, binary, binary) :: Tentacat.response()
  def find(client \\ %Client{}, sha, owner, repo) do
    get("repos/#{owner}/#{repo}/commits/#{sha}", client)
  end

  @doc """
  Compare two commits.

  ## Example

      Tentacat.Commits.compare(client, base, head, "elixir-lang", "elixir")

  More info at: https://developer.github.com/v3/repos/commits/#compare-two-commits
  """
  @spec compare(Client.t(), any, any, binary, binary) :: Tentacat.response()
  def compare(client \\ %Client{}, base, head, owner, repo) do
    get("repos/#{owner}/#{repo}/compare/#{base}...#{head}", client)
  end

  @doc """
  Create a commit.

  Commit body example:

  ```elixir
  %{
    message: "my commit message",
    author: %{
      name: "Mona Octocat",
      email: "octocat@github.com",
      date: "2008-07-09T16:13:30+12:00"
    },
    parents: [
      "7d1b31e74ee336d15cbd21741bc88a537ed063a0"
    ],
    tree: "827efc6d56897b048c772eb4087f854f46256132",
    signature: "-----BEGIN PGP SIGNATURE-----\n\niQIzBAABAQAdFiEESn/54jMNIrGSE6Tp6cQjvhfv7nAFAlnT71cACgkQ6cQjvhfv\n7nCWwA//XVqBKWO0zF+bZl6pggvky3Oc2j1pNFuRWZ29LXpNuD5WUGXGG209B0hI\nDkmcGk19ZKUTnEUJV2Xd0R7AW01S/YSub7OYcgBkI7qUE13FVHN5ln1KvH2all2n\n2+JCV1HcJLEoTjqIFZSSu/sMdhkLQ9/NsmMAzpf/iIM0nQOyU4YRex9eD1bYj6nA\nOQPIDdAuaTQj1gFPHYLzM4zJnCqGdRlg0sOM/zC5apBNzIwlgREatOYQSCfCKV7k\nnrU34X8b9BzQaUx48Qa+Dmfn5KQ8dl27RNeWAqlkuWyv3pUauH9UeYW+KyuJeMkU\n+NyHgAsWFaCFl23kCHThbLStMZOYEnGagrd0hnm1TPS4GJkV4wfYMwnI4KuSlHKB\njHl3Js9vNzEUQipQJbgCgTiWvRJoK3ENwBTMVkKHaqT4x9U4Jk/XZB6Q8MA09ezJ\n3QgiTjTAGcum9E9QiJqMYdWQPWkaBIRRz5cET6HPB48YNXAAUsfmuYsGrnVLYbG+\nUpC6I97VybYHTy2O9XSGoaLeMI9CsFn38ycAxxbWagk5mhclNTP5mezIq6wKSwmr\nX11FW3n1J23fWZn5HJMBsRnUCgzqzX3871IqLYHqRJ/bpZ4h20RhTyPj5c/z7QXp\neSakNQMfbbMcljkha+ZMuVQX1K9aRlVqbmv3ZMWh+OijLYVU2bc=\n=5Io4\n-----END PGP SIGNATURE-----\n"
  }
  ```

  ## Example

      Tentacat.Commits.create(client, "elixir-lang", "elixir", body)

  More info at: https://developer.github.com/v3/git/commits/#create-a-commit
  """
  @spec create(Client.t(), binary, binary, map) :: Tentacat.response()
  def create(client \\ %Client{}, owner, repo, body) do
    post("repos/#{owner}/#{repo}/git/commits", client, body)
  end
end
