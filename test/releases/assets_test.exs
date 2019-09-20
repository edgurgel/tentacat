defmodule Tentacat.Releases.AssetsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Releases.Assets

  doctest Tentacat.Releases.Assets

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start()
  end

  test "list/4" do
    use_cassette "releases/assets#list" do
      {_, [%{"name" => name}], _} = list(@client, 2_317_862, "soudqwiggle", "elixir-conspiracy")
      assert name == "some.zip"
    end
  end

  test "find/4" do
    use_cassette "releases/assets#find" do
      {_, %{"name" => name}, _} = find(@client, 1_146_038, "soudqwiggle", "elixir-conspiracy")
      assert name == "some.zip"
    end
  end

  test "edit/6" do
    use_cassette "releases/assets#edit" do
      {_, %{"name" => name}, _} =
        edit(@client, "foo.zip", 1_146_038, "soudqwiggle", "elixir-conspiracy", [])

      assert name == "foo.zip"
    end
  end

  test "delete/4" do
    use_cassette "releases/assets#delete" do
      {status_code, _, _} = delete(@client, 1_146_038, "soudqwiggle", "elixir-conspiracy")
      assert status_code == 204
    end
  end
end
