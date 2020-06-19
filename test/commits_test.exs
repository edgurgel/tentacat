defmodule Tentacat.CommitsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Commits

  doctest Tentacat.Commits

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  test "list/3" do
    use_cassette "commits#list" do
      assert {200, [], _} = list(@client, "soudqwiggle", "elixir-conspiracy")
    end
  end

  test "filter/4" do
    use_cassette "commits#filter", match_requests_on: [:query] do
      {_, [%{"sha" => sha}], _} =
        filter(@client, "soudqwiggle", "elixir-conspiracy", %{
          sha: "09fe12ca25d0440f143ab331e4684a8622d6e4e5"
        })

      assert sha == "09fe12ca25d0440f143ab331e4684a8622d6e4e5"
    end
  end

  test "find/4" do
    use_cassette "commits#find" do
      {_, %{"sha" => sha}, _} =
        find(@client, "09fe12ca25d0440f", "soudqwiggle", "elixir-conspiracy")

      assert sha == "09fe12ca25d0440f143ab331e4684a8622d6e4e5"
    end
  end

  test "compare/5" do
    use_cassette "commits#compare" do
      {_, %{"total_commits" => total_commits}, _} =
        compare(@client, "master", "09fe12ca25d0440f", "soudqwiggle", "elixir-conspiracy")

      assert total_commits == 0
    end
  end

  test "create/4" do
    use_cassette "commits#create" do
      body = %{
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
        signature:
          "-----BEGIN PGP SIGNATURE-----\n\niQIzBAABAQAdFiEESn/54jMNIrGSE6Tp6cQjvhfv7nAFAlnT71cACgkQ6cQjvhfv\n7nCWwA//XVqBKWO0zF+bZl6pggvky3Oc2j1pNFuRWZ29LXpNuD5WUGXGG209B0hI\nDkmcGk19ZKUTnEUJV2Xd0R7AW01S/YSub7OYcgBkI7qUE13FVHN5ln1KvH2all2n\n2+JCV1HcJLEoTjqIFZSSu/sMdhkLQ9/NsmMAzpf/iIM0nQOyU4YRex9eD1bYj6nA\nOQPIDdAuaTQj1gFPHYLzM4zJnCqGdRlg0sOM/zC5apBNzIwlgREatOYQSCfCKV7k\nnrU34X8b9BzQaUx48Qa+Dmfn5KQ8dl27RNeWAqlkuWyv3pUauH9UeYW+KyuJeMkU\n+NyHgAsWFaCFl23kCHThbLStMZOYEnGagrd0hnm1TPS4GJkV4wfYMwnI4KuSlHKB\njHl3Js9vNzEUQipQJbgCgTiWvRJoK3ENwBTMVkKHaqT4x9U4Jk/XZB6Q8MA09ezJ\n3QgiTjTAGcum9E9QiJqMYdWQPWkaBIRRz5cET6HPB48YNXAAUsfmuYsGrnVLYbG+\nUpC6I97VybYHTy2O9XSGoaLeMI9CsFn38ycAxxbWagk5mhclNTP5mezIq6wKSwmr\nX11FW3n1J23fWZn5HJMBsRnUCgzqzX3871IqLYHqRJ/bpZ4h20RhTyPj5c/z7QXp\neSakNQMfbbMcljkha+ZMuVQX1K9aRlVqbmv3ZMWh+OijLYVU2bc=\n=5Io4\n-----END PGP SIGNATURE-----\n"
      }

      {status_code, %{"message" => "my commit message"}, _} =
        create(@client, "soudqwiggle", "elixir-conspiracy", body)

      assert status_code == 201
    end
  end
end
