defmodule Tentacat.Issues.LabelsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Issues.Labels

  doctest Tentacat.Issues.Labels

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start
  end

  test "list/4" do
    use_cassette "issues/labels#list" do
      assert list("sdost", "elixir-conspiracy", "1", @client) == []
    end
  end

  test "add/5" do
    use_cassette "issues/labels#add" do
      [%{"name" => name}] = add("sdost", "elixir-conspiracy", "1", ["WIP"], @client)
      assert name == "WIP"
    end
  end
end
