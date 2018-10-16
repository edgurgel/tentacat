defmodule Tentacat.ClientTest do
  use ExUnit.Case
  import Tentacat.Client

  doctest Tentacat.Client

  test "default endpoint" do
    client = new()
    assert client.endpoint == "https://api.github.com/"
  end

  test "custom endpoint" do
    expected = "https://ghe.foo.com/api/v3/"

    creds  = %{user: "bob", password: "bob"}

    client = new(creds, "https://ghe.foo.com/api/v3/")
    assert client.endpoint == expected


    client = new("https://ghe.foo.com/api/v3/")
    assert client.endpoint == expected

    # when tailing '/' is missing
    client = new(creds, "https://ghe.foo.com/api/v3")
    assert client.endpoint == expected
  end
end
