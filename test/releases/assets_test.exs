defmodule Tentacat.Releases.AssetsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Releases.Assets

  doctest Tentacat.Releases.Assets

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start
  end

  test "list/4" do
    use_cassette "releases/assets#list" do
      [%{"name" => name}] = list(2317862, "soudqwiggle", "elixir-conspiracy", @client)
      assert name == "some.zip"
    end
  end

  test "find/4" do
    use_cassette "releases/assets#find" do
      %{"name" => name} = find(1146038, "soudqwiggle", "elixir-conspiracy", @client)
      assert name == "some.zip"
    end
  end

  test "edit/6" do
    use_cassette "releases/assets#edit" do
      %{"name" => name} = edit("foo.zip", 1146038, "soudqwiggle", "elixir-conspiracy", @client, [])
      assert name == "foo.zip"
    end
  end

  test "delete/4" do
    use_cassette "releases/assets#delete" do
      {status_code, _} = delete(1146038, "soudqwiggle", "elixir-conspiracy", @client)
      assert status_code == 204
    end
  end
end
