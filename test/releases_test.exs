defmodule Tentacat.ReleasesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Releases

  doctest Tentacat.Releases

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start()
  end

  test "list/3" do
    use_cassette "releases#list" do
      assert elem(list(@client, "soudqwiggle", "elixir-conspiracy"), 1) == []
    end
  end

  test "find/4" do
    use_cassette "releases#find" do
      {_, %{"tag_name" => name}, _} = find(@client, 2_317_708, "soudqwiggle", "elixir-conspiracy")
      assert name == "v1"
    end
  end

  test "latest/3" do
    use_cassette "releases#latest" do
      {_, %{"tag_name" => name}, _} = latest(@client, "soudqwiggle", "elixir-conspiracy")
      assert name == "v1.2"
    end
  end

  test "create/4" do
    use_cassette "releases#create" do
      {status_code, _, _} = create(@client, "v1", "soudqwiggle", "elixir-conspiracy")
      assert status_code == 201
    end
  end

  test "edit/5" do
    options = [tag_name: "v1.0.0"]

    use_cassette "releases#edit" do
      {_, %{"tag_name" => name}, _} =
        edit(@client, 2_317_708, "soudqwiggle", "elixir-conspiracy", options)

      assert name == "v1.0.0"
    end
  end

  test "delete/4" do
    use_cassette "releases#delete" do
      {status_code, _, _} = delete(@client, 2_317_708, "soudqwiggle", "elixir-conspiracy")
      assert status_code == 204
    end
  end
end
